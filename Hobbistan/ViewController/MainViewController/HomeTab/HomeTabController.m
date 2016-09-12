//
//  HomeTabController.m
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "HomeTabController.h"
#import "EventCell.h"
#import "SVPullToRefresh.h"
#import "Event.h"
#import "EventDetail.h"

#import "HMSegmentedControl.h"
#import "MapEvents.h"
#import "UIView+Extra.h"
#import "UIView+Contrains.h"

static NSString *const kDevicellIndentifier = @"EventCell";

@interface HomeTabController () 

@property(nonatomic) NSInteger currentPage, totalCount;
@property(nonatomic) BOOL isRefresh;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) MapEvents *mapViewFormat;

@end

@implementation HomeTabController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _HomeEventArray = [[NSMutableArray alloc] init];

    [_tableView registerNib:[UINib nibWithNibName:kDevicellIndentifier bundle:nil] forCellReuseIdentifier:kDevicellIndentifier];
    
   
    
    if (self.isSearch) {
        
        [self.navigationController setLeftTitle:@"SEARCH RESULT"];
        [self.tableView reloadData];
    }
    else {
        
        _homeEventArr   = [[NSMutableArray alloc] init];
        [self addPullToRefresh];
        [self.tableView triggerPullToRefresh];
    }
    
     [self mapSegmentView];

}
- (void)mapSegmentView
{
    
    if (!_segmentedControl)
    {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"list-white1"],
                                                                                [UIImage imageNamed:@"locationview-icon-nearby"]]
                                                        sectionSelectedImages:@[[UIImage imageNamed:@"list-white"],
                                                                                [UIImage imageNamed:@"location-white"]]];
        _segmentedControl.frame = CGRectMake(0, 0, _segmentView1.bounds.size.width, _segmentView1.bounds.size.height);
        [_segmentedControl setRoundCorner:_segmentedControl.bounds.size.height/2 boderColor:[UIColor grayColor]];
        _segmentedControl.selectionIndicatorHeight = _segmentView1.bounds.size.width;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
       // _segmentedControl.selectionIndicatorColor = [UIColor redColor];
        
        _segmentedControl.selectionIndicatorColor =[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
        
        [self.segmentView1 addSubview:_segmentedControl];
        
        __weak typeof(self) weakSelf = self;
        [self.segmentedControl setIndexChangeBlock:^(NSInteger index)
        {
            if (index == 0) {
                
                [weakSelf SHOWTableViewFormat];
                [weakSelf.view bringSubviewToFront:weakSelf.tableView];
            } else {
                
                [weakSelf showMapFormat];
                [weakSelf.view bringSubviewToFront:weakSelf.mapViewFormat.view];
            }
            
        }];
        [self.view layoutIfNeeded];
    }
}


- (void)SHOWTableViewFormat {
    
    self.tableView.hidden = false;
    self.mapViewFormat.view.hidden = true;
    
    if (!_tableView) {
        __weak typeof(self)wSelf    = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            
            self.isRefresh = YES;
            self.currentPage = 1;
            [wSelf loadHomeEvent:self.currentPage];
        }];
        [_contentView1 addSubview:_tableView];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentView1 subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentView1 subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentView1 subview:_tableView constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentView1 subview:_tableView constant:0];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}
- (void)showMapFormat {
    
    self.tableView.hidden = true;
    self.mapViewFormat.view.hidden = false;
  
    if (!_mapViewFormat) {
        __weak typeof(self)wSelf    = self;
        _mapViewFormat    = [[MapEvents alloc] initWithCompletion:^(void(^finish) (NSMutableArray *data)){
            
            finish(_homeEventArr);
            
            
        } updateLocationBlock:^(NSString *location) {
            wSelf.locationString  = location;
            [wSelf updateEventsCount];
        }];
        [self addChildViewController:_mapViewFormat];
        [_contentView1 addSubview:_mapViewFormat.view];
        [_mapViewFormat didMoveToParentViewController:self];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentView1 subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentView1 subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentView1 subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentView1 subview:_mapViewFormat.view constant:0];
        [_mapViewFormat.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}


- (void)updateEventsCount{
    
        [_eventsLable setText:[NSString stringWithFormat:@"%lu Results of Favorites Events ", (unsigned long)[_homeEventArr count]]];
    
}

- (void)addPullToRefresh
{
    
 //  self.mapViewFormat.view.hidden = true;
    
    __weak typeof(self)wSelf    = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        
        self.currentPage = 1;
        self.isRefresh = YES;
        
        if (self.isBookmark) {
            [self.navigationController setLeftTitle:@"WISHLIST"];
            [self loadBookmarkEvent];
        }
        else {
            
            [wSelf loadHomeEvent:self.currentPage];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isBookmark) {
        [self.navigationController setLeftTitle:@"WISHLIST"];
    }
    
}

#pragma tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_homeEventArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EventCell *cell = [_tableView dequeueReusableCellWithIdentifier:kDevicellIndentifier];
    Event *event = [_homeEventArr objectAtIndex:indexPath.row];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 5)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
    
    
   // if (self.isBookmark) {
    
   // [cell configCellWithEventwithoutDate:event];
   
    //}else{
        
        [cell configCellWithEvent:event];
    //}
   // [self callpopup];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    appDelegate.selectedTabDetail = @"";
    
    EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
    Event *event = [_homeEventArr objectAtIndex:indexPath.row];
    eventDetail.eventObject = event;
    
    
    
    [self.navigationController pushViewController:eventDetail  animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHomeEvent:(NSInteger)page {
 
    AppDelegate *appDel = appDelegate;
  //  NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=event_management&event_type=preference&user_id=%@&city=%@&page_id=%ld",kBaseAppUrl, appDel.user.userId, [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"], (long)page];
    
//     NSString *apiUrl = [NSString stringWithFormat:@"%s?func_name=event_management&event_type=preference&user_id=%@&city=%@&page_id=%ld","http://hobbistan.com/uitouxcall.php", appDel.user.userId, [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"], (long)page];
    
    
    NSString *apiUrl = [NSString stringWithFormat:@"%s?func_name=event_management&event_type=preference&user_id=%@&city=%@&page_id=%ld","http://hobbistan.com/app/hobbistan/api_26_04-2016.php", appDel.user.userId, [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"], (long)page];
    
    
 //   http://hobbistan.com/uitouxcall.php?func_name=event_management&event_type=preference&user_id=586&city=coimbatore&page_id=1
    
    
    NSLog(@"Home %@",apiUrl);
    
    [self loadEvents:apiUrl];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.totalCount > self.homeEventArr.count) {
        
        if (indexPath.row == [self.homeEventArr count] - 1 ) {
            
            [self loadHomeEvent:++self.currentPage];
        }
    }
}

- (void)loadBookmarkEvent {
    
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=fetch_event_bookmark&user_id=%@",kBaseAppUrl, appDel.user.userId];
    
    NSLog(@"apiUrl %@",apiUrl);
    
    [self loadEvents:apiUrl];
}

- (void)loadEvents:(NSString *)apiUrl {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;

    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    __weak typeof(self)wSelf    = self;
    [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
        
        
        
        if ([[resultDic objectForKey:@"events"] isKindOfClass:[NSArray class]] == YES){
            
        
        NSArray *events = [resultDic objectForKey:@"events"];
        NSLog(@"%@",events);
//        
//        
//        for (NSMutableDictionary *dic in eventRslts) {
//            
//            if (dic.count > 0){
//                
//                if(!(dic[@"event_latitude"] == [NSNull null] ||
//                     dic[@"event_longitude"] == [NSNull null])) {
//                    
//                       NSLog(@"lat %@",dic[@"event_latitude"]);
//                       NSLog(@"long %@",dic[@"event_longitude"]);
//                    
//                     NSLog(@"app %@",appDelegate.userLocation);
//                    
//                    CLLocation *destLcoation=[[CLLocation alloc]initWithLatitude:[dic[@"event_latitude"] doubleValue]
//                                                                       longitude:[dic[@"event_longitude"] doubleValue]];
//                    CLLocationDistance distance=[appDelegate.userLocation distanceFromLocation:destLcoation];
//                    
//                    // NSNumber *dis  = [NSNumber numberWithDouble:distance];
//                    
//                    NSString *dis =[NSString stringWithFormat:@"%.6f",distance];
//                    
//                    NSLog(@"%@",dis);
//                    
//                     [dic setObject:dis forKey:@"distance"];
//                    
//                    [_HomeEventArray addObject:dic];
//                    
//                }
//                
//            }
//        }
//        
////        events = [events subarrayWithRange:NSMakeRange(1, events.count - 1)];
////
//        NSSortDescriptor  *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
//       NSArray *events = [_HomeEventArray sortedArrayUsingDescriptors:@[brandDescriptor]];
//        
       NSLog(@"%@",events);
        
        if (events != [NSNull class]) {
            
            if (self.isRefresh) {
                
                [wSelf.homeEventArr removeAllObjects];
                wSelf.isRefresh = NO;
                
            }
            
            self.totalCount = [[resultDic objectForKey:@"count"] integerValue];
            
            
            for (NSMutableDictionary *dic in events) {
                if (dic.count > 0){
                    
                    Event *event    = [[Event alloc] initWithDictionary:dic];
                    [wSelf.homeEventArr addObject:event];
                }
            }


            }
        
        [wSelf.tableView reloadData];
        
        [wSelf updateEventsCount];
       
        }

        [wSelf.tableView.pullToRefreshView stopAnimating];
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
                        withFailure:^(NSError * _Nonnull error) {
                            
                            [wSelf.tableView.pullToRefreshView stopAnimating];
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }];

}


- (IBAction)backbuttonAction {
    
    [appDelegate initMainScreen];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isBookmark) {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this

        Event *event = _homeEventArr[indexPath.row];
        [self removeBookmarkAction:event];
    }
}

- (void)removeBookmarkAction:(Event *)event {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=remove_event_from_bookmark&user_id=%@&event_id=%@",kBaseAppUrl,appDel.user.userId, event.eventId];
    
    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
        
        [_homeEventArr removeObject:event];
        [self.tableView reloadData]; // tell table to refresh now
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
                            
        NSLog(@"error %@",error);
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
}
- (IBAction)closebtn:(id)sender
{
    self.popUpView.hidden = YES;
}
@end
