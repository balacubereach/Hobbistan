//
//  PreferenceCollectionCell.m
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "PreferenceCollectionCell.h"
#import "UIView+Extra.h"

@implementation PreferenceCollectionCell

- (void)awakeFromNib {
    // Initialization code  //self.bounds.size.height/2
    [self.contentView setRoundCorner:40 boderColor:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]];
    [self.cellView setBackgroundColor:[UIColor clearColor]];
    
    
    //[[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]CGColor]
    
   // [self.cellView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    //CGSize CellSize =
    
    // [self.cellView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize withHorizontalFittingPriority:UILayoutPriorityDefaultHigh verticalFittingPriority:UILayoutPriorityDefaultLow]

    
}

- (void)configCellWithItem:(Preference *)preference {
    _preference = preference;
    [self updateCell];
    [self.title setText:preference.category];
    
}

- (void)didselectItem {
    if (![_preference.isSelected boolValue]) {
        _preference.isSelected  = @(1);
    } else {
        _preference.isSelected  = @(0);
    }
    [self updateCell];
}

- (void)updateCell {
    [self.cellView setBackgroundColor:nil];
    if ([_preference.isSelected boolValue]) {
        [self.cellView setBackgroundColor:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]];
    } else {
        [self.cellView setBackgroundColor:[UIColor clearColor]];
    }
    
    
}

- (void)prepareForReuse {
    
}

@end
