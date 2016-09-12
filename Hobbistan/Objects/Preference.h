//
//  Preference.h
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preference : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber* category_preference;
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *img_path;
@property (nonatomic, strong) NSNumber *isSelected;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
