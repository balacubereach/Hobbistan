//
//  ViewController.m
//  Hobbistan
//
//  Modified by UITOUX Solutions Pvt Ltd.


//  Created by Varun on 10/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "ViewController.h"

#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController ()

@end

@implementation ViewController

static NSString * const kClientID =
@"553186088702-sor4s9199re0l3o6ds767ot22901qj83.apps.googleusercontent.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].clientID = kClientID;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
