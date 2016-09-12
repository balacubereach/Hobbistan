//
//  AppDelegate.m
//  Hobbistan
//
// Modified by UITOUX Solutions Pvt Ltd.


//  Created by Varun on 10/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUp.h"
#import "SelectPreference.h"
#import "Utility.h"
#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MenuViewController.h"
#import "BaseNavigationController.h"
//#import <GoogleSignIn/GoogleSignIn.h>
#import "ECSlidingViewController.h"

#import <GoogleSignIn/GoogleSignIn.h>



#import "iRate.h"

//

#import "ViewController.h"

@interface AppDelegate () <GIDSignInDelegate>

@end

@implementation AppDelegate 

static NSString * const kClientID =
@"553186088702-sor4s9199re0l3o6ds767ot22901qj83.apps.googleusercontent.com";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [GIDSignIn sharedInstance].clientID = kClientID;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]];
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger appLaunchAmounts = [userDefaults integerForKey:@"LaunchCounts"];
    if (appLaunchAmounts == 5)
    {
        // [iRate sharedInstance].eventCount = 0;
        
        [[iRate sharedInstance] logEvent:YES];  //app rating alert call
        
        // [self showMessage];
    }
    [userDefaults setInteger:appLaunchAmounts+1 forKey:@"LaunchCounts"];
    
    
    //    [Utility verifyUserLogin:^(User *user) {
    //        //init main screen
    //    } notLogin:^{
    //        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[SignUp alloc] initWithNibName:@"SignUp" bundle:nil]];
    //        [self.window setRootViewController:nav];
    //    }];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.apiCall = [WebServiceClient sharedInstance];
    
    
    //    [self signup];
    //    [self category_list];
    //    [self view_preferences];
    //    [self user_preference];
    //    [self event_management];
    //    [self getCity];
    //    [self signup_new];
    
    [self.window makeKeyAndVisible];
    
    [self goSignUpScreen];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"LaunchedOnce"])
    {
        
        NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
        
        NSString *valueToSave = [NSString stringWithFormat:@"%f",seconds] ;
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"enterTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        //  [[NSNotificationCenter defaultCenter]postNotificationName:@"applaunch" object:self];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    //    NSError *configureError;
    //    [[GGLContext sharedInstance] configureWithError:&configureError];
    //    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
}


- (void)initMainScreen {
    
    
    NSMutableDictionary *userDic = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"];
    
    self.user = [[User alloc] init];
    
    NSLog(@"userDic %@",userDic);
    
    if (userDic) {
        
        self.user.userName      = [userDic objectForKey:@"user_name"];
        self.user.email         = [userDic objectForKey:@"user_email"];
        self.user.passWord      = [userDic objectForKey:@"user_password"];
        self.user.signupType    = [userDic objectForKey:@"sign_up_type"];
        self.user.userId        = [userDic objectForKey:@"user_id"];
        self.user.gender        = [userDic objectForKey:@"gender"];
        self.user.occupation    = [userDic objectForKey:@"occupation"];
        self.user.birthDay      = [userDic objectForKey:@"birthday"];
        self.user.phone         = [userDic objectForKey:@"phone"];
        
        NSLog(@"userDic %@", [userDic objectForKey:@"user_name"]);
        
        
        NSString *urlStr = self.user.userImageUrl;
        if ((urlStr == nil || [urlStr isEqual:[NSNull null]]) && [[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]) {
            
            [[WebServiceClient sharedInstance] uploadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"] userId:self.user.userId];
        }
        else if (urlStr != nil && ![urlStr isEqual:[NSNull null]]){
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
                NSData *userData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.userImageUrl]];
                [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"UserImage"];
            });
        }
        
        
        if([self.user.userName isEqual:[NSNull null]] || self.user.userName == nil) {
            
            self.user.userName = @"Hobbistani";
        }
        
        
        if([self.user.phone isEqual:[NSNull null]] || self.user.phone == nil) {
            
            self.user.phone = @"";
        }
        
        if([self.user.birthDay isEqual:[NSNull null]] || self.user.birthDay == nil) {
            
            self.user.birthDay = @"";
        }
        
        if([self.user.occupation isEqual:[NSNull null]] || self.user.occupation ) {
            
            self.user.occupation = @"";
        }
        
        if([self.user.gender isEqual:[NSNull null]] || self.user.gender == nil) {
            
            self.user.gender = @"";
        }
        
        // self.user = self.user;
        
    }
    
    NSLog(@"user %@",self.user);
    
    
    MainViewController *mainVc  = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    [self.window setRootViewController:nav];
    
    MenuViewController *leftMenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    MainViewController *homeVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    leftMenuViewController.mainViewController = homeVC;
    
    ECSlidingViewController *ecSlideVC = [[ECSlidingViewController alloc] init];
    ecSlideVC.topViewController = navi;
    ecSlideVC.underLeftViewController = leftMenuViewController;
    [ecSlideVC setAnchorRightRevealAmount:265.0f];
    self.window.rootViewController = ecSlideVC;
}

- (void)goSignUpScreen {
    
    
    //&&[[NSUserDefaults standardUserDefaults] objectForKey:@"RegisteredUser"]
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] ) {
        
        
        SignUp *signUp  = [[SignUp alloc] initWithNibName:@"SignIn" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:signUp];
        navController.navigationBarHidden = YES;
        
        self.window.rootViewController = navController;
        
        
        // SignUp *signUp = [[SignUp alloc] initWithNibName:@"SignIn" bundle:nil];
        //[navController pushViewController:signUp animated:NO];
        
    }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]){
        
        
        [self initMainScreen];
        
        
        //          NSMutableDictionary *userDic = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"];
        //         [self.SignUp goToNextScreenWithDictonary:[NSMutableDictionary dictionaryWithDictionary:userDic]];
        
    }else{
        
        SignUp *signUp  = [[SignUp alloc] initWithNibName:@"SignIn" bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:signUp];
        navController.navigationBarHidden = YES;
        
        self.window.rootViewController = navController;
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"appinactive" object:self];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    for(UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if([window.class.description isEqual:@"UITextEffectsWindow"])
        {
            [window removeConstraints:window.constraints];
        }
    }
}

//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary<NSString*, id> *)options {
//    
//    return [[FBSDKApplicationDelegate sharedInstance] application:app
//                                                          openURL:url
//                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//    
//    
//    
//    
//}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//  
//    return [[GIDSignIn sharedInstance] handleURL:url
//                           sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                  annotation:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
//}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    
//    return [[GIDSignIn sharedInstance] handleURL:url
//                        sourceApplication:sourceApplication
//                               annotation:annotation];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication
                                      annotation:annotation];
}

-(BOOL)application:(UIApplication *)application processOpenURLAction:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation iosVersion:(int)version
{
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
}

- (void)signup {
    
    
    NSDictionary *jsonDict = @{@"func_name":@"sign_up",@"name":@"KP Tech",@"user_email":@"kptech80@gmail.com",@"sign_up_type":@"2",@"user_password":@"test123"};
    
    [self callAPIWithParameter:jsonDict];
}

- (void)signup_new {
    
    NSDictionary *jsonDict = @{@"func_name":@"sign_up_new",
                               @"user_name":@"KP Tech",
                               @"user_email":@"kptech80@gmail.com",
                               @"sign_up_type":@"2",
                               @"user_password":@"test123",
                               @"city_version":@"1.0",
                               @"category_version":@"1.0"};
    
    [self callAPIWithParameter:jsonDict];
}


- (void)getCity {
    
    NSDictionary *jsonDict = @{@"func_name":@"getCity"};
    [self callAPIWithParameter:jsonDict];
}


- (void)category_list {
    
    NSDictionary *jsonDict = @{@"func_name":@"category_list",@"user_id":@"373"};
    [self callAPIWithParameter:jsonDict];
}

- (void)view_preferences {
    
    NSDictionary *jsonDict = @{@"func_name":@"view_preferences",@"user_id":@"373"};
    [self callAPIWithParameter:jsonDict];
}

- (void)user_preference {
    
    NSDictionary *jsonDict = @{@"func_name":@"user_preference", @"user_id":@"373",@"preferences":@[@{@"category_id":@"1"},@{@"category_id":@"2"},@{@"category_id":@"3"},@{@"category_id":@"4"},@{@"category_id":@"5"}]};
    [self callAPIWithParameter:jsonDict];
}


- (void)event_management {
    
    NSDictionary *jsonDict = @{@"func_name":@"event_management",@"event_type":@"popularity", @"user_id":@"373",@"page_id":@"2",@"city":@"chennai"};
    [self callAPIWithParameter:jsonDict];
}

- (void)callAPIWithParameter:(NSDictionary *)parameters {
    
    NSURL *url = [NSURL URLWithString:kBaseAppUrl];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setTimeoutInterval:18];
    
    
    [urlRequest setHTTPBody:[NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           NSLog(@"API %@",[parameters objectForKey:@"func_name"]);
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil) {
                                                               
                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               
                                                               NSLog(@"Data = %@",text);
                                                           }
                                                       }];
    [dataTask resume];
    
}


+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iRate sharedInstance].applicationBundleID = @"com.kptech.Hobbistan";
    
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    //set events count (default is 10)
    [iRate sharedInstance].eventsUntilPrompt = 50;
    
    //disable minimum day limit and reminder periods
    [iRate sharedInstance].daysUntilPrompt = 0;
    [iRate sharedInstance].remindPeriod = 0;
}


#pragma mark -
#pragma mark iRate delegate methods

- (void)iRateUserDidRequestReminderToRateApp
{
    //reset event count after every 5 (for demo purposes)
    [iRate sharedInstance].eventCount = 0;
}

#pragma mark -
#pragma mark Memory management

@end
