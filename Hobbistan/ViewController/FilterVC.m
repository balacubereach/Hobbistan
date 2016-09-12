//
//  FilterVC.m
//  Hobbistan
//
//  Created by Zindal on 01/03/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.

#import "FilterVC.h"
#import "NIDropDown.h"
#import "MainViewController.h"
#import "HomeTabController.h"
#import "Event.h"

@interface FilterVC() < UITextFieldDelegate, UIGestureRecognizerDelegate >

@property (nonatomic, strong) NSMutableArray *selectedCategory;
@property (nonatomic, copy)  NSString *selectedCity, *fromStr, *toStr, *oneDateSelected;
@property (nonatomic, assign) BOOL isTodaySelected, isTomorrowSelected;

@property (nonatomic, weak) IBOutlet UIToolbar *toolBar;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, assign) NSInteger datePickerType;
@end

@implementation FilterVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSData *saveMasterPreference =  [[NSUserDefaults standardUserDefaults] objectForKey:@"masterPreferenceJSON"];
    NSArray *categoryArr = [NSJSONSerialization JSONObjectWithData:saveMasterPreference
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in categoryArr) {
        
        [arr addObject:dic[@"category"]];
    }
    
    categoryDropDown = [[NIDropDown alloc] init];
    categoryDropDown.delegate = self;
    
    cityDropDown = [[NIDropDown alloc] init];
    cityDropDown.delegate = self;
    
    //Default Settings
    
   // self.btnToday.backgroundColor       = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
   // self.btnTommorow.backgroundColor    = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
   // self.txtOneDate.backgroundColor     = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    
    self.btnToday.layer.borderColor      = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.btnToday.layer.borderWidth      = 1.0;
    
    self.btnTommorow.layer.borderColor   = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.btnTommorow.layer.borderWidth   = 1.0;
    
    self.txtOneDate.layer.borderColor    = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.txtOneDate.layer.borderWidth    = 1.0;
    
    self.isTodaySelected    = [[NSUserDefaults standardUserDefaults] boolForKey:@"todayDateSort"];
    self.isTomorrowSelected = [[NSUserDefaults standardUserDefaults] boolForKey:@"tomorrowDateSort"];
    self.oneDateSelected    = [[NSUserDefaults standardUserDefaults] objectForKey:@"toDateSort"];
    self.selectedCategory   = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedCategory"]];
    self.selectedCity       = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    
    self.fromStr            = [[NSUserDefaults standardUserDefaults]objectForKey:@"fromdate"];
    self.toStr              = [[NSUserDefaults standardUserDefaults]objectForKey:@"todate"];
    
    if (self.isTodaySelected) {
        
        self.btnToday.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    }
    
    if (self.isTomorrowSelected) {
        
        self.btnTommorow.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    }
    
    if (self.oneDateSelected) {
        
        self.txtOneDate.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
        self.txtOneDate.text = self.oneDateSelected;
    }
    
    //selectedCategory
    if (self.selectedCategory.count > 0) {
        
        NSString *valueStr  = [self.selectedCategory componentsJoinedByString:@","];
        valueStr = [NSString stringWithFormat:@" %@",valueStr];
        [self.btncategory setTitle:valueStr forState:UIControlStateNormal];
    }
    else {
        
        [self.btncategory setTitle:@" Select Category" forState:UIControlStateNormal];
        self.selectedCategory = [NSMutableArray array];
    }
    
    if (self.selectedCity) {
        
        [self.btncity setTitle:[NSString stringWithFormat:@" %@", self.selectedCity] forState:UIControlStateNormal];
    }
    
    if (self.fromStr) {
        
        self.txtfrom.text =[NSString stringWithFormat:@" %@",self.fromStr];
    }
    
    if (self.toStr) {
        
        self.txttodate.text = [NSString stringWithFormat:@" %@",self.toStr];
    }
    
    self.datePicker.datePickerMode  = UIDatePickerModeDate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker setValue:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0] forKeyPath:@"textColor"];
    
    [self.datePicker addTarget:self
                        action:@selector(datePickerChanged:)
              forControlEvents:UIControlEventValueChanged];
    
    self.txttodate.inputView            = self.datePicker;
    self.txttodate.inputAccessoryView   = self.toolBar;
    
    self.txtfrom.inputView              = self.datePicker;
    self.txtfrom.inputAccessoryView     = self.toolBar;
    
    self.txtOneDate.inputView              = self.datePicker;
    self.txtOneDate.inputAccessoryView     = self.toolBar;
    
    self.txtOneDate.tag     = 1;
    self.txtfrom.tag        = 2;
    self.txttodate.tag      = 3;
    
    self.txtOneDate.delegate    = self;
    self.txtfrom.delegate       = self;
    self.txttodate.delegate     = self;
    
    self.txtOneDate.layer.cornerRadius      = 4.0;
    self.btnToday.layer.cornerRadius        = 4.0;
    self.btnTommorow.layer.cornerRadius     = 4.0;
    
     self.btncategory.layer.cornerRadius    = 4.0;
     self.btncity.layer.cornerRadius        = 4.0;
    
    self.txtfrom.layer.cornerRadius     = 4.0;
    self.txttodate.layer.cornerRadius   = 4.0;
    self.cancelbtn.layer.cornerRadius   = 4.0;
    self.searchBtn.layer.cornerRadius   = 4.0;
    
    [self.btncategory setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 50.0f)];
    
    self.btncategory.layer.borderColor  = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.btncategory.layer.borderWidth  = 1.0;
    self.btncity.layer.borderColor      = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.btncity.layer.borderWidth      = 1.0;
    self.txtfrom.layer.borderColor      = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.txtfrom.layer.borderWidth      = 1.0;
    self.txttodate.layer.borderColor    = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.txttodate.layer.borderWidth    = 1.0;
    self.cancelbtn.layer.borderColor    = [[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor];
    self.cancelbtn.layer.borderWidth    = 1.0;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSingleTap)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
   [self.txtOneDate  setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.txtfrom  setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txttodate  setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.txtfrom .font = [UIFont systemFontOfSize:12.0f];
    
    self.txttodate.font = [UIFont systemFontOfSize:12.0f];
    
//    UIColor *color = [UIColor lightTextColor];
//    self.btnToday.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PlaceHolder Text" attributes:@{NSForegroundColorAttributeName: color}];
    
   // [self.btnToday setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categorybtnClicked:(id)sender {
    
    if (categoryDropDown.isShown) {
        
        [categoryDropDown hideDropDown:sender];
        
        [self.btncategory setTitle:[NSString stringWithFormat:@" %@", [self.selectedCategory componentsJoinedByString:@","]] forState:UIControlStateNormal];
        
        if (self.selectedCategory.count == 0) {
            
            [self.btncategory setTitle:@" Select Category" forState:UIControlStateNormal];
        }
        
    }
    else {
        
        NSData *saveMasterPreference =  [[NSUserDefaults standardUserDefaults] objectForKey:@"masterPreferenceJSON"];
        NSArray *categoryArr = [NSJSONSerialization JSONObjectWithData:saveMasterPreference options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in categoryArr) {
            
            
            
            [arr addObject:[dic[@"category"] capitalizedString]];
        }
        
        CGFloat f = 200;
        
        categoryDropDown.selectedRowArr = self.selectedCategory;
        [categoryDropDown showDropDown: sender :YES :&f:arr :nil :@"down"];
    }
}


- (IBAction)citybtnClicked:(id)sender {
    
    if (cityDropDown.isShown) {
        
        [cityDropDown hideDropDown:sender];
    }
    else {
        
        NSArray *cityArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"CityArray"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in cityArr) {
            
            [arr addObject:[dic[@"city_name"]capitalizedString]];
        }
        
        if (self.selectedCity) {
            
            cityDropDown.selectedRowArr = [NSMutableArray arrayWithObject:self.selectedCity];
        }
        else {
            
            cityDropDown.selectedRowArr = nil;
        }
        
        CGFloat f = 300;
        [cityDropDown showDropDown:sender :NO :&f :arr :nil :@"down"];
    }
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    
    if (self.txtOneDate.isFirstResponder) {
        self.datePickerType = 1;
    }
    
    if (self.txtfrom.isFirstResponder) {
        self.datePickerType = 2;
    }
    
    if (self.txttodate.isFirstResponder) {
        self.datePickerType = 3;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    
    if (self.datePickerType == 1) {
        
        self.oneDateSelected = strDate;
        self.txtOneDate.text = [NSString stringWithFormat:@"  %@",strDate];
    }
    else if (self.datePickerType == 2) {
        
        self.fromStr = strDate;
        self.txtfrom.text = [NSString stringWithFormat:@"  %@",strDate];
    }
    else if (self.datePickerType == 3) {
        
        self.toStr = strDate;
        self.txttodate.text = [NSString stringWithFormat:@"  %@",strDate];
    }
    
}

- (IBAction)backbtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    if(sender != nil){
        
        [[NSUserDefaults standardUserDefaults] setBool:NO    forKey:@"todayDateSort"];
        [[NSUserDefaults standardUserDefaults] setBool:NO  forKey:@"tomorrowDateSort"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"toDateSort"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedCategory"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"city"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromdate"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"todate"];
        
        self.btnToday.backgroundColor   = [UIColor clearColor];
        self.isTodaySelected = NO;
        
        self.btnTommorow.backgroundColor   = [UIColor clearColor];
        self.isTomorrowSelected = NO;
        
    }
}


-(void)viewDidLayoutSubviews
{
    self.mainheightconstaraint.constant = self.cancelbtn.frame.origin.y+self.cancelbtn.frame.size.height+20;
    self.mainscroll.contentSize = CGSizeMake(self.mainview.frame.size.width,self.mainview.frame.size.height);
}

- (IBAction)todayAction:(id)sender {
    
    if(!self.isTodaySelected) self.isTodaySelected = NO;
    self.isTodaySelected = !self.isTodaySelected;
    
    if (self.isTodaySelected) {
        
        self.btnToday.backgroundColor   = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    }
    else {
        
        self.btnToday.backgroundColor   = [UIColor clearColor];
    }
}

- (IBAction)tomorrowAction:(id)sender {
    
    if(!self.isTomorrowSelected) self.isTomorrowSelected = NO;
    self.isTomorrowSelected = !self.isTomorrowSelected;
    
    if (self.isTomorrowSelected) {
        
        self.btnTommorow.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    }
    else {
        
        self.btnTommorow.backgroundColor = [UIColor clearColor];
    }
}


- (void) selectedStr:(NSString*)rowStr :(NIDropDown *)sender {
    
    if (sender == categoryDropDown) {
        
        [self.selectedCategory addObject:rowStr];
        [self.btncategory setTitle:[NSString stringWithFormat:@" %@",[self.selectedCategory componentsJoinedByString:@","]]
                          forState:UIControlStateNormal];
    }
    
    if (sender == cityDropDown) {
        
        self.selectedCity = rowStr;
        [self.btncity setTitle:[NSString stringWithFormat:@"  %@", self.selectedCity] forState:UIControlStateNormal];
    }
}

- (void) deSelectStr:(NSString*)rowStr :(NIDropDown *)sender {
    
    if (sender == categoryDropDown) {
        
        [self.selectedCategory removeObject:rowStr];
        [self.btncategory setTitle:[NSString stringWithFormat:@" %@",[self.selectedCategory componentsJoinedByString:@","]]
                          forState:UIControlStateNormal];
        
        if (self.selectedCategory.count) {

            [self.btncategory setTitle:@" Select Category" forState:UIControlStateNormal];
        }
        
    }
}


- (IBAction)doneAction:(id)sender {
    
    if (self.txtOneDate.isFirstResponder) {
        self.datePickerType = 1;
    }
    
    if (self.txtfrom.isFirstResponder) {
        self.datePickerType = 2;
    }
    
    if (self.txttodate.isFirstResponder) {
        self.datePickerType = 3;
    }
    
    [self.txtOneDate resignFirstResponder];
    [self.txttodate resignFirstResponder];
    [self.txtfrom resignFirstResponder];
    
    if (self.datePickerType == 1) {
        self.txtOneDate.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
    }
}

- (IBAction)clearAction:(id)sender {
    
    if (self.txtOneDate.isFirstResponder) {
        self.datePickerType = 1;
    }
    
    if (self.txtfrom.isFirstResponder) {
        self.datePickerType = 2;
    }
    
    if (self.txttodate.isFirstResponder) {
        self.datePickerType = 3;
    }
    
    if (self.datePickerType == 1) {
        
        self.oneDateSelected = nil;
        self.txtOneDate.text = @"";
        
        [self.txtOneDate resignFirstResponder];
        self.txtOneDate.backgroundColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];   ///changed color
    }
    
    if (self.datePickerType == 2) {
        self.fromStr = nil;
        self.txtfrom.text = @"";
    }
    
    if (self.datePickerType == 3) {
        self.toStr = nil;
        self.txttodate.text = @"";
    }
}

- (IBAction)applyAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:self.isTodaySelected     forKey:@"todayDateSort"];
    [[NSUserDefaults standardUserDefaults] setBool:self.isTomorrowSelected  forKey:@"tomorrowDateSort"];
    [[NSUserDefaults standardUserDefaults] setObject:self.oneDateSelected   forKey:@"toDateSort"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedCategory  forKey:@"selectedCategory"];
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedCity      forKey:@"city"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.fromStr           forKey:@"fromdate"];
    [[NSUserDefaults standardUserDefaults] setObject:self.toStr             forKey:@"todate"];
    
    NSDateFormatter *dateFormattertemp = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormattertemp setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    NSDate *todayDate = [NSDate date]; // get today date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //Here we can set the format which we need
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// here convert date in
    
    if (self.isTodaySelected) {
        
        [dataDic setObject:convertedDateString forKey:@"today_date"];
    }
    
    if (self.isTomorrowSelected) {
        
        // start by retrieving day, weekday, month and year components for yourDate
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *todayComponents = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:todayDate];
        NSInteger theDay = [todayComponents day];
        NSInteger theMonth = [todayComponents month];
        NSInteger theYear = [todayComponents year];
        
        // now build a NSDate object for yourDate using these components
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:theDay];
        [components setMonth:theMonth];
        [components setYear:theYear];
        NSDate *thisDate = [gregorian dateFromComponents:components];
        
        // now build a NSDate object for the next day
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:1];
        NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
        NSString *convertedDateString = [dateFormatter stringFromDate:nextDate];// here convert date in
        
        [dataDic setObject:convertedDateString forKey:@"tomorrow_date"];
    }
    
    if (self.oneDateSelected != nil && ![self.oneDateSelected isEqualToString:@""]) {
        
        NSDate *convertedDateDate = [dateFormattertemp dateFromString:self.oneDateSelected];
        NSString *convertedDateString = [dateFormatter stringFromDate:convertedDateDate];// here convert date in
        [dataDic setObject:convertedDateString forKey:@"single_date"];
    }
    
    if (self.selectedCategory != nil && self.selectedCategory.count > 0) {
        
        NSString *valueStr  = [self.selectedCategory componentsJoinedByString:@","];
        [dataDic setObject:valueStr forKey:@"selected_category"];
    }
    
    if (self.selectedCity != nil && self.selectedCity.length > 0 && ![self.selectedCity isEqualToString:@"Select Your City"]) {
        
        [dataDic setObject:self.selectedCity forKey:@"selected_city"];
    }
    
    if (self.fromStr != nil && self.fromStr.length > 0) {
        
        [dataDic setObject:self.fromStr forKey:@"from_date"];
    }
    
    if (self.toStr != nil && self.toStr.length > 0) {
        
        [dataDic setObject:self.toStr forKey:@"to_date"];
    }
    
    [dataDic setObject:@"advanced_event_management" forKey:@"func_name"];
    
    NSString *apiUrl = kBaseAppUrl;
    [[UIHelper sharedInstance] showHudInView:self.view];
    
    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [appDelegate.apiCall PostDataWithUrl:escapedPath
                          withParameters:dataDic
                             withSuccess:^(id responseObject) {
                                 
                                 
                                 
                                 NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                           options:NSJSONReadingMutableContainers
                                                                                             error:nil];
                                 
                                 NSLog(@"responseObject %@",resultDic);
                                 NSArray *events = [resultDic objectForKey:@"events"];
                                 self.mainControllr.eventArray = [NSMutableArray array];
                                 
                                 for (NSDictionary *dic in events) {
                                     
                                     Event *event = [[Event alloc] initWithDictionary:dic];
                                     [self.mainControllr.eventArray addObject:event];
                                 }
                                 
                                 [[UIHelper sharedInstance] hideHudInView:self.view];
                                 
                                 if (self.mainControllr.eventArray.count > 0) {
                                     [self backbtn:nil];
                                     [self.mainControllr gotoSearchResultScreen];
                                 }
                                 else {
                                     
                                     UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"Alert"
                                                                                                    message:@"No Event Found."
                                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                     
                                     UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                                                  style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                                      
                                                                                  }];
                                     
                                     [alert addAction:ok];
                                     [self presentViewController:alert animated:YES completion:nil];
                                 }
                                 
                             }
                             withFailure:^(NSError * _Nonnull error) {
                                 
                                 [[UIHelper sharedInstance] hideHudInView:self.view];
                             }];
}

- (void)doSingleTap {
    
    if (categoryDropDown.isShown) {
        
        [categoryDropDown hideDropDown:self.btncategory];
        
        [self.btncategory setTitle:[NSString stringWithFormat:@" %@", [self.selectedCategory componentsJoinedByString:@","]] forState:UIControlStateNormal];
        
        if (self.selectedCategory.count == 0) {
            
            [self.btncategory setTitle:@" Select Category" forState:UIControlStateNormal];
        }
    }
    
    if (cityDropDown.isShown) {
        
        [cityDropDown hideDropDown:self.btncity];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:categoryDropDown] || [touch.view isDescendantOfView:cityDropDown]) {
        return NO;
    }
    return YES;
}
- (IBAction)cancelbtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
