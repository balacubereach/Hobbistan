//
//  PreferenceCollectionCell.h
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Preference.h"

@interface PreferenceCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, strong) Preference *preference;
- (void)configCellWithItem:(Preference *)preference;
- (void)didselectItem;
@end
