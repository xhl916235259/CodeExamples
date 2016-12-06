//
//  LTTemplateLayoutCellTestController.m
//  CodeExamples
//
//  Created by letian on 16/12/4.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FDTemplateLayoutCellTestController.h"

#import "LTFeedEntity.h"
#import "LTFeedCell.h"

typedef NS_ENUM(NSInteger, LTSimulatedCacheMode) {
    LTSimulatedCacheModeNone = 0,
    LTSimulatedCacheModeCacheByIndexPath,
    LTSimulatedCacheModeCacheByKey
};

@interface FDTemplateLayoutCellTestController ()
@property (nonatomic, copy) NSArray *prototypeEntitiesFromJSON;
@property (nonatomic, strong) NSMutableArray *feedEntitySections; // 2d array
@property (nonatomic, weak) IBOutlet UISegmentedControl *cacheModeSegmentControl;

@end

@implementation FDTemplateLayoutCellTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.fd_debugLogEnabled = YES;
    
    // Cache by index path initial
    self.cacheModeSegmentControl.selectedSegmentIndex = 1;
    
    [self buildTestDataThen:^{
        self.feedEntitySections = @[].mutableCopy;
        [self.feedEntitySections addObject:self.prototypeEntitiesFromJSON.mutableCopy];
        [self.tableView reloadData];
    }];

}

- (void)buildTestDataThen:(void (^)(void))then {
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `LTFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[LTFeedEntity alloc] initWithDictionary:obj]];
        }];
        self.prototypeEntitiesFromJSON = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedEntitySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedEntitySections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LTFeedCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(LTFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row % 2 == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.entity = self.feedEntitySections[indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTSimulatedCacheMode mode = self.cacheModeSegmentControl.selectedSegmentIndex;
    switch (mode) {
        case LTSimulatedCacheModeNone:
            return [tableView fd_heightForCellWithIdentifier:@"LTFeedCell" configuration:^(LTFeedCell *cell) {
                [self configureCell:cell atIndexPath:indexPath];
            }];
        case LTSimulatedCacheModeCacheByIndexPath:
            return [tableView fd_heightForCellWithIdentifier:@"LTFeedCell" cacheByIndexPath:indexPath configuration:^(LTFeedCell *cell) {
                [self configureCell:cell atIndexPath:indexPath];
            }];
        case LTSimulatedCacheModeCacheByKey: {
            LTFeedEntity *entity = self.feedEntitySections[indexPath.section][indexPath.row];
            
            return [tableView fd_heightForCellWithIdentifier:@"LTFeedCell" cacheByKey:entity.identifier configuration:^(LTFeedCell *cell) {
                [self configureCell:cell atIndexPath:indexPath];
            }];
        };
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *mutableEntities = self.feedEntitySections[indexPath.section];
        [mutableEntities removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Actions

- (IBAction)refreshControlAction:(UIRefreshControl *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.feedEntitySections removeAllObjects];
        [self.feedEntitySections addObject:self.prototypeEntitiesFromJSON.mutableCopy];
        [self.tableView reloadData];
        [sender endRefreshing];
    });
}

- (IBAction)rightNavigationItemAction:(id)sender {
   [[[UIActionSheet alloc]
      initWithTitle:@"Actions"
      delegate:nil
      cancelButtonTitle:@"Cancel"
      destructiveButtonTitle:nil
      otherButtonTitles:
      @"Insert a row",
      @"Insert a section",
      @"Delete a section", nil] showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    SEL selectors[] = {
        @selector(insertRow),
        @selector(insertSection),
        @selector(deleteSection)
    };
    
    if (buttonIndex < sizeof(selectors) / sizeof(SEL)) {
        void(*imp)(id, SEL) = (typeof(imp))[self methodForSelector:selectors[buttonIndex]];
        imp(self, selectors[buttonIndex]);
    }
}

- (LTFeedEntity *)randomEntity {
    NSUInteger randomNumber = arc4random_uniform((int32_t)self.prototypeEntitiesFromJSON.count);
    LTFeedEntity *randomEntity = self.prototypeEntitiesFromJSON[randomNumber];
    return randomEntity;
}

- (void)insertRow {
    if (self.feedEntitySections.count == 0) {
        [self insertSection];
    } else {
        [self.feedEntitySections[0] insertObject:self.randomEntity atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)insertSection {
    [self.feedEntitySections insertObject:@[self.randomEntity].mutableCopy atIndex:0];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteSection {
    if (self.feedEntitySections.count > 0) {
        [self.feedEntitySections removeObjectAtIndex:0];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
