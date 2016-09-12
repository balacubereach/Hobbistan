//
//  AppDelegate.h
//  Hobbistan
//
//  Modified by UITOUX Solutions Pvt Ltd.


//  Created by Varun on 10/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceClient.h"
#import <CoreLocation/CoreLocation.h>
//#import <Google/Analytics.h>

#import "SignUp.h"

@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (weak, nonatomic) SignUp *SignUp;

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic,strong) WebServiceClient *apiCall;
@property (strong, nonatomic) User *user;
@property (nonatomic, strong) CLLocation *userLocation;


@property (nonatomic, strong) NSString *selectedTabDetail;


@property (nonatomic,assign) BOOL isFromSideMenu;
- (void)initMainScreen;
- (void)goSignUpScreen;


@end

