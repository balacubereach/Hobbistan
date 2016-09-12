//
//  SelectCity.h
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCity : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UITextField *pickerViewTextField;
    UIPickerView *pickerView;
}

@property(nonatomic, strong) NSArray *cityArr;
@property (weak, nonatomic) IBOutlet UILabel *selectedCityLbl;
- (IBAction)autoDetectAction:(id)sender;

@end
