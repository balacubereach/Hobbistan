//
//  MapEvents.m
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//

#import "MapEvents.h"
#import "Event.h"
#import "AnnotationView.h"
#import "EventDetail.h"
#define kDefaultDistance 100.0 // Will notify the LocationManager every 100 meters

@interface MapEvents ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isadded;
@end

@implementation MapEvents

- (id)initWithCompletion:(void(^)(void(^finish) (NSMutableArray *data)))completion updateLocationBlock:(currentLocationBlock)block{
    self    = [super init];
    if (self) {
        completion(^(NSMutableArray *data) {
            
          NSLog(@"%@",data);
            
            self.popularityEventArr = data;
        });
        _currentLocationBlock   = block;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.mapView.delegate   = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.mapView.showsUserLocation  = YES;

    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.distanceFilter = kDefaultDistance;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
    
    
}

- (void)showAllAnnotation {
    
    if (!self.isadded) {

        CLLocationDistance filterRadius= 1000*35;
        
        if (self.isBookMark) {

            [self addPinWithEvent:_popularityEventArr[0]];
        }
        else {
            
            for (Event *event in _popularityEventArr) {
                
                if( (event.eventLatitude && event.eventLongitude) && event.eventLatitude.doubleValue != 0.0 & event.eventLongitude.doubleValue != 0.0)  {
                    
                    CLLocation *destLcoation=[[CLLocation alloc]initWithLatitude:[event.eventLatitude doubleValue] longitude:[event.eventLongitude doubleValue]];
                    CLLocationDistance distance=[self.locationManager.location distanceFromLocation:destLcoation];
                    
                    //if (distance < filterRadius) {
                        
                        [self addPinWithEvent:event];
                   // }
                }
            }
        }

    }

}

-(void)addPinWithEvent:(Event *)event
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([event.eventLatitude doubleValue], [event.eventLongitude doubleValue]);
    
    NSLog(@" %@",event.eventVenue);
    
    mapPin.title = event.eventVenue;
    mapPin.subtitle = event.eventName;
    mapPin.coordinate = coordinate;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotation:mapPin];
    });
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (annotation == _mapView.userLocation) {
        return nil; // Let map view handle user location annotation
    }
    
    // Identifyer for reusing annotationviews
    static NSString *annotationIdentifier = @"EventAnnotation";
    
    // Check in queue if there is an annotation view we already can use, else create a new one
    AnnotationView *annotationView = (AnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!annotationView) {
        annotationView = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier delegate:self];
        annotationView.canShowCallout = YES;
    }
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    MKPointAnnotation *mapPin = (MKPointAnnotation *)view.annotation;
    for (Event *event in _popularityEventArr) {
        
        if( ([event.eventLatitude doubleValue] == mapPin.coordinate.latitude &&
             [event.eventLongitude doubleValue] == mapPin.coordinate.longitude )) {
            
             appDelegate.selectedTabDetail = @"";
        
            EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
            eventDetail.eventObject = event;
            [self.navigationController pushViewController:eventDetail  animated:YES];
            break;
        }
    }
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.5f, 0.5))animated:YES];
    
    [ self.locationManager stopUpdatingLocation];
    
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    [self showAllAnnotation];

    MKMapPoint annotationPoint = MKMapPointForCoordinate(_mapView.userLocation.coordinate);
    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1); 
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [_mapView setVisibleMapRect:zoomRect animated:NO];
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.span.latitudeDelta = _mapView.region.span.latitudeDelta * 1.5;
    region.span.longitudeDelta = _mapView.region.span.longitudeDelta * 1.5;
    region.center.latitude = _mapView.centerCoordinate.latitude ;
    region.center.longitude = _mapView.centerCoordinate.longitude ;
    [_mapView setRegion:region animated:NO];

    if (self.isBookMark) {
        
        Event *event = self.popularityEventArr[0];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([event.eventLatitude doubleValue], [event.eventLongitude doubleValue]);
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location;
        location.latitude = coordinate.latitude;
        location.longitude = coordinate.longitude;
        region.span = span;
        region.center = location;
        [self.mapView setRegion:region animated:YES];
    }
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:_mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks)
        {
            NSString *location = [placemark locality];
            if (_currentLocationBlock) {
                _currentLocationBlock (location);
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)annotationAction:(CLLocationDegrees)latitude  longitude:(CLLocationDegrees)longitude {
    
    for (Event *event in _popularityEventArr) {
        
        if( ([event.eventLatitude doubleValue] == latitude &&
             [event.eventLongitude doubleValue] == longitude )) {
            
            appDelegate.selectedTabDetail = @"";
            
            EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
            eventDetail.eventObject = event;
            [self.navigationController pushViewController:eventDetail  animated:YES];
            break;
        }
    }

}

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped");
}

@end
