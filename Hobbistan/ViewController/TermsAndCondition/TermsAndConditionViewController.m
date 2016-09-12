//
//  TermsAndConditionViewController.m
//  Hobbistan
//
//  Created by Khagesh on 31/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "TermsAndConditionViewController.h"

@interface TermsAndConditionViewController ()<UINavigationControllerDelegate>

@end

@implementation TermsAndConditionViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UINavigationBar *myBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
//    
//    myBar.barTintColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:0.5];
//    
//   // UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
//    
//    UIImage *image = [UIImage imageNamed:@"back-arrow"];
//    UIButton* requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [requestButton setImage:image forState:UIControlStateNormal];
//    [requestButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//
//    
//    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithCustomView:requestButton];
//   // self.navigationItem.leftBarButtonItem = button2;
//    //
//    
//    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Terms And Conditions"];
//    
//    navigItem.leftBarButtonItem = button2;
//    
//    myBar.items = [NSArray arrayWithObjects: navigItem,nil];
// 
//
//    [self.view addSubview:myBar];
    
////    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
////    
////       [navbar setTranslucent:NO];
////    [navbar setTintColor:[UIColor whiteColor]];
////    [navbar setBarTintColor:[UIColor colorWithRed:37/255.0f green:33/255.0f blue:34/255.0f alpha:1.0]];
////    navbar.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
//  //  navbar.tag = 212;
//   
//    
//    UIBarButtonItem *btn=[[UIBarButtonItem alloc] initWithTitle:@"Back"  style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
//    self.navigationItem.leftBarButtonItem=btn;
    
     //[self.view addSubview:navbar];
    
    // Do any additional setup after loading the view.
}

-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backevent:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
