//
//  Event.h
//
//  Created by khanh tran on 1/9/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Event : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, copy) NSString *internalBaseClassDescription;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *eventVenue;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, assign) double eventCategoryId;
@property (nonatomic, copy) NSString *eventLogo;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *eventLatitude;
@property (nonatomic, copy) NSString *eventCity;
@property (nonatomic, copy) NSString *eventLongitude;
@property (nonatomic, copy) NSString *categoryImg;
@property (nonatomic, copy) NSString *eventBanner;
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *isAd;
@property (nonatomic, copy) NSString *eventCost;
@property (nonatomic, copy) NSString *eventContactName, *eventContactEmail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
