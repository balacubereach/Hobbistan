//
//  Event.m
//
//  Created by khanh tran on 1/9/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

NSString *const kEventId = @"id";
NSString *const kEventDescription = @"description";
NSString *const kEventStartDate = @"start_date";
NSString *const kEventEventVenue = @"event_venue";
NSString *const kEventEventName = @"event_name";
NSString *const kEventEventId = @"id";
NSString *const kEventContact = @"contact";
NSString *const kEventEndDate = @"end_date";
NSString *const kEventEventCategoryId = @"event_category_id";
NSString *const kEventEventLogo = @"event_logo";
NSString *const kEventCategoryName = @"category_name";
NSString *const kEventEventLatitude = @"event_latitude";
NSString *const kEventEventCity = @"event_city";
NSString *const kEventEventLongitude = @"event_longitude";
NSString *const kEventCategoryImg = @"category_img";
NSString *const kEventEventBanner = @"event_banner";
NSString *const kEventAd = @"isAd";
NSString *const kEventCost = @"event_cost";
NSString *const kEventContactEmail = @"contact_email";
NSString *const kEventContactName = @"contact_name";


@interface Event ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Event

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize startDate = _startDate;
@synthesize eventVenue = _eventVenue;
@synthesize eventName = _eventName;
@synthesize contact = _contact;
@synthesize endDate = _endDate;
@synthesize eventCategoryId = _eventCategoryId;
@synthesize eventLogo = _eventLogo;
@synthesize categoryName = _categoryName;
@synthesize eventLatitude = _eventLatitude;
@synthesize eventCity = _eventCity;
@synthesize eventLongitude = _eventLongitude;
@synthesize categoryImg = _categoryImg;
@synthesize eventBanner = _eventBanner;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kEventId fromDictionary:dict] doubleValue];
            self.internalBaseClassDescription = [self objectOrNilForKey:kEventDescription fromDictionary:dict];
            self.eventVenue = [self objectOrNilForKey:kEventEventVenue fromDictionary:dict];
        self.eventName = [self objectOrNilForKey:kEventEventName fromDictionary:dict];
        self.eventId = [self objectOrNilForKey:kEventEventId fromDictionary:dict];
            self.contact = [self objectOrNilForKey:kEventContact fromDictionary:dict];
        
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
            NSDate *startDate_ = [dateFormatter dateFromString:[self objectOrNilForKey:kEventStartDate fromDictionary:dict] ];

            NSDate *endDate_ = [dateFormatter dateFromString:[self objectOrNilForKey:kEventEndDate fromDictionary:dict] ];
            [dateFormatter setDateFormat:@"MMM dd,yyyy"];
            self.startDate  = [dateFormatter stringFromDate:startDate_];
            self.endDate    =  [dateFormatter stringFromDate:endDate_];
        
            [dateFormatter setDateFormat:@"hh:mm a"];
            self.startTime  = [dateFormatter stringFromDate:startDate_];
            self.endTime    = [dateFormatter stringFromDate:endDate_];
        
            self.eventCategoryId    = [[self objectOrNilForKey:kEventEventCategoryId fromDictionary:dict] doubleValue];
            self.eventLogo          = [self objectOrNilForKey:kEventEventLogo fromDictionary:dict];
            self.categoryName       = [self objectOrNilForKey:kEventCategoryName fromDictionary:dict];
            self.eventLatitude      = [self objectOrNilForKey:kEventEventLatitude fromDictionary:dict];
            self.eventCity          = [self objectOrNilForKey:kEventEventCity fromDictionary:dict];
            self.eventLongitude     = [self objectOrNilForKey:kEventEventLongitude fromDictionary:dict];
            self.categoryImg        = [self objectOrNilForKey:kEventCategoryImg fromDictionary:dict];
            self.eventBanner        = [self objectOrNilForKey:kEventEventBanner fromDictionary:dict];
            self.isAd               = [self objectOrNilForKey:kEventAd fromDictionary:dict];
        self.eventCost          = [self objectOrNilForKey:kEventCost fromDictionary:dict];
        self.eventContactEmail          = [self objectOrNilForKey:kEventContactEmail fromDictionary:dict];
        self.eventContactName          = [self objectOrNilForKey:kEventContactName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kEventId];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kEventDescription];
    [mutableDict setValue:self.startDate forKey:kEventStartDate];
    [mutableDict setValue:self.eventVenue forKey:kEventEventVenue];
    [mutableDict setValue:self.eventName forKey:kEventEventName];
    [mutableDict setValue:self.contact forKey:kEventContact];
    [mutableDict setValue:self.endDate forKey:kEventEndDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eventCategoryId] forKey:kEventEventCategoryId];
    [mutableDict setValue:self.eventLogo forKey:kEventEventLogo];
    [mutableDict setValue:self.categoryName forKey:kEventCategoryName];
    [mutableDict setValue:self.eventLatitude forKey:kEventEventLatitude];
    [mutableDict setValue:self.eventCity forKey:kEventEventCity];
    [mutableDict setValue:self.eventLongitude forKey:kEventEventLongitude];
    [mutableDict setValue:self.categoryImg forKey:kEventCategoryImg];
    [mutableDict setValue:self.eventBanner forKey:kEventEventBanner];
    [mutableDict setValue:self.isAd forKey:kEventAd];
    [mutableDict setValue:self.eventCost forKey:kEventCost];
    [mutableDict setValue:self.eventContactName forKey:kEventContactName];
    [mutableDict setValue:self.eventContactEmail forKey:kEventContactEmail];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kEventId];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kEventDescription];
    self.startDate = [aDecoder decodeObjectForKey:kEventStartDate];
    self.eventVenue = [aDecoder decodeObjectForKey:kEventEventVenue];
    self.eventName = [aDecoder decodeObjectForKey:kEventEventName];
    self.contact = [aDecoder decodeObjectForKey:kEventContact];
    self.endDate = [aDecoder decodeObjectForKey:kEventEndDate];
    self.eventCategoryId = [aDecoder decodeDoubleForKey:kEventEventCategoryId];
    self.eventLogo = [aDecoder decodeObjectForKey:kEventEventLogo];
    self.categoryName = [aDecoder decodeObjectForKey:kEventCategoryName];
    self.eventLatitude = [aDecoder decodeObjectForKey:kEventEventLatitude];
    self.eventCity = [aDecoder decodeObjectForKey:kEventEventCity];
    self.eventLongitude = [aDecoder decodeObjectForKey:kEventEventLongitude];
    self.categoryImg = [aDecoder decodeObjectForKey:kEventCategoryImg];
    self.eventBanner = [aDecoder decodeObjectForKey:kEventEventBanner];
    self.isAd = [aDecoder decodeObjectForKey:kEventAd];
    self.eventCost = [aDecoder decodeObjectForKey:kEventCost];
    self.eventContactEmail = [aDecoder decodeObjectForKey:kEventContactEmail];
    self.eventContactName= [aDecoder decodeObjectForKey:kEventContactName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kEventId];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kEventDescription];
    [aCoder encodeObject:_startDate forKey:kEventStartDate];
    [aCoder encodeObject:_eventVenue forKey:kEventEventVenue];
    [aCoder encodeObject:_eventName forKey:kEventEventName];
    [aCoder encodeObject:_contact forKey:kEventContact];
    [aCoder encodeObject:_endDate forKey:kEventEndDate];
    [aCoder encodeDouble:_eventCategoryId forKey:kEventEventCategoryId];
    [aCoder encodeObject:_eventLogo forKey:kEventEventLogo];
    [aCoder encodeObject:_categoryName forKey:kEventCategoryName];
    [aCoder encodeObject:_eventLatitude forKey:kEventEventLatitude];
    [aCoder encodeObject:_eventCity forKey:kEventEventCity];
    [aCoder encodeObject:_eventLongitude forKey:kEventEventLongitude];
    [aCoder encodeObject:_categoryImg forKey:kEventCategoryImg];
    [aCoder encodeObject:_eventBanner forKey:kEventEventBanner];
    [aCoder encodeObject:_isAd forKey:kEventAd];
    [aCoder encodeObject:_eventCost forKey:kEventCost];
    [aCoder encodeObject:_eventContactEmail forKey:kEventContactEmail];
    [aCoder encodeObject:_eventContactName forKey:kEventContactName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Event *copy = [[Event alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.startDate = [self.startDate copyWithZone:zone];
        copy.eventVenue = [self.eventVenue copyWithZone:zone];
        copy.eventName = [self.eventName copyWithZone:zone];
        copy.contact = self.contact;
        copy.endDate = [self.endDate copyWithZone:zone];
        copy.eventCategoryId = self.eventCategoryId;
        copy.eventLogo = [self.eventLogo copyWithZone:zone];
        copy.categoryName = [self.categoryName copyWithZone:zone];
        copy.eventLatitude = [self.eventLatitude copyWithZone:zone];
        copy.eventCity = [self.eventCity copyWithZone:zone];
        copy.eventLongitude = [self.eventLongitude copyWithZone:zone];
        copy.categoryImg = [self.categoryImg copyWithZone:zone];
        copy.eventBanner = [self.eventBanner copyWithZone:zone];
        copy.isAd = [self.isAd copyWithZone:zone];
        copy.eventCost = [self.eventCost copyWithZone:zone];
        copy.eventContactName = [self.eventContactName copyWithZone:zone];
        copy.eventContactEmail = [self.eventContactEmail copyWithZone:zone];
    }
    
    return copy;
}


@end
