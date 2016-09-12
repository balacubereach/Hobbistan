//
//  User.h
//
//  Created by khanh tran on 1/5/16
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface User : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *passWord;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *signupType;

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *selectedCity;

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *birthDay;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *userImageUrl;
@property (nonatomic, strong) UIImage *userImage;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
