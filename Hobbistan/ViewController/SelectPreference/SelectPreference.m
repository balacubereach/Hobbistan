//
//  SelectPreference.m
//  Hobbistan
//
//  Created by KPTech on 1/6/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "SelectPreference.h"
#import "PreferenceCollectionCell.h"
#import "Preference.h"
#import "AppDelegate.h"
#import "PersistencyManager.h"
#import "NHAlignmentFlowLayout.h"

#define kDefaultIphoneSize 30.0f //cell height
#define kDefaultIphoneVerticalInsets 0.0f  //spacing between two items

static NSString * const kCellIdentifier = @"PreferenceCollectionCell";

@interface SelectPreference () {
    float actualInterItemSpacing;
    float verticalInsets;
}

@property (nonatomic, strong) NSMutableArray *preferences;
@end

@implementation SelectPreference 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_preferenceCollectionview registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellWithReuseIdentifier:kCellIdentifier];
    
    verticalInsets  = kDefaultIphoneVerticalInsets;
    if (IS_IPHONE_6P | IS_IPHONE_6) {
        verticalInsets  = 40;
    }
    
    
    NHAlignmentFlowLayout *layout = [[NHAlignmentFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    layout.alignment = NHAlignmentTopLeftAligned;
    layout.itemSize = CGSizeMake(90.0, 90.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 20.0;
    
    _preferenceCollectionview.collectionViewLayout = layout;
 
    actualInterItemSpacing  = (kScreenWidth - kDefaultIphoneSize*3 - verticalInsets*2)/2;
    
    
  //  [_preferenceCollectionview setTransform:CGAffineTransformMakeScale(-1, 1)];
    
  
  
    [self loadData];
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    Preference *pre = _preferences[indexPath.item];
    NSInteger type = [pre.size integerValue];
    
    NSLog(@" 2 %lu",(unsigned long)pre.category.length);
    NSLog(@" 2 %f",kDefaultIphoneSize);
    
//    switch (type) {
//        case 2:
//            
//            return CGSizeMake(kDefaultIphoneSize + actualInterItemSpacing, kDefaultIphoneSize);
//            break;
//        case 4:
//            
//            return CGSizeMake(kDefaultIphoneSize*2 + actualInterItemSpacing , kDefaultIphoneSize);
//            break;
//        default:
//            
//            return CGSizeMake(kDefaultIphoneSize, kDefaultIphoneSize);
//            break;
//    }
    
   // [_sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
 //   return CGSizeMake(CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame));

    
    // return CGSizeMake((kDefaultIphoneSize * pre.category.length)/4 , kDefaultIphoneSize);
    
   // return systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
    
    
    NSString *data =[NSString stringWithFormat:@"%lu",(unsigned long)pre.category.length];
    
 //   CGSize calCulateSizze =[(NSString*)data sizeWithAttributes:NULL];
    
    CGSize calCulateSizze = CGSizeFromString(data);
    
    if (pre.category.length < 10) {
        calCulateSizze.width = (pre.category.length+5)*7;
    }else{
         calCulateSizze.width = (pre.category.length+1)*7;
    }
   
    calCulateSizze.height = 30;
    
   //  NSLog(@"%lu %@",(unsigned long)calCulateSizze.width,data);
    
   // CGFloat randomWidth = (pre.category.length % 260)+30;
    
    return CGSizeMake(calCulateSizze.width, 80);
    
   //+130

}




//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    
//   // NSLog(@" 2 %f",actualInterItemSpacing);
//    
//    
//   // return actualInterItemSpacing;
//    
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    //return 8.0;
//    
//    return 10.0;
//}
//
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//
//#pragma mark - UICollectionView Datasource
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
   
    return [_preferences count];
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
   
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
PreferenceCollectionCell *cell = [_preferenceCollectionview dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Preference *pre = [_preferences objectAtIndex:indexPath.item];
    
  //  [[cell contentView] setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [cell configCellWithItem:pre];
    
   
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PreferenceCollectionCell *cell = (PreferenceCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell didselectItem];
}

- (IBAction)getStart:(id)sender {
    if ( self == [self.navigationController.viewControllers objectAtIndex:0] ) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        //[appDelegate initMainScreen];
    }
    
    [self saveSelectedPreferences];
}



#pragma mark-
#pragma Preferences Data

- (void)loadData {
    [_preferenceCollectionview setHidden:YES];
    [[UIHelper sharedInstance] showHudInView:self.view];
    if (!_preferences) {
        _preferences    = [[NSMutableArray alloc] init];
    }
    
    [self loadMasterPreference];
}

- (void)loadMasterPreference {
    
//    NSData *saveMasterPreference =  [[NSUserDefaults standardUserDefaults] objectForKey:@"masterPreferenceJSON"];
//    if (saveMasterPreference) {
//
//        [self parserMasterPreference:saveMasterPreference];
//    }
//    else {
    
        AppDelegate *appDel = appDelegate;
    
        NSString *userId = appDel.user.userId;
        NSDictionary *parameters = @{@"func_name":@"category_list", @"user_id":userId};
        NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
        
        [appDelegate.apiCall PostDataWithUrl:apiUrl
                              withParameters:parameters
                                 withSuccess:^(id responseObject) {
                                     
                                     if(responseObject) {
                                         
                                         [[NSUserDefaults standardUserDefaults] setObject:responseObject
                                                                                   forKey:@"masterPreferenceJSON"];
                                         [self parserMasterPreference:responseObject];
                                     }
                                 }
                                 withFailure:^(NSError * _Nonnull error) {
                                     
                                     [[UIHelper sharedInstance] hideHudInView:self.view];
                                 }];
//    }
}

- (void)loadSavedPreference {
    
    NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
    NSDictionary *parameters = @{@"func_name":@"view_preferences",@"user_id":appDelegate.user.userId};
    [appDelegate.apiCall PostDataWithUrl:apiUrl withParameters:parameters withSuccess:^(id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSArray* preferencesArr = json[@"result"][@"preferences"][@"category"];
        if (preferencesArr) {
            NSData *tempData = [NSJSONSerialization dataWithJSONObject:preferencesArr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *preferenceStr = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
            
            [self checkSelectPreferences:preferenceStr];
        }
        
    }
        withFailure:^(NSError * _Nonnull error) {
                                 
        [[UIHelper sharedInstance] hideHudInView:self.view];
                             }];

}

- (void)parserMasterPreference:(NSData *)responseObject {
    
    NSArray *categoryArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in categoryArr) {
        Preference *preference    = [[Preference alloc] initWithDictionary:dic];
        [self.preferences addObject:preference];
    }
    
    AppDelegate *appDel = appDelegate;
    NSString *userId = appDel.user.userId;
    
    NSString *preferenceStr = [[NSUserDefaults standardUserDefaults] objectForKey:userId];
    
    NSLog(@"self.user.userId %@",userId);
    
    //NSString *preferenceStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedPreferenceJSON"];
    
    if (preferenceStr) {
        [self checkSelectPreferences:preferenceStr];
    }
    else {
        
        [self loadSavedPreference];
    }
    [self.preferenceCollectionview setHidden:NO];
    [self.preferenceCollectionview reloadData];
    [[UIHelper sharedInstance] hideHudInView:self.view];

}

- (void)checkSelectPreferences:(NSString *)preferenceStr {
    
    NSData *preferenceData = [preferenceStr dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableArray *preferenceArr = [NSJSONSerialization JSONObjectWithData:preferenceData options:NSJSONReadingMutableContainers error:nil];
    
    if ([_preferences count] > 0 & [preferenceArr count] > 0) {
        
        NSInteger i = 0;
        for (Preference *pre in _preferences) {
            
            if ([preferenceArr containsObject:pre.cateId]) {
                
                pre.isSelected = [NSNumber numberWithBool:YES];
                //                    [_preferences replaceObjectAtIndex:i withObject:pre];
            }
            
            i++;
        }
    }
    
    [self.preferenceCollectionview reloadData];
}

- (void)saveSelectedPreferences {
    
    NSMutableArray *tempArr1 = [[NSMutableArray alloc] init];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (Preference *pre in _preferences) {
        if ([pre.isSelected boolValue]) {
            
            NSDictionary *dic = @{@"category_id":pre.cateId};
            [tempArr1 addObject:dic];
            [tempArr addObject:pre.cateId];
        }
    }
    
    if (tempArr1.count == 0) {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Please select preference"
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
     
        AppDelegate *appDel = appDelegate;
        NSString *userId = appDel.user.userId;
        
        NSDictionary *parameters = @{@"func_name":@"user_preference", @"user_id":userId,@"preferences":tempArr1};
        NSString *apiUrl = [NSString stringWithFormat:kBaseAppUrl];
        [appDelegate.apiCall PostDataWithUrl:apiUrl withParameters:parameters withSuccess:^(id responseObject) {
            
            [appDelegate initMainScreen];
        }
        withFailure:^(NSError * _Nonnull error) {
                                     
            [[UIHelper sharedInstance] hideHudInView:self.view];
        }];
        
        NSData *tempData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:nil];
        NSString *preferenceStr = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
        
        [[NSUserDefaults standardUserDefaults] setObject:preferenceStr forKey:userId];
        
        NSLog(@"self.user.userId %@",userId);
        
        //[[NSUserDefaults standardUserDefaults] setObject:preferenceStr forKey:@"savedPreferenceJSON"];
    }
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
