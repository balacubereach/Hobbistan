//
//  RankViewController.m
//  Hobbistan
//
//  Created by Khagesh on 23/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "PhotoSharingController.h"
#import "PhotoSharingCell.h"

static NSString *const kPhotoSharingCellIndentifier = @"PhotoSharingCell";

@interface PhotoSharingController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableDictionary *groupPicDic;
@end

@implementation PhotoSharingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pointsLbl.text = self.points;
    self.levelLbl.text = [NSString stringWithFormat:@"Totol Photos %@",self.levelStr];
    
    [self.navigationController setLeftTitle:@"PHOTOS"];

    [self.tableView registerNib:[UINib nibWithNibName:kPhotoSharingCellIndentifier bundle:nil] forCellReuseIdentifier:kPhotoSharingCellIndentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadScreen {
    
    self.groupPicDic = [NSMutableDictionary dictionary];
    
    for (NSDictionary *picDic in self.dataArr) {
        
        NSMutableArray *picArr = self.groupPicDic[picDic[@"date"]];
        if (!picArr) {
            
            picArr = [NSMutableArray array];
        }
    
        NSString *imageStr = picDic[@"image_url"];
        
        if (imageStr != (NSString *)[NSNull null]) {
            if(imageStr && ![imageStr isEqualToString:@""]) {
                
                [picArr addObject:picDic[@"image_url"]];
            }
        }
        
        if (picArr.count > 0) {
            [self.groupPicDic setObject:picArr forKey:picDic[@"date"]];
        }
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1.0];;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 30, 30)];
    imgView.image = [UIImage imageNamed:@"photo"];
    [headerView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46, 7, kScreenWidth-54, 30)];
    label.textColor = [UIColor brownColor];
    label.text = @"Photos";
    [headerView addSubview:label];
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.groupPicDic allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoSharingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPhotoSharingCellIndentifier];
    
    NSArray *keyArr = [self.groupPicDic allKeys];
    NSString *key = keyArr[indexPath.row];
    [cell loadCell:self.groupPicDic[key] key:key];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 98;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
