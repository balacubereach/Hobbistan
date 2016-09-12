//
//  NearbyTab.m
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "NearbyTab.h"
#import "EventCell.h"
#import "SVPullToRefresh.h"
#import "Event.h"
#import "EventDetail.h"

#import "HMSegmentedControl.h"
#import "MapEvents.h"
#import "UIView+Extra.h"
#import "UIView+Contrains.h"

static NSString *const kDevicellIndentifier = @"EventCell";

@interface NearbyTab ()

@property(nonatomic) NSInteger currentPage, totalCount;
@property(nonatomic) BOOL isRefresh;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) MapEvents *mapViewFormat;

@end

@implementation NearbyTab

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _NearEventArray =[NSMutableArray new];
    
    [_tableView registerNib:[UINib nibWithNibName:kDevicellIndentifier bundle:nil] forCellReuseIdentifier:kDevicellIndentifier];
    _nearEventArr   = [[NSMutableArray alloc] init];
    [self addPullToRefresh];
    [self.tableView triggerPullToRefresh];
    
    [self mapSegmentView];
}

- (void)mapSegmentView {
    
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"list-white1"],
                                                                                [UIImage imageNamed:@"locationview-icon-nearby"]]
                                                        sectionSelectedImages:@[[UIImage imageNamed:@"list-white"],
                                                                                [UIImage imageNamed:@"location-white"]]];
        _segmentedControl.frame = CGRectMake(0, 0, _segmentView.bounds.size.width, _segmentView.bounds.size.height);
        [_segmentedControl setRoundCorner:_segmentedControl.bounds.size.height/2 boderColor:[UIColor grayColor]];
        _segmentedControl.selectionIndicatorHeight = _segmentView.bounds.size.width;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
        _segmentedControl.selectionIndicatorColor = [UIColor redColor];
        
        [self.segmentView addSubview:_segmentedControl];
        __weak typeof(self) weakSelf = self;
        [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
            if (index == 0) {
                
                [weakSelf TableViewFormatNear];
                [weakSelf.view bringSubviewToFront:weakSelf.tableView];
            } else {
                
                [weakSelf MapFormatNear];
                [weakSelf.view bringSubviewToFront:weakSelf.mapViewFormat.view];
            }
            
        }];
        [self.view layoutIfNeeded];
    }
}


- (void)TableViewFormatNear {
    
    self.tableView.hidden = false;
    self.mapViewFormat.view.hidden = true;
    
    if (!_tableView) {
        __weak typeof(self)wSelf    = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            
            self.isRefresh = YES;
            self.currentPage = 1;
            [wSelf loadHomeEvent:self.currentPage];
        }];
 
        [_contentViewNear addSubview:_tableView];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentViewNear subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentViewNear subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentViewNear subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentViewNear subview:_tableView constant:0];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}

- (void)MapFormatNear {
    
    self.tableView.hidden = true;
    self.mapViewFormat.view.hidden = false;
    
    if (!_mapViewFormat) {
        __weak typeof(self)wSelf    = self;
        _mapViewFormat    = [[MapEvents alloc] initWithCompletion:^(void(^finish) (NSMutableArray *data)){
            finish(_nearEventArr);
        } updateLocationBlock:^(NSString *location) {
            wSelf.locationNear  = location;
             [wSelf updateEventsCount];
        }];
        [self addChildViewController:_mapViewFormat];
        [_contentViewNear addSubview:_mapViewFormat.view];
        [_mapViewFormat didMoveToParentViewController:self];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentViewNear subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentViewNear subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentViewNear subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentViewNear subview:_mapViewFormat.view constant:0];
        [_mapViewFormat.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}

- (void)updateEventsCount{
    
    [_neareventlbl setText:[NSString stringWithFormat:@"%lu Results of Popular Events ", (unsigned long)[_nearEventArr count]]];
    
}

- (void)addPullToRefresh {
    __weak typeof(self)wSelf    = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        self.isRefresh = YES;
        self.currentPage = 1;
        [wSelf loadHomeEvent:self.currentPage];
    }];
}

- (void)loadEventData {
    
}

#pragma tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [_nearEventArr count];
    
    //return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [_tableView dequeueReusableCellWithIdentifier:kDevicellIndentifier];
    Event *event = [_nearEventArr objectAtIndex:indexPath.row];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, 5)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    
    [cell configCellWithEvent:event];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    appDelegate.selectedTabDetail = @"";
    
    EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
    Event *event = [_nearEventArr objectAtIndex:indexPath.row];
    eventDetail.eventObject = event;
    [self.navigationController pushViewController:eventDetail  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHomeEvent:(NSInteger)page {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    //NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=event_management&event_type=all&user_id=%@&page_id=%ld",kBaseAppUrl, appDel.user.userId, (long)page];
    
   // NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=event_management&event_type=all&user_id=%@&page_id=%ld", appDel.user.userId, (long)page];
    
    NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/api_26_04-2016.php?func_name=event_management&event_type=all&user_id=%@&page_id=%ld", appDel.user.userId, (long)page];
    
    
    //
    
    NSLog(@" %@",apiUrl);
    
    __weak typeof(self)wSelf    = self;
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
        NSArray *events = [resultDic objectForKey:@"events"];
        if (events) {

            if (self.isRefresh) {
                [wSelf.nearEventArr removeAllObjects];
                wSelf.isRefresh = NO;
            }
            
            
//            for (NSMutableDictionary *dic in eventRslts) {
//                
//                if (dic.count > 0){
//                    
//                    if(!(dic[@"event_latitude"] == [NSNull null] ||
//                         dic[@"event_longitude"] == [NSNull null])) {
//                        
//                        NSLog(@"lat %@",dic[@"event_latitude"]);
//                        NSLog(@"long %@",dic[@"event_longitude"]);
//                        
//                        NSLog(@"app %@",appDelegate.userLocation);
//                        
//                        CLLocation *destLcoation=[[CLLocation alloc]initWithLatitude:[dic[@"event_latitude"] doubleValue]
//                                                                           longitude:[dic[@"event_longitude"] doubleValue]];
//                        CLLocationDistance distance=[appDelegate.userLocation distanceFromLocation:destLcoation];
//                        
//                        // NSNumber *dis  = [NSNumber numberWithDouble:distance];
//                        
//                        NSString *dis =[NSString stringWithFormat:@"%.6f",distance];
//                        
//                        NSLog(@"%@",dis);
//                        
//                        [dic setObject:dis forKey:@"distance"];
//                        
//                        [_NearEventArray addObject:dic];
//                        
//                    }
//                    
//                }
//            }
            
            
         //   NSSortDescriptor  *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
         //   NSArray *events = [_NearEventArray sortedArrayUsingDescriptors:@[brandDescriptor]];
            
            NSLog(@"%@",events);
            
            self.totalCount = [[resultDic objectForKey:@"count"] integerValue];
            for (NSDictionary *dic in events) {
                if (dic.count > 0){
                
                Event *event    = [[Event alloc] initWithDictionary:dic];
                [wSelf.nearEventArr addObject:event];
                }
            }
        }
        
        [wSelf.tableView reloadData];
        
        [self updateEventsCount];
        [[UIHelper sharedInstance] hideHudInView:self.view];
        [wSelf.tableView.pullToRefreshView stopAnimating];

    }
    withFailure:^(NSError * _Nonnull error) {
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.totalCount > self.nearEventArr.count) {

        if (indexPath.row == [self.nearEventArr count] - 1 ) {
            
            [self loadHomeEvent:++self.currentPage];
        }
    }
}

@end
