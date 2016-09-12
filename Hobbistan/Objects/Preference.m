//
//  Preference.m
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "Preference.h"

@implementation Preference

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.category = [self objectOrNilForKey:@"category" fromDictionary:dict];
        self.category_preference = [NSNumber numberWithBool:[[self objectOrNilForKey:@"category_preference" fromDictionary:dict] boolValue]];
        self.cateId = [self objectOrNilForKey:@"id" fromDictionary:dict];
        self.img_path = [self objectOrNilForKey:@"img_path" fromDictionary:dict];
        self.size = [self objectOrNilForKey:@"size" fromDictionary:dict];
        self.isSelected = @(0);
    }
    
    return self;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.category_preference forKey:@"category_preference"];
    [aCoder encodeObject:self.cateId forKey:@"cateId"];
    [aCoder encodeObject:self.img_path forKey:@"img_path"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.isSelected forKey:@"selected"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _category   = [aDecoder decodeObjectForKey:@"category"];
        _category_preference = [aDecoder decodeObjectForKey:@"category_preference"];
        _cateId     = [aDecoder decodeObjectForKey:@"cateId"];
        _img_path   = [aDecoder decodeObjectForKey:@"img_path"];
        _size       = [aDecoder decodeObjectForKey:@"size"];
        _isSelected       = [aDecoder decodeObjectForKey:@"selected"];
    }
    return self;
}


@end
