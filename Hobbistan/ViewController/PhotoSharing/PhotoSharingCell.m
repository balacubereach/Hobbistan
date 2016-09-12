//
//  PhotoSharingCell.m
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "PhotoSharingCell.h"
#import "UIImageView+WebCache.h"

static NSString * const reuseIdentifier = @"Cell";

@implementation PhotoSharingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCell:(NSArray *)cellArr key:(NSString *)key {
    
    self.cellArr = cellArr;
    self.dateLbl.text = key;

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.cellArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    UIImageView *imageView = [cell viewWithTag:100];
    
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        [cell addSubview:imageView];
    }
    
    NSString *imagestr = self.cellArr[indexPath.row];
    
    if(imagestr != nil && ![imagestr isEqualToString:@""]) {
     
        [imageView sd_setImageWithURL:[NSURL URLWithString:imagestr]
                     placeholderImage:[UIImage imageNamed:@"user"]];
    }

    return cell;
}

@end
