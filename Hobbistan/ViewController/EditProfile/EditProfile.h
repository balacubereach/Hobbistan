//
//  EditProfile.h
//  Hobbistan
//
//  Created by Varun on 07/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface EditProfile : UIViewController <UITextFieldDelegate>
{
    NSString *forEditBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *nameView, *cityView, *emailView, *passwordView, *genderView, *phoneView, *occupationView, *birthdayView;
@property (strong, nonatomic) IBOutlet UIView *changePassword;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt, *cityTxt, *emailTxt, *passwordTxt, *genderTxt, *phoneTxt, *occupationTxt, *birthdayTxt,*changePwdTxt;

@property (weak, nonatomic) IBOutlet UIButton *btnEditPassword, *editBtn, *saveBtn, *userBtn;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *textArr;
- (IBAction)btnBackToMainScreen:(id)sender;

- (IBAction)saveAction:(id)sender;
- (IBAction)editAction:(UIButton *)sender;

- (IBAction)userImageAction:(UIButton *)sender;
- (IBAction)changPwdAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backrounduserImage;

@end
