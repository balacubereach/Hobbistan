//
//  AnnotationView.h
//  Hobbistan
//
//  Created by KPTech on 1/10/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <MapKit/MapKit.h>

@class MapEvents;
@interface AnnotationView : MKPinAnnotationView {
    UIImage *icon;
    UIImageView *iconView;
    UIView *contentView;
}

@property(nonatomic, strong) UIButton *aButton;
@property(nonatomic, weak) MapEvents *delegate;
@property(nonatomic, strong) MKPointAnnotation *mapPin;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapEvents*)delegate;
@end
