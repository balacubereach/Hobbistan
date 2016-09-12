//
//  FilterVC.h
//  Hobbistan
//
//  Created by Zindal on 01/03/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface FilterVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *categoryDropDown;
    NIDropDown *cityDropDown;
}


@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainheightconstaraint;

      /*========= TEXTFIELD OUTLET =========*/

@property (strong, nonatomic) IBOutlet UITextField *txtfrom;
@property (strong, nonatomic) IBOutlet UITextField *txttodate;
@property (strong, nonatomic) IBOutlet UITextField *txtOneDate;

      /*========= UIBUTTON OUTLET =========*/

@property (strong, nonatomic) IBOutlet UIButton *btncategory;
@property (strong, nonatomic) IBOutlet UIButton *btncity;
@property (strong, nonatomic) IBOutlet UIButton *cancelbtn;
@property (weak, nonatomic) IBOutlet UIButton *btnToday;
@property (weak, nonatomic) IBOutlet UIButton *btnTommorow;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) MainViewController *mainControllr;

- (IBAction)cancelbtn:(id)sender;


@end
