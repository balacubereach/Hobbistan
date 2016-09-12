//
//  CheckInCell.h
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *cellDic;

- (void)loadCell:(NSDictionary *)cellDic;
@end
