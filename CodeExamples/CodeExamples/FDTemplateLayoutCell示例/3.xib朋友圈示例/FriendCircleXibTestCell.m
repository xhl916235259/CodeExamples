//
//  FriendCircleXibTestCell.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/6.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleXibTestCell.h"
#import "FriendCircleImageView.h"
#import "FriendCircleModel.h"

@interface FriendCircleXibTestCell ()

/** <#des#> */
@property (nonatomic,weak) IBOutlet UIImageView * iconView;

/** <#des#> */
@property (nonatomic,weak) IBOutlet UILabel * nameLabel;

/** <#des#> */
@property (nonatomic,weak) IBOutlet UILabel * contentLabel;

/** 全文/收起 */
@property (nonatomic,weak) IBOutlet UIButton * allContentButton;

/** <#des#> */
@property (nonatomic,weak) IBOutlet UILabel * timeLabel;

/** <#des#> */
@property (nonatomic,weak) IBOutlet FriendCircleImageView * friendCircleImageView;

/** <#des#> */
@property (nonatomic,strong) FriendCircleModel * model;

/** <#des#> */
@property (nonatomic,copy) dispatch_block_t btClickBlock;

@end

@implementation FriendCircleXibTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentLabel.backgroundColor = [UIColor yellowColor];
    self.allContentButton.backgroundColor = [UIColor redColor];
    
    [self.allContentButton bk_whenTapped:^{
        self.model.select = !self.model.select;
        if (self.btClickBlock) {
            self.btClickBlock();
        }
    }];
}

- (void)cellDataWithModel:(FriendCircleModel *)model
{
    self.model = model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",model.name,model.personalizedSignature];
    self.iconView.image = [UIImage imageNamed:model.icon];
    self.contentLabel.text = model.content;
    [self.friendCircleImageView cellDataWithImageArray:model.images];
    self.timeLabel.text = model.time;
    
    //此处注释打开实现查看更多与收起功能
//    [self layoutUI];
}

- (void)layoutUI
{
    //计算正文高度
    CGFloat contentHeight = [self contentHeight:self.model.content];
    //friendCircleImageView 图片参照view
    UIView * targetViewOfFriendCircleImageView;
    //如果大于60  显示全部查看按钮
    if (contentHeight >60) {
        [self.allContentButton setTitle:@"查看全部" forState:UIControlStateNormal];
        [self.allContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
        }];
        //限制正文label高度小于60
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(60);
        }];
        targetViewOfFriendCircleImageView = self.allContentButton;
        
    } else{
        [self.allContentButton setTitle:@"" forState:UIControlStateNormal];
        [self.allContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        //这里得重置contentLabel的约束
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.nameLabel);
            make.width.mas_lessThanOrEqualTo([self contentLabelMaxWidth]);
        }];
        targetViewOfFriendCircleImageView = self.contentLabel;
        
    }
    //设置friendCircleImageView 参数
    [self.friendCircleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(targetViewOfFriendCircleImageView.mas_bottom).offset(10);
        make.right.left.equalTo(self.nameLabel);
        
    }];
    
    //如果 "查看全部" 按钮被点击 则重置label约束
    if (self.model.isSelect == YES) {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.nameLabel);
            make.width.mas_lessThanOrEqualTo([self contentLabelMaxWidth]);
        }];
        [self.allContentButton setTitle:@"收起" forState:UIControlStateNormal];
    }
    //timeLabel 参照View
    UIView * targetViewOfTimeLabel;
    //如果没有图片并且正文高度大于60
    if (self.model.images.count == 0 && contentHeight > 60) {
        targetViewOfTimeLabel = self.allContentButton;
        //如果没有图片并且正文内容小于等于60
    } else if (self.model.images.count == 0 && contentHeight <= 60) {
        targetViewOfTimeLabel = self.contentLabel;
        //如果有图片
    } else {
        targetViewOfTimeLabel = self.friendCircleImageView;
    }
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.nameLabel);
        make.top.equalTo(targetViewOfTimeLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

- (void)cellClickBt:(dispatch_block_t)clickBtBlock
{
    self.btClickBlock = clickBtBlock;
}

- (CGFloat)contentHeight:(NSString *)content
{
    CGRect textRect = [content boundingRectWithSize:CGSizeMake([self contentLabelMaxWidth], MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil];
    return textRect.size.height;
}

- (CGFloat)contentLabelMaxWidth
{
    return SCREEN_WIDTH - 10 -50 -10 -10;
}


@end
