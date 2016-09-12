//
//  User.m
//
//  Created by khanh tran on 1/5/16
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "User.h"


NSString *const kUserUserName = @"userName";
NSString *const kUserAvatar = @"avatar";
NSString *const kUserUserId = @"userId";
NSString *const kUserPassWord = @"passWord";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize userName = _userName;
@synthesize avatar = _avatar;
@synthesize userId = _userId;
@synthesize passWord = _passWord;


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
            self.userName = [self objectOrNilForKey:kUserUserName fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kUserAvatar fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserUserId fromDictionary:dict];
            self.passWord = [self objectOrNilForKey:kUserPassWord fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userName forKey:kUserUserName];
    [mutableDict setValue:self.avatar forKey:kUserAvatar];
    [mutableDict setValue:self.userId forKey:kUserUserId];
    [mutableDict setValue:self.passWord forKey:kUserPassWord];

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

    self.userName = [aDecoder decodeObjectForKey:kUserUserName];
    self.avatar = [aDecoder decodeObjectForKey:kUserAvatar];
    self.userId = [aDecoder decodeObjectForKey:kUserUserId];
    self.passWord = [aDecoder decodeObjectForKey:kUserPassWord];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userName forKey:kUserUserName];
    [aCoder encodeObject:_avatar forKey:kUserAvatar];
    [aCoder encodeObject:_userId forKey:kUserUserId];
    [aCoder encodeObject:_passWord forKey:kUserPassWord];
}

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[User alloc] init];
    
    if (copy) {

        copy.userName = [self.userName copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.passWord = [self.passWord copyWithZone:zone];
    }
    
    return copy;
}


@end
