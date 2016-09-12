//
//  ExplorerLeaderBoardsCell.h
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplorerLeaderBoardsCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView1, *imageView2;
@property (nonatomic, weak) IBOutlet UILabel *title1, *title2;
@property (nonatomic, strong) NSDictionary *cellDic;

- (void)loadCell:(NSDictionary *)cellDic;
@end
