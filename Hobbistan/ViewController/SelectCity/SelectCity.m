//
//  SelectCity.m
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "SelectCity.h"
#import "AppDelegate.h"
#import "UIView+Extra.h"
#import "SelectPreference.h"
#import <CoreLocation/CoreLocation.h>

@interface SelectCity ()<CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic, strong) CLPlacemark *placemark;
@property (weak, nonatomic) IBOutlet UIView *selectCityView, *autoDetectView;

@end

@implementation SelectCity

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [pickerView setValue:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0] forKeyPath:@"textColor"];
    
    
    [self setupAppearance];
    [self setUpPickerCity];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    self.locationManager.distanceFilter = 500;
    [self.locationManager requestWhenInUseAuthorization];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selectedCity"]) {
        self.selectedCityLbl.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedCity"];
    }
    
    
    
    [self fetchCity];
}

- (void)setupAppearance {
    
    
    
    [_selectCityView setRoundCorner:20.0f boderColor:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]];
//    [self.autoDetectView setRoundCorner:20.0f boderColor:[UIColor redColor]];
}

- (void)setUpPickerCity {
    
    
    pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pickerViewTextField];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerViewTextField.inputView = pickerView;
    
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    
   // [pickerView setValue:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0] forKeyPath:@"textColor"];
    

    if (self.cityArr == nil) {
        self.cityArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"CityArray"];
    }
    
    // add a toolbar with Cancel & Done button
  //  UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //toolBar.barStyle = UIBarStyleBlackOpaque;
    
    
  //  toolBar.barTintColor = [UIColor redColor];
    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
//    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    //pickerViewTextField.inputAccessoryView = toolBar;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.cityArr.count;
}
//-(NSString *)pickerView:(UIPickerView *)pickerView1 titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//   // NSLog(@"%ld",(long)[pickerView1 selectedRowInComponent:0]) ;
//    
//    return [[self.cityArr objectAtIndex:row]valueForKey:@"city_name"];
//}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCityLbl.text = [[self.cityArr objectAtIndex:row]valueForKey:@"city_name"];
    
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    [labelSelected setTextColor:[UIColor blackColor]];
    
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView1 viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect rowFrame = CGRectMake(00.0f, 0.0f, [pickerView1 viewForRow:row forComponent:component].frame.size.width, [pickerView viewForRow:row forComponent:component].frame.size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:rowFrame];
  //  label.font = [UIFont boldSystemFontOfSize:18.0f];
    
    // This is an array I pass to the picker in prepareForSegue:sender:
    label.text = [[self.cityArr objectAtIndex:row]valueForKey:@"city_name"];
    
    label.text = label.text.capitalizedString;
    
     label.textAlignment = NSTextAlignmentCenter;
    
    // This is an array I pass to the picker in prepareForSegue:sender:
    
    // NSLog(@"%@",[NSString stringWithFormat:@"%ld",(long)]);
    
    
    
    if (row == [pickerView selectedRowInComponent:0]) {
         label.textColor = [UIColor blackColor];
    }else{
        
         label.textColor = [UIColor redColor];
    }
   
    
    
    return label;
}

- (IBAction)selectCity:(id)sender {
    
    NSInteger index = 0;
    for (NSDictionary *cityDic in self.cityArr) {
        
        NSString *cityStr = cityDic[@"city_name"];
        if ([cityStr.lowercaseString isEqualToString:self.selectedCityLbl.text.lowercaseString]) {
            
            break;
        }
        
        index++;
    }

    [pickerView selectRow:index inComponent:0 animated:NO];
    
   
    
    
   // NSString *cityArr = [[[NSUserDefaults standardUserDefaults]valueForKey:@"CityArray"] objectAtIndex:[pickerView selectedRowInComponent:0]];
   // NSLog(@"%@", cityArr);
    

    [pickerViewTextField becomeFirstResponder];
}
//go to select preference screen
- (IBAction)swipToContinute:(id)sender {
    
    if ([self.selectedCityLbl.text.lowercaseString isEqualToString:@"select your city"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedCity"];
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Please select your city"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                   
                                                   }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        NSString *nameStr = appDelegate.user.userName;
        NSString *cityStr = self.selectedCityLbl.text;
        NSString *emailStr = appDelegate.user.email;
        NSString *phoneTxt = appDelegate.user.phone?appDelegate.user.phone:@"";
        NSString *genderTxt = appDelegate.user.gender?appDelegate.user.gender:@"";
        NSString *birthdayTxt = appDelegate.user.birthDay?appDelegate.user.birthDay:@"";
        NSString *occupationTxt = appDelegate.user.occupation?appDelegate.user.occupation:@"";
        NSString *userPassword = appDelegate.user.passWord;
        if (!userPassword || [userPassword isEqualToString:@""]) {
            userPassword = @"fkslfs";
        }

        NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=updateProfile&user_email=%@&user_name=%@&user_id=%@&user_password=%@&user_city=%@&user_gender=%@&user_birthday=%@&user_occupation=%@&user_phone=%@",kBaseAppUrl, emailStr, nameStr, appDelegate.user.userId, userPassword, cityStr,genderTxt,birthdayTxt,occupationTxt,phoneTxt];
        NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [appDelegate.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            NSLog(@"json %@",json);
            [[UIHelper sharedInstance] hideHudInView:self.view];
        }
                                 withFailure:^(NSError * _Nonnull error) {
                                     NSLog(@"json %@",error);
                                     
                                     [[UIHelper sharedInstance] hideHudInView:self.view];
                                 }];

        [[NSUserDefaults standardUserDefaults]setObject:self.selectedCityLbl.text forKey:@"selectedCity"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (appDelegate.isFromSideMenu == YES) {
            [appDelegate initMainScreen];
        }
        else {
            
            SelectPreference *preference = [[SelectPreference alloc] initWithNibName:@"SelectPreference" bundle:nil];
            [self.navigationController pushViewController:preference animated:YES];
        }
    }
}
- (IBAction)tapToDismissPicker:(id)sender {
    [pickerViewTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations firstObject];
    appDelegate.userLocation = currentLocation;
//    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        if (error == nil && [placemarks count] > 0) {
//            self.placemark = [placemarks lastObject];
//
//            for (NSDictionary *cityDic in self.cityArr) {
//                
//                NSString *cityStr = cityDic[@"city_name"];
//                if ([cityStr.lowercaseString isEqualToString:self.placemark.locality.lowercaseString]) {
//
//                    self.selectedCityLbl.text = self.placemark.locality.lowercaseString;
//                    break;
//                }
//                else if ([cityStr.lowercaseString isEqualToString:self.placemark.subAdministrativeArea.lowercaseString]) {
//                
//                    self.selectedCityLbl.text = self.placemark.subAdministrativeArea.lowercaseString;
//                    break;
//                }
//                
//            }
//        }
//        else {
//            
//            NSLog(@"%@", error.debugDescription);
//        }
//    } ];
}

- (void)fetchCity {

    [[UIHelper sharedInstance] showHudInView:self.view];

    NSDictionary *parameters = @{@"func_name":@"getCity"};
    NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
    [appDelegate.apiCall PostDataWithUrl:apiUrl withParameters:parameters withSuccess:^(id responseObject) {
        
        NSMutableArray *cityArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"CITY RESPONSE %@",cityArray);
        [cityArray insertObject:@{@"city_name":@"Select Your City", @"0" :@"Select Your City" } atIndex:0];
        [[NSUserDefaults standardUserDefaults]setObject:cityArray forKey:@"CityArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        self.cityArr = cityArray;
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
                            
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
}

- (IBAction)autoDetectAction:(id)sender {

    CLLocation *currentLocation = appDelegate.userLocation;

    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            
            for (NSDictionary *cityDic in self.cityArr) {
                
                NSString *cityStr = cityDic[@"city_name"];
                if ([cityStr.lowercaseString isEqualToString:self.placemark.locality.lowercaseString]) {
                    
                    self.selectedCityLbl.text = self.placemark.locality.lowercaseString;
                    break;
                }
                else if ([cityStr.lowercaseString isEqualToString:self.placemark.subAdministrativeArea.lowercaseString]) {
                    
                    self.selectedCityLbl.text = self.placemark.subAdministrativeArea.lowercaseString;
                    break;
                }
                
            }
        }
        else {
            
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

@end
