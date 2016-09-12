//
//  SignUp.m
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "SignUp.h"
#import "UIView+Extra.h"
#import "UIButton+Extra.h"
#import "SelectCity.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "UIHelper.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
#import "User.h"
#import "SelectPreference.h"
#import "PersistencyManager.h"
#import "TermsAndConditionViewController.h"

#import <GoogleSignIn/GIDSignIn.h>
#import <GoogleSignIn/GIDGoogleUser.h>
#import <GoogleSignIn/GIDAuthentication.h>

@interface SignUp () <UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnGoogle;
@property (weak, nonatomic) IBOutlet UIView *viewCreateAccount;
@property (weak, nonatomic) IBOutlet UIView *viewFullName;
@property (weak, nonatomic) IBOutlet UIView *viewEmail;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIView *viewPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (assign, nonatomic) BOOL isLogIn;

@property (strong, nonatomic) User *user;
@end

@implementation SignUp {
    
    AppDelegate *appDel;
    
    //Facebook Login iVars
    NSString *fbID;
    NSString *fbemail;
    NSString *fbfirst_name;
    NSString *fblast_name;
    NSString *fbprofilePic;
    
    NSString *EmailId;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signBtn.layer.cornerRadius = 4.0;
    self.fbBtn.layer.cornerRadius = 4.0;
    self.gpBtn.layer.cornerRadius = 4.0;
    
    NSLog(@"width %f",self.orLabel.frame.size.width/2);
    
    self.orLabel.layer.cornerRadius = self.orLabel.frame.size.width/2;
    
    [[self.orLabel layer] setMasksToBounds:YES];
    
    self.signInslide.hidden = NO;
    self.signUpslide.hidden = YES;
    
    self.nameline.hidden = YES ;
    self.txtFullName.hidden = YES ;
    
    _agreeTemsLine.hidden =YES;
    _tmsandcond.hidden =YES;
    self.fgtPwd.hidden = NO;
    
    self.signBtn.tag = 100;
    self.fbBtn.tag = 100;
    self.gpBtn.tag = 100;
    
//    self.signInShowBtn.layer.cornerRadius = 4.0f;
//    self.signInShowBtn.layer.borderColor =[UIColor colorWithRed:255/255 green:175/255 blue:166/255 alpha:1.0].CGColor;
//    self.signInShowBtn.layer.borderWidth = 1.0f;
//
//    self.signUpShowBtn.layer.cornerRadius = 4.0f;
//    self.signUpShowBtn.layer.borderColor =[UIColor colorWithRed:255/255 green:175/255 blue:166/255 alpha:1.0].CGColor;
//    self.signUpShowBtn.layer.borderWidth = 1.0f;
    
    self.txtFullName.text = @"null" ;
    
    [self.signBtn setTitle:@"Sign In" forState:UIControlStateNormal];
    
    [self.txtEmail setDelegate: self];
    
    CGRect newFrame1 = self.backgroundView.frame;
    
    newFrame1.origin.y = self.txtFullName.frame.size.height*2;
    
    [self.backgroundView setFrame:newFrame1];
    
    [_gpBtn setImage:[UIImage imageNamed:@"phones.png"] forState:UIControlStateNormal];
    
    [_fbBtn setImage:[UIImage imageNamed:@"fb_icon"] forState:UIControlStateNormal];
    [_gpBtn setImage:[UIImage imageNamed:@"gplus_icon"] forState:UIControlStateNormal];
    
    
//    UIImageView *imgSearch=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]; // Set frame as per space required around icon
//    [imgSearch setImage:[UIImage imageNamed:@"msg.png"]];
//    
//    [imgSearch setContentMode:UIViewContentModeCenter];// Set content mode centre
//    
//    self.txtEmail.leftView=imgSearch;
//    self.txtEmail.leftViewMode=UITextFieldViewModeAlways;
//
//    UIImageView *txtFullNameimgSearch=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [txtFullNameimgSearch setImage:[UIImage imageNamed:@"Fill 35.png"]];
//    
//    [txtFullNameimgSearch setContentMode:UIViewContentModeCenter];// Set content mode centre
//    
//    _txtFullName.leftView=txtFullNameimgSearch;
//    _txtFullName.leftViewMode=UITextFieldViewModeAlways;
//    
//
//    UIImageView *txtPasswordNameimgSearch=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [txtPasswordNameimgSearch setImage:[UIImage imageNamed:@"Fill 21.png"]];
//    
//    [txtPasswordNameimgSearch setContentMode:UIViewContentModeCenter];// Set content mode centre
//    
//    _txtPassword.leftView=txtPasswordNameimgSearch;
//    _txtPassword.leftViewMode=UITextFieldViewModeAlways;
    
    
   // [self.txtFullName setDelegate: self];
    
    
    //self.txtEmail.frame = CGRectMake(96, 40, 130, 20);
    
  //  _txtEmail.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
    
   // _txtEmail.leftViewMode = UITextFieldViewModeAlways;
   // _txtEmail.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
    
//    _txtFullName.leftViewMode = UITextFieldViewModeAlways;
//    _txtFullName.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
//    
//    
//    _txtPassword.leftViewMode = UITextFieldViewModeAlways;
//    _txtPassword.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
    
   
//    
    //[[GIDSignIn sharedInstance] setScopes:@[@"https://www.googleapis.com/auth/plus.stream.read", @"https://www.googleapis.com/auth/plus.me"]];
//      [[GIDSignIn sharedInstance] hasAuthInKeychain];
//    [[GIDSignIn sharedInstance] signIn];
//    
//    [GIDSignIn sharedInstance].uiDelegate = self;
//    if([GIDSignIn sharedInstance].hasAuthInKeychain) {
//        GIDGoogleUser *user = [GIDSignIn sharedInstance].currentUser;
//        if(!user) {
//            [[GIDSignIn sharedInstance] signInSilently];
//        }
//    }
//
//    
////    [GIDSignIn sharedInstance].clientID = @"961997472364-50gpv4ob4ngh89qdb4dek33b89husa0v.apps.googleusercontent.com";
   
    
    [GIDSignIn sharedInstance].clientID = @"553186088702-d389ictvhpesh98jomp51lo83f9008cr.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [[GIDSignIn sharedInstance] setScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/plus.login"]];
    
   // [[GIDSignIn sharedInstance] signInSilently];
    
   // [[GIDSignIn sharedInstance] setScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/plus.login",@"https://www.googleapis.com/auth/plus.me",@"https://www.googleapis.com/auth/userinfo.email", nil]];
    
   //[GIDSignIn sharedInstance].allowsSignInWithBrowser = true;
    
  // GIDSignIn.allowsSignInWithWebView = true
    
   // NSURL *gPlusUrl = [NSURL URLWithString:@"gplus://"];
    
//    if ([[UIApplication sharedApplication] canOpenURL:gPlusUrl]) {
//        [[UIApplication sharedApplication] openURL:gPlusUrl];
//    }
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
     appDel.SignUp = self;
    
    [self setupApperance];
    
    self.user = [[User alloc] init];

    NSMutableDictionary *userDic = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"];
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
        
        if([self.user.userName isEqual:[NSNull null]] || self.user.userName == nil) {
            
            self.user.userName = @"";
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

        appDel.user = self.user;
        
    }
        
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"] &&
        [[NSUserDefaults standardUserDefaults]objectForKey:@"RegisteredUser"]) {
        
        self.isLogIn = YES;
        [self goToNextScreenWithDictonary:[NSMutableDictionary dictionaryWithDictionary:userDic]];

    }
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
    // if labelView is not set userInteractionEnabled, you must do so
    [_fgtPwd setUserInteractionEnabled:YES];
    [_fgtPwd addGestureRecognizer:gesture];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


#pragma -
#pragma Action

//*********************************** Start Forgot Password *********************************************************

- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Email ID"
                                  message:@"Please Enter Your Email ID to get Verification Code"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   
                                                 UITextField *temp = alert.textFields.firstObject;
                                                 NSString *mailId =[NSString stringWithFormat:@"%@",temp.text];
                                                   
                                                   EmailId = mailId;
                                                   
                                                   NSLog(@"mailId %@",mailId);
                                                   
//                                                   NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=forgot_password_link&email=%@",mailId];
                                                   
                                                    NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/api_26_04-2016.php?func_name=forgot_password_link&email=%@",mailId];
                                                   
                                                   NSLog(@"Home %@",apiUrl);
                                                   
                                                   //
                                                   
                                                  // [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                                   [self PassUsermail:apiUrl Options:@"mail"];
                                                   
                                                   //Do Some action here
                                                   
                                               }];
    
  
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                     
                                                    //   [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                      // self presentViewController:alert animated:YES completion:nil];
                                                       
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
      ok.enabled = false;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter Email ID";
        textField.autocorrectionType= UITextAutocorrectionTypeYes;
        [textField addTarget:self action:@selector(alertTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        textField.keyboardType= UIKeyboardTypeEmailAddress;
        
    }];

   // alert.view.tintColor = [UIColor redColor];
    
    UIView *subView = alert.view.subviews.firstObject;
    UIView *alertContentView = subView.subviews.firstObject;
    [alertContentView setBackgroundColor:[UIColor colorWithRed:255/255.f green:242/255.f blue:242/255.f alpha:1.0f]];
    
    alertContentView.layer.cornerRadius = 10;
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)alertTextFieldDidChange:(UITextField *)sender {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *someTextField = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.firstObject;
       // okAction.enabled = someTextField.text.length > 2;
        
        if (someTextField.text.length > 2) {
            
        if ([self validateEmail:someTextField.text]) {
            okAction.enabled =  true;
            
            someTextField.backgroundColor = [UIColor clearColor];
            
        }else{
            
            someTextField.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
            
            [[someTextField superview] superview].backgroundColor = [UIColor blackColor];
        }
        
        }
        
    }
}


-(BOOL) validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    }
    else
        return YES;
}

-(void )GetVerificationCode: message{
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Verification Code"
                                  message:@"Please Enter the verification code which is send to Your E-mail"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                                   UITextField *temp = alert.textFields.firstObject;
                                                   NSString *Code =[NSString stringWithFormat:@"%@",temp.text];
                                                   
                                                   NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=password_activation&fp_activation=%@&email=%@",Code,EmailId];
                                                   
                                                   NSLog(@"Home %@",apiUrl);
                                                   
                                                    [self PassUsermail:apiUrl Options:@"code"];
                                                   
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter Verification code";
    }];
    //    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    //        textField.placeholder = @"Password";
    //        textField.secureTextEntry = YES;
    //    }];
    
   // alert.view.tintColor = [UIColor redColor];
    
    UIView *subView = alert.view.subviews.firstObject;
    UIView *alertContentView = subView.subviews.firstObject;
    [alertContentView setBackgroundColor:[UIColor colorWithRed:255/255.f green:242/255.f blue:242/255.f alpha:1.0f]];
    
    alertContentView.layer.cornerRadius = 5;
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void )ResetPassword{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Change Password"
                                  message:@"Please Enter Your New Password"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   
                                                   UITextField *temp = alert.textFields.firstObject;
                                                   NSString *Pwd =[NSString stringWithFormat:@"%@",temp.text];
                                                   
                                                   UITextField *cnfmtemp = alert.textFields.lastObject;
                                                   NSString *cnfm =[NSString stringWithFormat:@"%@",cnfmtemp.text];
                                                   
                                                   NSLog(@" Pwd %@",Pwd);
                                                    NSLog(@" cnfm %@",cnfm);
                                                   
                                                   if ([Pwd isEqualToString:cnfm]) {
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                       NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/uitouxcall.php?func_name=forgot_password&user_email=%@&new_password=%@",EmailId,Pwd];
                                                       
                                                       NSLog(@"Home %@",apiUrl);
                                                       
                                                       [self PassUsermail:apiUrl Options:@"finalStep"];
                                                       
                                                   }else{
                                                       
                                                       
                                                    cnfmtemp.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
                                                       
                                                       [[cnfmtemp superview] superview].backgroundColor = [UIColor blackColor];
                                                       
                                                      // cnfmtemp.text = @"Password Did't match";
                                                       
                                                    //   [self messageAlert:@"Failed" message:@"Password Did't match"];
                                                       
                                                       
                                                   }
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    ok.enabled = false;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter New Password";
        textField.secureTextEntry = YES;
    }];
    
    
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Enter Conform Password";
            
            [textField addTarget:self action:@selector(alertTextpasswordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.secureTextEntry = YES;
        }];
    
    //alert.view.tintColor = [UIColor redColor];
    
    UIView *subView = alert.view.subviews.firstObject;
    UIView *alertContentView = subView.subviews.firstObject;
    [alertContentView setBackgroundColor:[UIColor colorWithRed:255/255.f green:242/255.f blue:242/255.f alpha:1.0f]];
    
    alertContentView.layer.cornerRadius = 5;
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)alertTextpasswordFieldDidChange:(UITextField *)sender {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *pwdTextField = alertController.textFields.firstObject;
        UITextField *cnfmpwdTextField = alertController.textFields.lastObject;
        
        UIAlertAction *okAction = alertController.actions.firstObject;
        
        // okAction.enabled = someTextField.text.length > 2;
        
        if (pwdTextField.text.length > 2 && cnfmpwdTextField.text.length > 2) {
            
        if ([pwdTextField.text isEqualToString:cnfmpwdTextField.text]) {
            okAction.enabled =  true;
            
            cnfmpwdTextField.backgroundColor = [UIColor clearColor];
            
        }else{
            
            cnfmpwdTextField.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
            
            [[cnfmpwdTextField superview] superview].backgroundColor = [UIColor blackColor];
        }
       
        }
        
    }
}


- (void)PassUsermail:(NSString *)apiUrl Options:(NSString *)option {
    
    
    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //__weak typeof(self)wSelf    = self;
    [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
        NSString *msg = [resultDic objectForKey:@"msg"];
        
        NSString *status = [resultDic objectForKey:@"status"];
        
        
        NSLog(@"events %@",status);
        
        if ([status isEqualToString:@"activation link"] ||  [status isEqualToString:@"success"]){
            
            
            if ([option  isEqual: @"mail"]){
                
                [self GetVerificationCode:msg];
                
            }else if([option  isEqual: @"code"]){
                
                [self ResetPassword];
                
            }else if([option  isEqual: @"finalStep"]){
                
                [self messageAlert:@"Success" message:@"Your Password has been changed successfully.Login with new password"];
            }
            
            
        }else{
            
            [self messageAlert:@"Error" message:msg];
            
        }
        
        
    }
                        withFailure:^(NSError * _Nonnull error) {
                            
                        }];
    
}



-(void)messageAlert:(NSString *)title message:(NSString *)message{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   
                                               }];
    
    [alert addAction:ok];
    
   // alert.view.tintColor = [UIColor redColor];
    
    UIView *subView = alert.view.subviews.firstObject;
    UIView *alertContentView = subView.subviews.firstObject;
    [alertContentView setBackgroundColor:[UIColor colorWithRed:255/255.f green:242/255.f blue:242/255.f alpha:1.0f]];
    
    alertContentView.layer.cornerRadius = 5;
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


//*********************************** End Forgot Password *********************************************************


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    [self updateTextLabelsWithText: newString];
//    
//    return YES;
//}
//
//-(void)updateTextLabelsWithText:(NSString *)string
//{
//    [_txtEmail setText:string];
//}




- (IBAction)btnSignUp_pressed:(UIButton *)sender {
    
    if ([self.txtFullName.text isEqualToString:@""] ||
        [self.txtEmail.text isEqualToString:@""] ||
        [self.txtPassword.text isEqualToString:@""]) {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Please enter all required fields."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    else if(self.txtPassword.text.length < 5) {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Please enter more than 5 digits password."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else {
        
        self.isLogIn = NO;
        if (sender.tag == 100) {
            
            self.isLogIn = YES;
        }
        
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]init];
        [dicParam setObject:@"sign_up_latest" forKey:@"func_name"];
        [dicParam setObject:@"2" forKey:@"sign_up_type"];
        if (sender.tag == 100) {
            
            self.isLogIn = YES;
        }
        else {
            
            [dicParam setObject:self.txtFullName.text forKey:@"user_name"];
        }
        
        NSLog(@"self.txtEmail.text %@",self.txtEmail.text);
        NSLog(@"txtPassword %@",self.txtPassword.text);
        
        [dicParam setObject:self.txtEmail.text forKey:@"user_email"];
        [dicParam setObject:self.txtPassword.text forKey:@"user_password"];
        
        [self goToNextScreenWithDictonary:dicParam];
    }
}

- (void)setupApperance {
 
    UIColor *color = _btnFacebook.backgroundColor;
    [_btnFacebook setRoundCorner:20.0f boderColor:color];
    [_btnGoogle setRoundCorner:20.0f boderColor:color];
    [_btnSignUp setRoundCorner:20.0f boderColor:color];
    [_viewFullName setRoundCorner:20.0f boderColor:color];
    [_viewEmail setRoundCorner:20.0f boderColor:color];
    [_viewPassword setRoundCorner:20.0f boderColor:color];
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)googlePlusLogin:(UIButton *)sender {
  
    //[[UIHelper sharedInstance] showHudInView:self.view];

    self.isLogIn = NO;
    if (sender.tag == 100) {
        
        self.isLogIn = YES;
    }
    
//    if([GIDSignIn sharedInstance].hasAuthInKeychain) {
//        GIDGoogleUser *user = [GIDSignIn sharedInstance].currentUser;
//        if(!user) {
//            [[GIDSignIn sharedInstance] signInSilently];
//        }
//    } else {
        // [self.signIn signIn];
        
         [[GIDSignIn sharedInstance] signIn];
   // }
    
}

//- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
//{
//    [self presentViewController:viewController animated:YES completion:nil];
//}
//- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//   
//    return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication
//                                      annotation:annotation];
//}
//
//-(BOOL)application:(UIApplication *)application processOpenURLAction:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation iosVersion:(int)version
//{
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:sourceApplication
//                                      annotation:annotation];
//}
//
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//    
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
//}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:sourceApplication
//                                      annotation:annotation];
//}


- (BOOL)canOpenURL:(NSURL *)url
{
    if ([[url scheme] hasPrefix:@"com-google-gidconsent"] || [[url scheme] hasPrefix:@"com.google.gppconsent"]) {
        return NO;
    }
    
    return YES;
   // return [super canOpenURL:url];
}


#pragma mark - Google Sign IN
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    // Perform any operations on signed in user here.
  //  NSString *userId = user.userID;                  // For client-side use only!
  //  NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    NSString *password = @"GoogleLoginWithHardCodedPassword";
    NSURL *imgURL = [user.profile imageURLWithDimension:100];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    [[NSUserDefaults standardUserDefaults]setObject:imgData forKey:@"UserImage"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // ... Create a new PFUser Here
    if (name && email)  {
        
        NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]init];
        [dicParam setObject:@"sign_up_latest" forKey:@"func_name"];
        [dicParam setObject:@"1" forKey:@"sign_up_type"];
        //[dicParam setObject:name forKey:@"user_name"];
        
        [dicParam setObject:email forKey:@"user_name"];
        [dicParam setObject:email forKey:@"user_email"];
        [dicParam setObject:password forKey:@"user_password"];

      //  self.user.userName  = name;
        
        self.user.userName  = email;
        self.user.email     = email;
        self.user.passWord  = password;
        self.user.signupType  = @"1";
        
       // [self goToNextScreenWithDictonary:dicParam];
        
        [self setRegistration:dicParam];
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"User cancelled the google login");

    [[UIHelper sharedInstance] hideHudInView:self.view];
}

#pragma mark- Login with Facebook

- (IBAction)btnFacebook:(UIButton *)sender {
    [[UIHelper sharedInstance] showHudInView:self.view];
    //code cmd by hari
   
    self.isLogIn = NO;
    
   // self.isLogIn = YES;
    
    if (sender.tag == 100) {
     
       // self.isLogIn = NO;
       
        self.isLogIn = YES;
    }

    UIViewController *vc=self.view.window.rootViewController;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
     login.loginBehavior=FBSDKLoginBehaviorWeb;
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile",@"email"]  fromViewController:vc handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error) {
             [[UIHelper sharedInstance] hideHudInView:self.view];
             NSLog(@"There was an error with FB:n %@",error.description);
         }
         else if (result.isCancelled) {
             [[UIHelper sharedInstance] hideHudInView:self.view];
         }
         else {
             if ([result.grantedPermissions containsObject:@"email"]) {
                 NSLog(@"permissions granted! %@",[[FBSDKAccessToken currentAccessToken]permissions]);
                 [self facebookInfo];
                 NSLog(@"RESULT %@",result);
             }else{
                 [[UIHelper sharedInstance] hideHudInView:self.view];
                 NSLog(@"permissions NOT granted");
             }
         }
     }];
    
}
-(void)facebookInfo {
    
    //[SVProgressHUD showWithStatus:@"Please Wait..." withMaskType:SVProgressHUDMaskTypeGradient];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"id,email,first_name,last_name,link,locale"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         
         if (!error) {
             fbID=[result objectForKey:@"id"];
             fbfirst_name = [result objectForKey:@"first_name"];
             fblast_name = [ result objectForKey:@"last_name"];
             fbemail = [result objectForKey:@"email"] ;
             fbprofilePic= [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",fbID];
             NSURL *fbPicURL = [NSURL URLWithString:fbprofilePic];
             NSData *imgData = [NSData dataWithContentsOfURL:fbPicURL];
             [[NSUserDefaults standardUserDefaults]setObject:imgData forKey:@"UserImage"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             NSMutableDictionary *dicParam = [[NSMutableDictionary alloc]init];
             [dicParam setObject:@"sign_up_latest" forKey:@"func_name"];
             [dicParam setObject:@"1" forKey:@"sign_up_type"];
             
             //[dicParam setObject:[NSString stringWithFormat:@"%@ %@",fbfirst_name, fblast_name] forKey:@"user_name"];
             [dicParam setObject:fbemail forKey:@"user_name"];
             [dicParam setObject:fbemail forKey:@"user_email"];
             [dicParam setObject:@"loginwithfacebook" forKey:@"user_password"];
             
           //  self.user.userName  = [NSString stringWithFormat:@"%@ %@",fbfirst_name, fblast_name];
           
             self.user.userName     = fbemail;
             self.user.email     = fbemail;
             self.user.passWord  = @"loginwithfacebook";
             self.user.signupType  = @"1";
             
           //  [self goToNextScreenWithDictonary:dicParam];
             
             [self setRegistration:dicParam];
         }
     }];
    
}

-(void)setRegistration:(NSMutableDictionary *)userDic {
    
    NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/api_26_04-2016.php"];
    
   // NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
    
     [appDel.apiCall PostDataWithUrl:apiUrl withParameters:userDic withSuccess:^(id responseObject) {
    
         NSError* error;
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                              options:kNilOptions
                                                                error:&error];
         
         NSLog(@" status %@",json[@"status"]);
         
         if([json[@"status"] isEqualToString:@"alreadyRegistered"] || [json[@"status"] isEqualToString:@"success"]){
             
             [self goToNextScreenWithDictonary:userDic];
             
             self.isLogIn = YES;
         }
     }
   
    withFailure:^(NSError * _Nonnull error) {
        
    }];
    
}

-(void)goToNextScreenWithDictonary:(NSMutableDictionary *)userDic {
    
    NSLog(@"userDic %@",userDic);
    
    [[UIHelper sharedInstance] showHudInView:self.view];
   
    if (self.isLogIn == YES) {
        [userDic setObject:@"sign_in" forKey:@"func_name"];
    }
    appDel.user = self.user;

    //http://hobbistan.com/app/hobbistan/api.php
    
     NSString *apiUrl = [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/api_26_04-2016.php"];
    
   // NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
   
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:userDic withSuccess:^(id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];

        if ([json[@"status"] isEqualToString:@"activationError"] ||
            [json[@"status"] isEqualToString:@"alreadyRegistered"] ||
            [json[@"status"] isEqualToString:@"notRegistered"] ||
            [json[@"status"] isEqualToString:@"error"]) {

            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Hobbistan"
                                       message:json[@"msg"]
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
            if([userDic[@"user_password"]  isEqual:@"GoogleLoginWithHardCodedPassword"]){
                
                [[GIDSignIn sharedInstance] signOut];
                
            }
        }
        else {
            
            NSLog(@"%@",json[@"userData"]);
           
            NSDictionary *userDictionary = json[@"userData"];
            [userDic setObject:[userDictionary objectForKey:@"id"] forKey:@"user_id"];
            [userDic setObject:[userDictionary objectForKey:@"name"] forKey:@"user_name"];
                        
            self.user.userName      = [userDictionary objectForKey:@"name"];
            self.user.email         = [userDic objectForKey:@"user_email"];
            self.user.passWord      = [userDic objectForKey:@"user_password"];
            self.user.signupType    = [userDic objectForKey:@"sign_up_type"];
            self.user.userId        = [userDic objectForKey:@"user_id"];
            self.user.gender        = [userDictionary objectForKey:@"gender"];
            self.user.occupation    = [userDictionary objectForKey:@"occupation"];
            self.user.birthDay      = [userDictionary objectForKey:@"birthday"];
            self.user.phone         = [userDictionary objectForKey:@"phone"];
            self.user.userImageUrl  = [userDictionary objectForKey:@"user_image"];
            
            NSString *urlStr = self.user.userImageUrl;
            
            if ((urlStr == nil || [urlStr isEqual:[NSNull null]]) && [[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]) {

                [[WebServiceClient sharedInstance] uploadImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"] userId:appDelegate.user.userId];
            }
            else if (urlStr != nil && ![urlStr isEqual:[NSNull null]]){
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    NSData *userData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.userImageUrl]];
                    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"UserImage"];
                });
            }
            
            if([self.user.phone isEqual:[NSNull null]] || self.user.phone == nil) {
                
                self.user.phone = @"";
            }
            
            if([self.user.birthDay isEqual:[NSNull null]] || self.user.birthDay == nil) {
                
                self.user.birthDay = @"";
            }
            
            if([self.user.occupation isEqual:[NSNull null]] || self.user.occupation == nil ) {
                
                self.user.occupation = @"";
            }
            
            if([self.user.gender isEqual:[NSNull null]] || self.user.gender == nil) {
                
                self.user.gender = @"";
            }

            userDic[@"gender"]      = self.user.gender;
            userDic[@"occupation"]  = self.user.occupation;
            userDic[@"birthday"]    = self.user.birthDay;
            userDic[@"phone"]       = self.user.phone;
            userDic[@"user_id"]     = userDictionary[@"id"];
            
            NSLog(@"%@",userDic);

            appDel.user = self.user;
            
            [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"UserDetail"];
            [[NSUserDefaults standardUserDefaults] setObject:[json valueForKey:@"status"] forKey:@"RegisteredUser"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"selectedCity"]) {
                
                appDel.isFromSideMenu       = NO;
                SelectCity *selectCity      = [[SelectCity alloc] initWithNibName:@"SelectCity" bundle:nil];
                [self.navigationController pushViewController:selectCity animated:YES];
                [[UIHelper sharedInstance] hideHudInView:self.view];
            }
           // else if (![[NSUserDefaults standardUserDefaults]objectForKey:@"savedPreferenceJSON"]) {
                
                else if (![[NSUserDefaults standardUserDefaults]objectForKey:self.user.userId]) {
                    
                    NSLog(@"self.user.userId %@",self.user.userId);
                
                SelectPreference *preference = [[SelectPreference alloc] initWithNibName:@"SelectPreference" bundle:nil];
                [self.navigationController pushViewController:preference animated:YES];
            }
            else {
                
                [appDelegate initMainScreen];
            }
        }
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
        
        [[GIDSignIn sharedInstance] signOut];
        
        //[[UIHelper sharedInstance] hideHudInView:self.view];
    }];

}

- (IBAction)createAccoutAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)aleadyHaveAccoutAction:(id)sender {
    
    SignUp *signUp = [[SignUp alloc] initWithNibName:@"SignIn" bundle:nil];
    [self.navigationController pushViewController:signUp animated:YES];
}

-(IBAction)termsAndCondition:(id)sender {
    
//
//    UIViewController *bbp=[[UIViewController alloc]initWithNibName:@"Terms" bundle:nil];
//    UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:bbp];
//    [self.navigationController presentModalViewController:passcodeNavigationController animated:YES];
//    
//    [self.navigationController popViewControllerAnimated:YES];
//   // [self.navigationController pushViewController:passcodeNavigationController animated:YES];
//    
//    
////    TermsAndConditionViewController *vc = [[TermsAndConditionViewController alloc]initWithNibName:@"Terms" bundle:nil];
////    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
////    [self.navigationController pushViewController:navCtrl animated:YES];
    
    
    TermsAndConditionViewController *termsAndConditionViewController  = [[TermsAndConditionViewController alloc] initWithNibName:@"Terms" bundle:nil];
    [self.navigationController pushViewController:termsAndConditionViewController animated:YES];
}

- (IBAction)SignUpShowBtn:(id)sender {
    
    self.signInslide.hidden = YES;
    self.signUpslide.hidden = NO;
    
    self.nameline.hidden = NO ;
    self.txtFullName.hidden = NO ;
    
    _agreeTemsLine.hidden =NO;
    _tmsandcond.hidden =NO;
    self.fgtPwd.hidden = YES;
    
    
    self.signBtn.tag = 0;
    self.fbBtn.tag = 0;
    self.gpBtn.tag = 0;
    
    self.txtFullName.text = @"";
    self.txtPassword.text =@"" ;
    
  //  CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
        CGRect newFrame1 = self.backgroundView.frame;
    
       newFrame1.origin.y = self.txtFullName.frame.origin.y+self.txtFullName.frame.size.height;
    
        [self.backgroundView setFrame:newFrame1];
    
   // self. backgroundView.frame = CGRectMake(0, 100, width, 230);
    [self.signBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    
    
}

- (IBAction)SignInShowBtn:(id)sender {
    
     self.signInslide.hidden = NO;
     self.signUpslide.hidden = YES;
    
    self.nameline.hidden = YES ;
    self.txtFullName.hidden = YES ;
    
    _agreeTemsLine.hidden =YES;
    _tmsandcond.hidden =YES;
    self.fgtPwd.hidden = NO;
    
    self.signBtn.tag = 100;
    
    self.fbBtn.tag = 100;
    self.gpBtn.tag = 100;
    
    self.txtFullName.text =@"null" ;
    self.txtPassword.text =@"" ;
    
   // CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect newFrame1 = self.backgroundView.frame;
    
    newFrame1.origin.y = self.txtFullName.frame.size.height*2;
    
    [self.backgroundView setFrame:newFrame1];
    
    [self.signBtn setTitle:@"Sign In" forState:UIControlStateNormal];
    
    
   // self.backgroundView.frame = CGRectMake(0, 60, width, 230);
    
}


-(void) AlignTextAndImageOfButton:(UIButton *)button
{
    CGFloat spacing = 15; // the amount of spacing to appear between image and title
    button.imageView.backgroundColor=[UIColor clearColor];
    
    
  //  button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height   + spacing), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = button.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, -     titleSize.width);
}
@end
