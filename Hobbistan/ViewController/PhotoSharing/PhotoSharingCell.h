//
//  PhotoSharingCell.h
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSharingCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView1, *imageView2;
@property (nonatomic, weak) IBOutlet UILabel *title1, *title2, *dateLbl;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cellArr;

- (void)loadCell:(NSArray *)cellArr key:(NSString *)key;
@end
