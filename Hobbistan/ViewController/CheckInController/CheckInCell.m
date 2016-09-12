//
//  CheckInCell.m
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "CheckInCell.h"
#import "UIImageView+WebCache.h"

@implementation CheckInCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,55,55);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell:(NSDictionary *)cellDic {
    
    self.cellDic = cellDic;
    self.textLabel.text = self.cellDic[@"event_name"];
    
    NSString *imageStr = self.cellDic[@"image_url"];
    
    if (imageStr != (NSString *)[NSNull null]) {
        
        if(imageStr != nil && ![imageStr isEqualToString:@""]) {
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]
                               placeholderImage:[UIImage imageNamed:@"user"]];
        }
        else {
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:@""]
                              placeholderImage:[UIImage imageNamed:@"user"]];

        }
    }
    else {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:@""]
                          placeholderImage:[UIImage imageNamed:@"user"]];
    }
}

@end
