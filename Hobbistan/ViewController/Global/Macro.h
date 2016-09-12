//
//  Macro.h
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


#import "AppDelegate.h"
#import "UINavigationController+Extensions.h"
#import "User.h"
#import "UIHelper.h"
#import "MenuViewController.h"
#import "SelectCity.h"

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define DEVICE_IS_IPAD      UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?YES:NO
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight        [[UIScreen mainScreen] bounds].size.height
#define SCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenHeight))
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define kBaseAppUrl @"http://hobbistan.com/app/hobbistan/api.php"
#define kBaseAppUrl1 @"http://hobbistan.com/app/hobbistan"

#endif