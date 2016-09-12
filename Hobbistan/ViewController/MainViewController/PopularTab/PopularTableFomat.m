//
//  PopularTableFomat.m
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "PopularTableFomat.h"
#import "EventCell.h"
#import "SVPullToRefresh.h"
#import "Event.h"
#import "EventDetail.h"

static NSString *const kDevicellIndentifier = @"EventCell";

@interface PopularTableFomat ()
@property (nonatomic, strong) NSMutableArray *popularityEventArr;
@end

@implementation PopularTableFomat

- (id)initWithBlock:(refreshData) refreshData {
    
    self    = [self init];
    if (self) {
        self.refreshData    = refreshData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:kDevicellIndentifier bundle:nil] forCellReuseIdentifier:kDevicellIndentifier];
    _popularityEventArr   = [[NSMutableArray alloc] init];
    [self setNewData];
    [self setupPullToRefresh];
}

- (void)setupPullToRefresh{
    [self addPullToRefresh];
    [self.tableView triggerPullToRefresh];
}

- (void)addPullToRefresh {
    __weak typeof(self)wSelf    = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        [wSelf refreshEventData];
    }];
}

- (void)refreshEventData {
    if (_refreshData) {
        _refreshData(_reQuestNewData);
    }
}

- (void)setNewData {
    __weak typeof(self)wSelf    = self;
    _reQuestNewData = ^(NSMutableArray *newData) {
        wSelf.popularityEventArr = newData;
        [wSelf.tableView reloadData];
        [wSelf.tableView.pullToRefreshView stopAnimating];
    };
}

#pragma tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return [_popularityEventArr count];
    
    
   // return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [_tableView dequeueReusableCellWithIdentifier:kDevicellIndentifier];
    Event *event = [_popularityEventArr objectAtIndex:indexPath.row];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 5)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    
    [cell configCellWithEventwithoutDate:event];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     appDelegate.selectedTabDetail = @"StaticTab";
    
    EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
    Event *event = [_popularityEventArr objectAtIndex:indexPath.row];
    eventDetail.eventObject = event;
    [self.navigationController pushViewController:eventDetail  animated:YES];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
