//
//  Utility.m
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void)verifyUserLogin:(void(^)(User *user))islogin notLogin:(void(^)())notLogin{
    if (notLogin) {
        notLogin();
    }
}

@end
