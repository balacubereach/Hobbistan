//
//  AnnotationView.m
//  Hobbistan
//
//  Created by KPTech on 1/10/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "AnnotationView.h"
#import "MapEvents.h"

@implementation AnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapEvents*)delegate {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.delegate = delegate;
        // Compensate frame a bit so everything's aligned
//        [self setCenterOffset:CGPointMake(-49, -3)];
//        [self setCalloutOffset:CGPointMake(-2, 3)];
        
        [self setFrame:CGRectMake(0, 0, 100, 80)];
//        [self setBackgroundColor:[UIColor redColor]];
        //[self addSubview:iconView];
        
        self.mapPin = (MKPointAnnotation *)annotation;
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(-42, -60, 100, 60)];
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        [contentView addSubview:iconView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 20)];
        [title setFont:[UIFont fontWithName:@"HelveticaNeue-bold" size:10.0]];
        [title setTextColor:[UIColor whiteColor]];
        
        title.text  = self.mapPin.title;
        [contentView addSubview:title];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 80, 20)];
        [name setFont:[UIFont fontWithName:@"HelveticaNeue" size:10.0]];
        [name setTextColor:[UIColor whiteColor]];
        
        name.text  = self.mapPin.subtitle;
        [contentView addSubview:name];
        
        self.aButton = [[UIButton alloc] initWithFrame:contentView.bounds];
        [contentView addSubview:self.aButton];
        [self.aButton addTarget:self action:@selector(annotationAction) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:contentView];
    }
    
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    icon = [UIImage imageNamed:@"map-pin"];
    [iconView setImage:icon];
}

/** Override to make sure shadow image is always set
 */
- (void)setImage:(UIImage *)image {
    [super setImage:[UIImage imageNamed:@"slice2"]];
}


- (void)annotationAction {
    
    [self.delegate annotationAction:self.mapPin.coordinate.latitude longitude:self.mapPin.coordinate.longitude];
}
@end
