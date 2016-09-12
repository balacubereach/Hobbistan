//
//  MapEvents.h
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "PopularTab.h"

typedef void(^currentLocationBlock)(NSString * location);

@interface MapEvents : UIViewController
@property (weak, nonatomic) PopularTab *popularTab;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, copy) currentLocationBlock currentLocationBlock;
@property (nonatomic, strong) NSMutableArray *popularityEventArr;

@property (nonatomic, assign) BOOL  isBookMark;
- (id)initWithCompletion:(void(^)(void(^finish) (NSMutableArray *data)))completion updateLocationBlock:(currentLocationBlock)block;
- (void)annotationAction:(CLLocationDegrees)latitude  longitude:(CLLocationDegrees)longitude;
@end
