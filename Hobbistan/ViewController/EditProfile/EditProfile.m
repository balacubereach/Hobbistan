//
//  EditProfile.m
//  Hobbistan
//
//  Created by Varun on 07/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "EditProfile.h"
#import "WebServiceClient.h"
#import "UIViewController+ECSlidingViewController.h"


@interface EditProfile () <UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, assign) NSInteger pickerType;
@property (nonatomic, strong) NSArray *cityArr, *genderArr, *occupationArr;
@property (nonatomic, strong) UIImage *userImage;

@property (nonatomic, strong) NSArray *pickerArr;

@end

@implementation EditProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.genderArr = @[@"Male", @"Female"];
    self.occupationArr = @[@"Student", @"Employed", @"Self Employed / Business", @"Home Maker", @"Other"];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    self.datePickerView.maximumDate = [NSDate date];
    [self.datePickerView addTarget:self action:@selector(selectedDate)   forControlEvents:UIControlEventValueChanged];

    self.textArr = @[self.nameTxt, self.cityTxt, self.emailTxt, self.passwordTxt, self.birthdayTxt,self.genderTxt, self.phoneTxt, self.occupationTxt];
    
    for (UITextField *textTemp in self.textArr) {
        
        textTemp.enabled = NO;
        textTemp.textColor = [UIColor lightGrayColor];
    }
    self.user = appDelegate.user;
   // NSArray *viewArr = @[self.nameView, self.cityView, self.emailView, self.birthdayView, self.genderView, self.phoneView, self.occupationView];
   
    NSArray *viewArr = @[self.nameView, self.cityView,self.passwordView, self.emailView, self.birthdayView, self.genderView, self.phoneView, self.occupationView];
    
    if ([appDelegate.user.signupType isEqualToString:@"2"]) {
        
     //   viewArr = @[self.nameView, self.cityView, self.emailView, self.passwordView, self.birthdayView, self.genderView, self.phoneView, self.occupationView ];
        
        self.passwordTxt.text = appDelegate.user.passWord;
    }else{
        
        self.passwordTxt.text = @"";
    }
    
    CGRect viewRect = self.nameView.bounds;
    viewRect.origin.y = -viewRect.size.height/2;
    
    for (UIView *view in viewArr) {
        
        view.translatesAutoresizingMaskIntoConstraints = YES;
        CGRect tempRect = view.bounds;
        tempRect.origin.y = viewRect.origin.y + viewRect.size.height;
        tempRect.size.width = [UIScreen mainScreen].bounds.size.width;
        view.frame = tempRect;
        [self.scrollView addSubview:view];
        viewRect = tempRect;
    }
    
    [self.scrollView setContentSize:CGSizeMake(viewRect.size.width,
                                               viewRect.origin.y + viewRect.size.height + 20.0)];
    
    self.editBtn.tag    = 0;
    self.saveBtn.hidden = YES;
    
//    /self.userBtn.frame.size.height/2
    
    self.userBtn.layer.cornerRadius   = 4;
    self.userBtn.clipsToBounds        = YES;
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"] != nil) {
        [self.userBtn setImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]] forState:UIControlStateNormal];
        
        self.backrounduserImage.image =[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]];
    }
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.backrounduserImage.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.backrounduserImage addSubview:blurEffectView];
    
    
//    UIView *transparentView = [[UIView alloc] initWithFrame:self.backrounduserImage.bounds];
//    //transparentView.alpha = 1.00f;
//    
//    transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//    
//    [self.backrounduserImage addSubview: transparentView];
    
  //  self.user = appDelegate.user;
    
  //  NSLog(@"%@",appDelegate.user);
    
   // AppDelegate *appDel = appDelegate;
    
    // NSLog(@"%@",appDel.user);
    
    
     NSMutableDictionary *userDic = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetail"];

    
    self.nameTxt.text = userDic[@"user_name"];
    self.cityTxt.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedCity"];
    self.emailTxt.text = userDic[@"user_email"];
    self.phoneTxt.text = userDic[@"phone"]?userDic[@"phone"]:@"";
    self.phoneTxt.placeholder=@"Enter phone number";
    self.genderTxt.text = userDic[@"gender"]?userDic[@"gender"]:@"";
    self.genderTxt.placeholder=@"Enter gender";
    self.birthdayTxt.text = userDic[@"birthday"]?userDic[@"birthday"]:@"";
    self.birthdayTxt.placeholder=@"Enter birthday";
    self.occupationTxt.text = userDic[@"occupation"]?userDic[@"occupation"]:@"";
    self.occupationTxt.placeholder=@"Enter occupation";
    
    
    self.nameTxt.text =  self.nameTxt.text.capitalizedString;
    self.cityTxt.text = self.cityTxt.text.capitalizedString;
    self.phoneTxt.text = self.phoneTxt.text.capitalizedString;
    self.genderTxt.text =  self.genderTxt.text.capitalizedString;
    self.birthdayTxt.text =  self.birthdayTxt.text.capitalizedString;
    self.occupationTxt.text = self.occupationTxt.text.capitalizedString;
    
    
    /*set the value for str */
    
    forEditBtn = @"YES";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)btnBackToMainScreen:(id)sender {
    
    [appDelegate initMainScreen];
}


- (IBAction)saveAction:(id)sender {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    
    NSString *userPassword = self.passwordTxt.text;
    if (!userPassword || [userPassword isEqualToString:@""]) {
        userPassword = self.user.passWord;
    }
    
//    if ([self.emailTxt.text isEqualToString:@""] ||
//        [self.nameTxt.text isEqualToString:@""] ||
//        [self.cityTxt.text isEqualToString:@""] ||
//        [self.genderTxt.text isEqualToString:@""] ||
//        [self.phoneTxt.text isEqualToString:@""] ||
//        [self.birthdayTxt.text isEqualToString:@""] ||
//        [self.occupationTxt.text isEqualToString:@""] ||
//        ([self.user.signupType isEqualToString:@"2"] && [self.passwordTxt.text isEqualToString:@""] )) {
//
//        UIAlertController *alert= [UIAlertController
//                                   alertControllerWithTitle:@"Hobbistan"
//                                   message:@"Please enter all required fields."
//                                   preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 
//                             }];
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
//        [[UIHelper sharedInstance] hideHudInView:self.view];
//
//    }
//    else {
    
        NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=updateProfile&user_email=%@&user_name=%@&user_id=%@&user_password=%@&user_city=%@&user_gender=%@&user_birthday=%@&user_occupation=%@&user_phone=%@",kBaseAppUrl, self.emailTxt.text, self.nameTxt.text, appDelegate.user.userId, userPassword, self.cityTxt.text,self.genderTxt.text,self.birthdayTxt.text,self.occupationTxt.text,self.phoneTxt.text];
        NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [appDelegate.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject)
    {
            
            appDelegate.user.phone = self.phoneTxt.text;
            appDelegate.user.occupation = self.occupationTxt.text;
            appDelegate.user.birthDay = self.birthdayTxt.text;
            appDelegate.user.gender = self.genderTxt.text;
            appDelegate.user.passWord = userPassword;
            appDelegate.user.userName = self.nameTxt.text;
            appDelegate.user.email = self.emailTxt.text;
            
             AppDelegate *appDel = appDelegate;
            
            appDel.user = appDelegate.user;
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
          
            NSLog(@"json %@",json);
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserDetail"];
            
            NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
            
            userDictionary[@"birthday"] = self.birthdayTxt.text ;
            userDictionary[@"func_name"] = @"sign_in";
            userDictionary[@"gender"] = self.genderTxt.text ;
            userDictionary[@"occupation"] = self.occupationTxt.text ;
            userDictionary[@"phone"] = self.phoneTxt.text;
            userDictionary[@"sign_up_type"] = @"2" ;
            userDictionary[@"user_email"] = self.emailTxt.text ;
            userDictionary[@"user_id"] = json[@"user_id"] ;
            userDictionary[@"user_name"] = self.nameTxt.text ;
            
            if(![self.passwordTxt.text isEqual: @""]){
               
                userDictionary[@"user_password"] = self.passwordTxt.text ;
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:userDictionary forKey:@"UserDetail"];

            
            [[UIHelper sharedInstance] hideHudInView:self.view];
        
        /* Disable the textfileds */
        
        self.saveBtn.hidden = YES;
        
        /* set Bool value */
        
        forEditBtn = @"YES";
        
        for (UITextField *textTemp in self.textArr)
        {
            
            textTemp.enabled = NO;
            textTemp.textColor = [UIColor lightGrayColor];
        }
        
        }
        withFailure:^(NSError * _Nonnull error) {
            NSLog(@"json %@",error);
                                     
            [[UIHelper sharedInstance] hideHudInView:self.view];
        }];

//    }
    
}

- (IBAction)editAction:(UIButton *)sender {
    
  //  sender.tag = !sender.tag;
    
    if ([forEditBtn isEqualToString:@"YES"])
    {
        /* set Bool value */
        
        forEditBtn = @"NO";
        
        self.saveBtn.hidden = NO;
        
        for (UITextField *textTemp in self.textArr) {
            
            textTemp.enabled = YES;
            textTemp.textColor = [UIColor darkGrayColor];
        }

    }
    else
    {
        /* set Bool value */
        
        forEditBtn = @"YES";

        
        self.saveBtn.hidden = YES;
        
        for (UITextField *textTemp in self.textArr) {
            
            textTemp.enabled = NO;
            textTemp.textColor = [UIColor lightGrayColor];
        }
    }
    
    self.emailTxt.enabled = NO;
    self.emailTxt.textColor = [UIColor lightGrayColor];
}

-(IBAction)cityAction:(id)sender {
    
    if (self.saveBtn.hidden) {
        return;
    }
    self.pickerType = 1;
    [self.pickerView reloadAllComponents];
    self.cityTxt.inputView = self.pickerView;

    if (self.cityArr == nil) {
        
        self.cityArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"CityArray"];
    }
    
    [self.cityTxt becomeFirstResponder];

    if (self.cityArr.count) {
        
        NSInteger index = 0;
        NSString *cityStr = @"";
        for (NSDictionary *cityDic in self.cityArr) {
            
            cityStr = cityDic[@"city_name"];
            
            if ([cityStr.lowercaseString isEqualToString:self.cityTxt.text.lowercaseString]) {
                
                break;
            }
            
            index++;
        }
        
        self.cityTxt.text = self.cityArr[index][@"city_name"];
        [self.pickerView selectRow:index inComponent:0 animated:NO];
    }
}


-(void)selectedDate {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:[self.datePickerView date]];
    self.birthdayTxt.text = dateString;
}

-(IBAction)dateOfBirthAction:(id)sender {
    
    if (self.saveBtn.hidden) {
        return;
    }

    if ([self.birthdayTxt.text isEqualToString:@""])
    {
        
        [self selectedDate];
    }
    
    self.birthdayTxt.inputView = self.datePickerView;
    [self.birthdayTxt becomeFirstResponder];
}


-(IBAction)genderAction:(id)sender {
    
    if (self.saveBtn.hidden) {
        return;
    }

    self.pickerType = 2;
    [self.pickerView reloadAllComponents];
    self.genderTxt.inputView = self.pickerView;
    
    NSInteger index = 0;
    for (NSString *genderStr in self.genderArr) {
        
        if ([genderStr.lowercaseString isEqualToString:self.genderTxt.text.lowercaseString])
        {
            break;
        }
        
        index++;
    }
    
    self.genderTxt.text = self.genderArr[index >= self.genderArr.count ? 0 :index];
    [self.pickerView selectRow:index inComponent:0 animated:NO];
    [self.genderTxt becomeFirstResponder];
}

-(IBAction)occupationAction:(id)sender {
    
    if (self.saveBtn.hidden) {
        return;
    }

    self.pickerType = 3;
    [self.pickerView reloadAllComponents];
    self.occupationTxt.inputView = self.pickerView;
    
    NSInteger index = 0;
    for (NSString *oStr in self.occupationArr) {
        
        if ([oStr.lowercaseString isEqualToString:self.occupationTxt.text.lowercaseString]) {
            
            break;
        }
        index++;
    }
    
    self.occupationTxt.text = self.occupationArr[index >= self.occupationArr.count ? 0 :index];
    [self.pickerView selectRow:index inComponent:0 animated:NO];
    [self.occupationTxt becomeFirstResponder];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (self.pickerType) {
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            return self.genderArr.count;
            break;
        case 3:
            return self.occupationArr.count;
            break;

        default:
            break;
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (self.pickerType) {
        case 1:
            return [[self.cityArr objectAtIndex:row]valueForKey:@"city_name"];
            break;
        case 2:
            return [self.genderArr objectAtIndex:row];
            break;
        case 3:
            return [self.occupationArr objectAtIndex:row];
            break;
            
        default:
            break;
    }

    return @"";
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (self.pickerType) {
        case 1: {
            self.cityTxt.text = [[self.cityArr objectAtIndex:row]valueForKey:@"city_name"];
            [[NSUserDefaults standardUserDefaults]setObject:self.cityTxt.text forKey:@"selectedCity"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
            break;
        case 2:
        {
            
            self.genderTxt.text = [self.genderArr objectAtIndex:row];
        }
            break;
        case 3:
        {
            
            self.occupationTxt.text = [self.occupationArr objectAtIndex:row];
        }
            break;

        default:
            break;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    

    int length = (int)[self getLength:textField.text];
    
    if(length == 10) {
        if(range.length == 0)
            return NO;
    }
    
    if(length == 3) {
        NSString *num = [self formatNumber:textField.text];
        textField.text = [NSString stringWithFormat:@"%@-",num];
        
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
    } else if(length == 6) {
        NSString *num = [self formatNumber:textField.text];
        textField.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
    }
    
    return YES;
}

- (int)getLength:(NSString *)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    int length = (int)[mobileNumber length];
    return length;
}

- (NSString *)formatNumber:(NSString *)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = (int)[mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
    }
    
    return mobileNumber;
}


-(IBAction)userImageAction:(id)sender {
    
    UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"Profile Picture"
                                                                   message:@"Select Picture for Profile"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Take Photo From Camera"
                                                 style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                     
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                     picker.delegate = self;
                                                     picker.allowsEditing = YES;
                                                     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                     
                                                     [self presentViewController:picker animated:YES completion:NULL];
                                                 }];
    
    UIAlertAction* library = [UIAlertAction actionWithTitle:@"Select Photo From Library" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                       UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                       picker.delegate = self;
                                                       picker.allowsEditing = YES;
                                                       picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                       
                                                       [self presentViewController:picker animated:YES completion:NULL];
                                                   }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:Camera];
    [alert addAction:library];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)changPwdAction:(id)sender {
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.userImage = info[UIImagePickerControllerEditedImage];
    [self.userBtn setImage:self.userImage forState:UIControlStateNormal];
    [self.userBtn setBackgroundImage:self.userImage forState:UIControlStateNormal];
    
    NSData *imageData = UIImagePNGRepresentation(self.userImage);
    [[WebServiceClient sharedInstance] uploadImage:imageData userId:appDelegate.user.userId];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



//-(void)uploadImage:(UIImage *)userImage userId:(NSString *)userId
//{
//    NSData *imageData = UIImagePNGRepresentation(self.userImage);
//    
//    NSString *urlString = @"http://hobbistan.com/app/hobbistan/upload.php?user_id=473";
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"%@\"\r\n", @"473.png"]] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:body];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    if (error) {
//                                                        NSLog(@"%@", error);
//                                                    } else {
//                                                        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                                                        NSLog(@"%@", text);
//                                                        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                                        NSLog(@"%@", result);
//                                                        
//                                                        self.user.userImageUrl = result[@"user_image"];
//                                                    }
//                                                }];
//    [dataTask resume];
//}
@end
