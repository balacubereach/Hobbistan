//
//  ExplorerPersonalCell.h
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExplorerTab.h"

@interface ExplorerPersonalCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *pointsLbl, *visaCountLbl, *positionLbl;
@property(nonatomic, weak) IBOutlet UILabel *nextLevelLbl, *nextPositionLbl;
@property(nonatomic, weak) IBOutlet UILabel *photoSharingCount, *checkInCount, *engamentCount, *bookingCount;
@property (nonatomic, weak) IBOutlet UIImageView *userImageView;

@property(nonatomic,weak) ExplorerTab *explorerTab;

@property(nonatomic, weak) IBOutlet UILabel *levelName, *userName;

- (IBAction)sharePhotoAction:(id)sender;
- (IBAction)rankAction:(id)sender;
- (IBAction)checkInAction:(id)sender;
@end
