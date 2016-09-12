//
//  MenuViewController.m
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

//  Modified by UITOUX Solutions Pvt Ltd.

#import "MenuViewController.h"
#import "MenuCell.h"
#import "UIViewController+ECSlidingViewController.h"
#import "SelectCity.h"
#import "EditProfile.h"
#import "MainViewController.h"
#import "SelectPreference.h"
#import "EventDetail.h"
#import "HomeTabController.h"

#import <GoogleSignIn/GoogleSignIn.h>

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSMutableArray *arrMenuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userImageView.layer.cornerRadius = 4.0;
    self.userImageView.clipsToBounds = YES;
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"] != nil) {
        self.userImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]];
        
         self.bImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]];
        
    }
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.bImageView.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.bImageView addSubview:blurEffectView];
    
    
    //self.view.bounds  CGRectMake(0,0, self.view.frame.size.width, 64)
    
    //transparentView.alpha = 0.33f;
    
    UIView *transparentView = [[UIView alloc] initWithFrame:self.bImageView.bounds];
    //transparentView.alpha = 1.00f;
    
    transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self.bImageView addSubview: transparentView];
    
    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    // add effect to an effect view
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = self.view.frame;
//    
//    // add the effect view to the image view
//    [self.bImageView addSubview:effectView];
    
    
    //self.tableView.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
    
     NSMutableDictionary *userDic = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"];
    
    
     NSString *getname ;
    
     NSString *name ;
    
    getname = userDic[@"user_name"];
    
    if (!([getname  isEqual: @"(null)"]) || !(getname == [NSNull class]) || !([getname isEqual: @"(null)"])){
        
  NSArray *namearray = [getname componentsSeparatedByString:@" "];
        
    if ([NSString stringWithFormat:@"%@",namearray[0]].length > 2){
        
        name = [NSString stringWithFormat:@"%@",namearray[0]];
        
    }else{
        
        NSArray *tempArray=[NSArray arrayWithObjects:namearray[0],namearray[1], nil];
        
        name = [tempArray componentsJoinedByString:@" "];
    }
        
   }else{
       
       name = @"Hobbistani";
                                                                                                                     
     }
    
    self.nameTxt.text = name.capitalizedString;
    

    //self.nameTxt.text = appDelegate.user.userName.capitalizedString;
    self.cityTxt.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"];
    
    self.cityTxt.text = self.cityTxt.text .capitalizedString;
    
    arrMenuItems = [[NSMutableArray alloc]initWithObjects:@"Change City",@"Profile",@"Edit Preferences",@"Wishlist",@"Rate us", @"Sign Out", nil];
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.bImageView addGestureRecognizer:singleFingerTap];
    [self.touchView addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMenuItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    
    MenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (menuCell == NULL)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
        menuCell = [topLevelObjects objectAtIndex:0];
    }
    
    menuCell.lblMenuTitle.text = [arrMenuItems objectAtIndex:indexPath.row];
    return menuCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        appDelegate.isFromSideMenu = YES;
        SelectCity * selectCity = [[SelectCity alloc]initWithNibName:@"SelectCity" bundle:nil];
        self.slidingViewController.topViewController  = selectCity;
        [self.slidingViewController resetTopViewAnimated:YES];

    }
    else if (indexPath.row == 1){
        EditProfile * editProfileVC = [[EditProfile alloc]initWithNibName:@"EditProfile" bundle:nil];
        self.slidingViewController.topViewController  =editProfileVC;
        [self.slidingViewController resetTopViewAnimated:YES];

    }else if (indexPath.row == 2){
        SelectPreference * selectPreference = [[SelectPreference alloc]initWithNibName:@"SelectPreference" bundle:nil];
        self.slidingViewController.topViewController  =selectPreference;
        [self.slidingViewController resetTopViewAnimated:YES];
    }
    else if (indexPath.row == 3){

        [self.mainViewController gotoBookmark];
        UIView *blackView = [self.slidingViewController.topViewController.view viewWithTag:212];
        [blackView removeFromSuperview];

        [self.slidingViewController resetTopViewAnimated:NO onComplete:^{
        
        }];
    }
    else if (indexPath.row == 4){
        
    }
    else if (indexPath.row == 5){
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserImage"];
        
        
        [[GIDSignIn sharedInstance] signOut];
        
       
    //    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UserImage"];
        
     //   [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UserDetail"];

        
      //  [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"] removeAllObjects];
       //  [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"] removeAllObjects];
        
        
        [appDelegate goSignUpScreen];
    }

}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    UIView *blackView = [self.slidingViewController.topViewController.view viewWithTag:212];
    [blackView removeFromSuperview];
    [self.slidingViewController resetTopViewAnimated:YES];
}

@end
