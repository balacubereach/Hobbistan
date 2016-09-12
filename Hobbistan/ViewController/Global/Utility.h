//
//  Utility.h
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Utility : NSObject

+ (void)verifyUserLogin:(void(^)(User *user))islogin notLogin:(void(^)())notLogin;

@end
