//
//  SignUp.h
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *fgtPwd;
@property (weak, nonatomic) IBOutlet UIView *signInslide;

@property (weak, nonatomic) IBOutlet UIView *signUpslide;

@property (weak, nonatomic) IBOutlet UIButton *signBtn;

-(IBAction)termsAndCondition:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *signInShowBtn;
- (IBAction)SignUpShowBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *signUpShowBtn;

- (IBAction)SignInShowBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *nameline;
@property (weak, nonatomic) IBOutlet UIView *emailline;
@property (weak, nonatomic) IBOutlet UIView *passwordline;
@property (weak, nonatomic) IBOutlet UIButton *fbBtn;
@property (weak, nonatomic) IBOutlet UIButton *gpBtn;
@property (weak, nonatomic) IBOutlet UILabel *agreeTemsLine;

@property (weak, nonatomic) IBOutlet UIButton *tmsandcond;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;

-(void)goToNextScreenWithDictonary:(NSMutableDictionary *)userDic ;

- (CGRect)leftViewRectForBounds:(CGRect)bounds ;

@end





