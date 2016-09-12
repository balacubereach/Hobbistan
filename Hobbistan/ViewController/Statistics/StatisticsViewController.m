//
//  StatisticsViewController.m
//  Hobbistan
//
//  Created by Khagesh on 24/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "StatisticsViewController.h"
#import "UIImageView+WebCache.h"

static NSString * const reuseIdentifier = @"photoCell";
static NSString * const reuseIdentifier1 = @"photoCollectionCell";
static NSString * const reuseIdentifier2 = @"cell";

@interface StatisticsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *dataArr, *pointsDataArr;
@property(nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.totalPointsLbl.text = self.totalPointsStr;

    [self loadWithDic:self.dataDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)loadWithDic:(NSMutableDictionary *)dataDic {
    
    self.dataDic = dataDic;
    self.pointsDataArr = [NSMutableArray array];
    self.dataArr = self.dataDic[@"photoList"][@"allPhotos"];
    
    NSDictionary *tempDic = self.dataDic[@"photoList"];
    self.photoSharingPointsLbl.text = tempDic[@"totalpoints"];
    [self.pointsDataArr addObject:tempDic];
    
    tempDic = self.dataDic[@"engagementsList"];
    self.ePointsLbl.text = tempDic[@"engagementsPoints"];
    [self.pointsDataArr addObject:tempDic];
    
    tempDic = self.dataDic[@"checkinList"];
    self.cPointsLbl.text = tempDic[@"checkinPoints"];
    [self.pointsDataArr addObject:tempDic];
    
    tempDic = self.dataDic[@"bookingList"];
    self.bPointsLbl.text = tempDic[@"bookingPoints"];
    [self.pointsDataArr addObject:tempDic];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:100];
    
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imageView.tag = 100;
        [cell addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"user"];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    NSDictionary *cellDic = self.dataArr[indexPath.row];
    NSString *imageStr = cellDic[@"image_url"];
    
    if (imageStr != (NSString *)[NSNull null]) {
        if(imageStr && ![imageStr isEqualToString:@""]) {
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]
                         placeholderImage:[UIImage imageNamed:@"user"]];
        }
    }

    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *nameStr = @"Photos";
    NSString *imageStr = @"photo";
    NSString *totalPoint = @"0";
    NSString *totalCount = @"0";
    NSString *keyStr = @"0";

    switch (section) {
        case 0: {
            nameStr = @"Photos";
            imageStr = @"photo";
            keyStr = @"photoList";
            NSDictionary *rowDic = self.dataDic[keyStr];
            totalCount = rowDic[@"photo_sharing_count"];
            totalPoint = rowDic[@"totalpoints"];
        }
            break;
        case 1: {
            nameStr = @"Engagements";
            imageStr = @"engagements";
            keyStr = @"engagementsList";
            NSDictionary *rowDic = self.dataDic[keyStr];
            totalCount = rowDic[@"engagements_count"];
            totalPoint = rowDic[@"engagementsPoints"];
        }
            break;
        case 2: {
            nameStr = @"Checkins";
            imageStr = @"checkin";
            keyStr = @"checkinList";
            NSDictionary *rowDic = self.dataDic[keyStr];
            totalCount = rowDic[@"checkin_count"];
            totalPoint = rowDic[@"checkinPoints"];
        }
            break;
        case 3: {
            nameStr = @"Bookings";
            imageStr = @"bookings";
            keyStr = @"bookingList";
            NSDictionary *rowDic = self.dataDic[keyStr];
            totalCount = rowDic[@"booking_count"];
            totalPoint = rowDic[@"bookingPoints"];
        }
            break;

        default:
            break;
    }
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 56)];

    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 8)];
    barView.backgroundColor = [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
    [headerView addSubview:barView];
    CGFloat y = 18.0f;

    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, y, 30, 28)];
    imgView.image = [UIImage imageNamed:imageStr];
    [headerView addSubview:imgView];
    [imgView sizeToFit];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46, y, kScreenWidth-54, 28)];
    label.textColor = [UIColor brownColor];
    label.text = [NSString stringWithFormat:@"%@(%@)",nameStr, totalCount];
    [headerView addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 35.0, y, 30.0f, 28)];
    label1.textColor = [UIColor brownColor];
    label1.text = totalPoint;
    [headerView addSubview:label1];

    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 35.0 - 28 - 5, y, 30, 28)];
    imgView1.image = [UIImage imageNamed:@"Star 3"];
    [headerView addSubview:imgView1];
    [imgView1 sizeToFit];

    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray *tempArr;
    switch (section) {
        case 0:
            
            tempArr = self.dataDic[@"photoList"][@"allPhotos"];
            return 1;
            break;
        case 1:
            
            tempArr = self.dataDic[@"engagementsList"][@"dataArr"];
            break;
        case 2:
            
            tempArr = self.dataDic[@"checkinList"][@"dataArr"];
            break;
        case 3:
            
            tempArr = self.dataDic[@"bookingList"][@"dataArr"];
            break;

        default:
            break;
    }
    
    return tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];

    if (indexPath.row == 0 && indexPath.section == 0) {

        cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        [self.collectionView reloadData];
    }
    else {
        
        
        NSDictionary *cellDic = [self dictionaryForSection:indexPath];
        NSArray *cellArr = cellDic[@"dataArr"];
        NSDictionary *cellDic1 = cellArr[indexPath.row];
        NSString *title = cellDic1[@"event_name"];
        cell.textLabel.text = title;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 120;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSDictionary *)dictionaryForSection:(NSIndexPath *)indexPath {
    
    NSDictionary *tempDic;
    switch (indexPath.section) {
        case 0:
            
            tempDic = self.dataDic[@"photoList"];
            break;
        case 1:
            
            tempDic = self.dataDic[@"engagementsList"];
            break;
        case 2:
            
            tempDic = self.dataDic[@"checkinList"];
            break;
        case 3:
            
            tempDic = self.dataDic[@"bookingList"];
            break;
            
        default:
            break;
    }

    return tempDic;
}
@end
