//
//  PopularTab.h
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopularTab : UIViewController

@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *eventCountLabel;
@property (nonatomic, strong) NSString *stringLocation;
@property (nonatomic, strong) NSMutableArray *popularityEventArr;
@property (nonatomic, assign) BOOL isBookmark;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, copy) NSString *userLocationCity;

@property (nonatomic, strong) NSMutableArray *PopularSortArray;
@end
