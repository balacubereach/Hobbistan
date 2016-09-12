//
//  PopularTab.m
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "PopularTab.h"
#import "SVPullToRefresh.h"
#import "Event.h"
#import "HMSegmentedControl.h"
#import "PopularTableFomat.h"
#import "MapEvents.h"
#import "UIView+Contrains.h"
#import "UIView+Extra.h"

static NSString *const kDevicellIndentifier = @"EventCell";

@interface PopularTab () <CLLocationManagerDelegate>

@property(nonatomic) NSInteger currentPage, totalCount;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) PopularTableFomat *tableFormat;
@property (nonatomic, strong) MapEvents *mapViewFormat;
@property (nonatomic, copy) reQuestNewData requestNewData;

@property(nonatomic) BOOL isRefresh;
@end

@implementation PopularTab

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _PopularSortArray  = [[NSMutableArray alloc] init];
    
    self.currentPage = 1;

    _popularityEventArr   = [[NSMutableArray alloc] init];
    [self setupSegmentView];
    [self addTableViewFormat];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    self.locationManager.distanceFilter = 500;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)viewDidLayoutSubviews {
    [self setupSegmentView];
}

- (void)setupSegmentView {
    
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
                [weakSelf addTableViewFormat];
                [weakSelf.contentView bringSubviewToFront:weakSelf.tableFormat.view];
            } else {
                [weakSelf addMapFormat];
                [weakSelf.contentView bringSubviewToFront:weakSelf.mapViewFormat.view];
            }
            
        }];
        [self.view layoutIfNeeded];
    }
}

- (void)addTableViewFormat {
    if (!_tableFormat) {
        __weak typeof(self)wSelf    = self;
        _tableFormat    = [[PopularTableFomat alloc] initWithBlock:^(reQuestNewData reQuestNewData) {
            _requestNewData = reQuestNewData;
            
            self.isRefresh = YES;
            self.currentPage = 1;
            [wSelf loadHomeEvent:self.currentPage];
        }];
        [self addChildViewController:_tableFormat];
        [_contentView addSubview:_tableFormat.view];
        [_tableFormat didMoveToParentViewController:self];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentView subview:_tableFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentView subview:_tableFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentView subview:_tableFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentView subview:_tableFormat.view constant:0];
        [_tableFormat.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}

- (void)addMapFormat {
    if (!_mapViewFormat) {
        __weak typeof(self)wSelf    = self;
        _mapViewFormat    = [[MapEvents alloc] initWithCompletion:^(void(^finish) (NSMutableArray *data)){
            finish(_popularityEventArr);
        } updateLocationBlock:^(NSString *location) {
            wSelf.stringLocation    = location;
            [wSelf updateEventsCount];
        }];
        [self addChildViewController:_mapViewFormat];
        [_contentView addSubview:_mapViewFormat.view];
        [_mapViewFormat didMoveToParentViewController:self];
        [UIView addEdgeConstraint:NSLayoutAttributeTop superview:_contentView subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeRight superview:_contentView subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeLeft superview:_contentView subview:_mapViewFormat.view constant:0];
        [UIView addEdgeConstraint:NSLayoutAttributeBottom superview:_contentView subview:_mapViewFormat.view constant:0];
        [_mapViewFormat.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}
- (void)loadHomeEvent:(NSInteger)page {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
   
  //  NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=event_management&event_type=all&user_id=%@&page_id=%ld&city=%@",kBaseAppUrl, appDel.user.userId, (long)page,self.userLocationCity];
    
    
  //  NSString *apiUrl =  [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=event_management_static&event_type=static_event&user_id=586&city=coimbatore&page_id=1"];
    
//     NSString *apiUrl =  [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=event_management_static&event_type=static_event&user_id=%@&city=%@&page_id=%ld",appDel.user.userId,[[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"],(long)page];
    
     NSString *apiUrl =  [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/api_26_04-2016.php?func_name=event_management_static&event_type=static_event&user_id=%@&city=%@&page_id=%ld",appDel.user.userId,[[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"],(long)page];
    
    
    //
    
    
    NSLog(@"%@",apiUrl);
    
    __weak typeof(self)wSelf    = self;
    
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
        
       // CLLocationDistance filterRadius= 1609.344*35;
        
        
        NSLog(@"%@",[resultDic objectForKey:@"events"]);
        
    if([[resultDic objectForKey:@"events"] isKindOfClass:[NSArray class]]){
        

        NSArray *events = [resultDic objectForKey:@"events"];
        
        [wSelf.popularityEventArr removeAllObjects];
        
      //  [_PopularSortArray removeAllObjects];
        
//        for (NSMutableDictionary *dic in eventRslts) {
//            
//            if (dic.count > 0){
//                
//                if(!(dic[@"event_latitude"] == [NSNull null] ||
//                     dic[@"event_longitude"] == [NSNull null])) {
//                    
//                    NSLog(@"lat %@",dic[@"event_latitude"]);
//                    NSLog(@"long %@",dic[@"event_longitude"]);
//                    
//                    NSLog(@"app %@",appDelegate.userLocation);
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
//                    [dic setObject:dis forKey:@"distance"];
//                    
//                    [_PopularSortArray addObject:dic];
//                    
//                }
//                
//            }
//        }
        
        //        events = [events subarrayWithRange:NSMakeRange(1, events.count - 1)];
        //
      //  NSSortDescriptor  *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
      //  NSArray *events = [_PopularSortArray sortedArrayUsingDescriptors:@[brandDescriptor]];
        
     //   NSLog(@"%@",events);
        
        if (events) {
            
            if (self.isRefresh) {
                
                self.isRefresh = NO;
                [wSelf.popularityEventArr removeAllObjects];
            }
            
            self.totalCount = [[resultDic objectForKey:@"count"] integerValue];
           
            
            for (NSDictionary *dic in events) {
                
              //  NSLog(@"%@",appDelegate.userLocation);
                
                if (dic.count > 0){
                
               // if(!(dic[@"event_latitude"] == [NSNull null] || dic[@"event_longitude"] == [NSNull null])) {
                    
                  //  CLLocation *destLcoation=[[CLLocation alloc]initWithLatitude:[dic[@"event_latitude"] doubleValue]
                                                                   //   longitude:[dic[@"event_longitude"] doubleValue]];
                  //  CLLocationDistance distance=[appDelegate.userLocation distanceFromLocation:destLcoation];
                    
                   // if (distance < filterRadius) {
                        
                        Event *event    = [[Event alloc] initWithDictionary:dic];
                        [wSelf.popularityEventArr addObject:event];
                    
                   // }
                
               // }
                    
                }
            }
        }
       
        }
        
        NSLog(@"%@",_popularityEventArr);
        
        [self updateWithNewData];
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@error",error);
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
        
    
}

- (void)updateEventsCount{
    if ([_stringLocation length] > 0) {
        [_eventCountLabel setText:[NSString stringWithFormat:@"%lu Results of Hotspot Events %@", (unsigned long)[_popularityEventArr count],_stringLocation]];
    } else {
        [_eventCountLabel setText:[NSString stringWithFormat:@"%lu Results of Hotspot Events ", (unsigned long)[_popularityEventArr count]]];
    }
    
}

- (void)updateWithNewData {
    [self updateEventsCount];
    if (_segmentedControl.selectedSegmentIndex == 0) {
        if (_requestNewData) {
            _requestNewData(_popularityEventArr);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.totalCount > self.popularityEventArr.count) {
        
        if (indexPath.row == [self.popularityEventArr count] - 1 ) {
            
            [self loadHomeEvent:++self.currentPage];
        }
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations firstObject];
    appDelegate.userLocation = currentLocation;
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            self.userLocationCity = self.placemark.locality.lowercaseString;
            
            self.isRefresh = YES;
            self.currentPage = 1;
            [self.popularityEventArr removeAllObjects];
            
            if (!self.isBookmark) {
                [self loadHomeEvent:self.currentPage];
            }
        }
        else {
            
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
//    [self.locationManager stopUpdatingLocation];
}

@end
