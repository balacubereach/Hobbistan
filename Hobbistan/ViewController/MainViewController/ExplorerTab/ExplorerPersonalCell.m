//
//  ExplorerPersonalCell.m
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "ExplorerPersonalCell.h"

@implementation ExplorerPersonalCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (IBAction)sharePhotoAction:(id)sender {
    
    [self.explorerTab sharePhotoAction];
}

- (IBAction)rankAction:(id)sender {
    
    [self.explorerTab rankAction];
}


- (IBAction)checkInAction:(id)sender {
    
    [self.explorerTab checkInAction];
}

- (IBAction)visaAction:(id)sender {
    
    [self.explorerTab checkInAction];
}

- (IBAction)bookingnAction:(id)sender {
    
    [self.explorerTab bookingAction];
}

- (IBAction)engamentAction:(id)sender {
    
    [self.explorerTab engamentAction];
}

- (IBAction)viewAllAction:(id)sender {
    
    [self.explorerTab viewAllAction];
}

@end
