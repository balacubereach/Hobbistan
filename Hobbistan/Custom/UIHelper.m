//
//  UIHelper.m
//  SocialEvening
//
//  Created by KP Tech on 07/12/2015.
//  Copyright © 2015 KPTech. All rights reserved.
//

#import "UIHelper.h"
#import "MBProgressHUD.h"

@implementation UIHelper

+ (UIHelper *)sharedInstance {
    
    static UIHelper *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (UIAlertController *)showAlertViewWithStr:(NSString *)messageStr {
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                               }];
    
    [alertView addAction:okAction];
    
    return alertView;
}


- (void)showHudInView:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Please wait...";
}

- (void)hideHudInView:(UIView *)view {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
