//
//  ExplorerLeaderBoardsCell.m
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "ExplorerLeaderBoardsCell.h"
#import "UIImageView+WebCache.h"

@implementation ExplorerLeaderBoardsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell:(NSDictionary *)cellDic {
    
    self.cellDic = cellDic;
    
    self.title1.text = self.cellDic[@"user_name"];
    self.title2.text = [NSString stringWithFormat:@" #%@ | %@ | %@",cellDic[@"rank"], cellDic[@"level_name"],self.cellDic[@"total_points"]];
    
    self.imageView1.image = [UIImage imageNamed:@"user"];
    if (self.cellDic[@"user_image"] != [NSNull null]) {
        NSLog(@"%@",self.cellDic[@"user_image"]);
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.cellDic[@"user_image"]]  placeholderImage:[UIImage imageNamed:@"user"]];
    }
}

@end
