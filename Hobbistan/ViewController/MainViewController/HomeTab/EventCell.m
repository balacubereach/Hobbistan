//
//  EventCell.m
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "EventCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation EventCell

- (void)awakeFromNib {
    _paidTitle.layer.cornerRadius = 8.0;
    _paidTitle.layer.masksToBounds  = YES;
    _paidTitle.layer.borderWidth  = 1.5f;
   
}

//NSString *code = [state substringFromIndex: [state length] - 2];

- (void)configCellWithEvent:(Event *)event
{
    
    NSString *lastdata;
    
    if (!([event.eventVenue isEqual: @"(null)"]) || !(event.eventVenue == [NSNull class]) || !([event.eventVenue isEqual: @"(null)"]))
    {
    
    NSArray *eventstring =[event.eventVenue componentsSeparatedByString:@"," ];
    
    if (eventstring.count > 2)
    {
        lastdata= eventstring[eventstring.count-2];
        
    }else if(eventstring.count > 1)
    {
        
        lastdata= eventstring[eventstring.count-1];
    }else
    {
        
        lastdata= eventstring[0];
     }
        
    }
    
     NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
    
    _fullTitle.text =  [event.eventName stringByTrimmingCharactersInSet:whitespace].capitalizedString;
    _eventTitle.text = [event.categoryName stringByTrimmingCharactersInSet:whitespace].capitalizedString;
    _name.text      =  [lastdata stringByTrimmingCharactersInSet:whitespace].capitalizedString;
    _dateEvent.text = [NSString stringWithFormat:@"%@-%@", event.startDate, event.endDate];
    _timeEvent.text = [NSString stringWithFormat:@"%@-%@", event.startTime, event.endTime];
   
    [_thumbNail sd_setImageWithURL:[NSURL URLWithString:event.eventLogo]  placeholderImage:[UIImage imageNamed:@"list_bg"]];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_thumbNail.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    _thumbNail.layer.mask = maskLayer;
    
    self.paidTitle.text = event.eventCost.capitalizedString;
    
    self.adImageView.hidden = YES;
    if ([event.isAd isEqualToString:@"1"]) {
        
        self.adImageView.hidden = NO;
    }
    
    if ([event.eventCost.lowercaseString isEqualToString:@"paid"]) {
        
        self.paidTitle.textColor = [UIColor colorWithRed:237/255.0f green:61/255.0f blue:42/255.0f alpha:1.0];
         _paidTitle.layer.borderColor  = [UIColor colorWithRed:237/255.0f green:61/255.0f blue:42/255.0f alpha:1.0].CGColor;
    }
    else if ([event.eventCost.lowercaseString isEqualToString:@"free"]) {
     
        self.paidTitle.textColor = [UIColor colorWithRed:110/255.f green:206/255.f blue:27/255.f alpha:1.0f];
         _paidTitle.layer.borderColor  = [UIColor colorWithRed:110/255.f green:206/255.f blue:27/255.f alpha:1.0f].CGColor;
    }
    else {
        
        self.paidTitle.textColor = [UIColor colorWithRed:223/255.f green:149/255.f blue:34/255.f alpha:1.0f];
         _paidTitle.layer.borderColor  = [UIColor colorWithRed:223/255.f green:149/255.f blue:34/255.f alpha:1.0f].CGColor;
    }
    
     _thumbNail.layer.cornerRadius = _thumbNail.frame.size.height/2;
    
}

- (void)configCellWithEventwithoutDate:(Event *)event {
    
    
     NSString *lastdata;
    
     if (!([event.eventVenue isEqual: @"(null)"]) || !(event.eventVenue == [NSNull class]) || !([event.eventVenue isEqual: @"(null)"])){
    
    NSArray *eventstring =[event.eventVenue componentsSeparatedByString:@"," ];
        
    if (eventstring.count > 2){
        lastdata= eventstring[eventstring.count-2];
        
    }else if(eventstring.count > 1){
        
        lastdata= eventstring[eventstring.count-1];
    }else{
        
        lastdata= eventstring[0];
    }
     }
     NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
    
    
    _fullTitle.text = [event.eventName stringByTrimmingCharactersInSet:whitespace].capitalizedString;
    _eventTitle.text= [event.categoryName stringByTrimmingCharactersInSet:whitespace].capitalizedString;
    _name.text      = [lastdata stringByTrimmingCharactersInSet:whitespace].capitalizedString;;
    _dateEvent.text = @"\t   ";
    _calanderimg .hidden = true;
    _timeEvent.text = [NSString stringWithFormat:@"%@-%@", event.startTime, event.endTime];
    [_thumbNail sd_setImageWithURL:[NSURL URLWithString:event.eventLogo]  placeholderImage:[UIImage imageNamed:@"list_bg"]];
    _thumbNail.layer.cornerRadius = _thumbNail.frame.size.height/2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_thumbNail.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    _thumbNail.layer.mask = maskLayer;
    
    self.paidTitle.text = event.eventCost;
    
    self.adImageView.hidden = YES;
    if ([event.isAd isEqualToString:@"1"]) {
        
        self.adImageView.hidden = NO;
    }
    
    self.paidTitle.hidden = true ;
    
   
//    if ([event.eventCost.lowercaseString isEqualToString:@"paid"]) {
//        
//        self.paidTitle.textColor = [UIColor redColor];
//    }
//    else if ([event.eventCost.lowercaseString isEqualToString:@"free"]) {
//        
//        self.paidTitle.textColor = [UIColor colorWithRed:0/255.f green:100/255.f blue:0/255.f alpha:1.0f];
//    }
//    else {
//        
//        self.paidTitle.textColor = [UIColor blueColor];
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
