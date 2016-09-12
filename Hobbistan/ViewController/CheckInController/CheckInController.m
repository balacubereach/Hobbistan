//
//  CheckInController.m
//  Hobbistan
//
//  Created by Khagesh on 23/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "CheckInController.h"
#import "CheckInCell.h"

static NSString *const kCheckInCellIndentifier = @"CheckInCell";

@interface CheckInController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableDictionary *groupPicDic;
@end

@implementation CheckInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pointsLbl.text = self.points;
    
    if ([self.typeStr isEqualToString:@"2"]) {
        
        [self.navigationController setLeftTitle:@"ENGAGEMENTS"];
        self.levelLbl.text          = [NSString stringWithFormat:@"Total Engagements %@",self.levelStr];
        self.hearderLbl.text        = @"Engagements";
        self.headerImageView.image  = [UIImage imageNamed:@"engagements"];
    }
    else if ([self.typeStr isEqualToString:@"3"]) {
        
        [self.navigationController setLeftTitle:@"CHECKINS"];
        self.levelLbl.text          = [NSString stringWithFormat:@"Total Checkins %@",self.levelStr];
        self.hearderLbl.text        = @"Checkins";
        self.headerImageView.image  = [UIImage imageNamed:@"checkin"];
    }
    else if ([self.typeStr isEqualToString:@"4"]) {
        
        [self.navigationController setLeftTitle:@"BOOKINGS"];
        self.levelLbl.text          = [NSString stringWithFormat:@"Total Bookings %@",self.levelStr];
        self.hearderLbl.text        = @"Bookings";
        self.headerImageView.image  = [UIImage imageNamed:@"bookings"];
    }

    [self.tableView registerNib:[UINib nibWithNibName:kCheckInCellIndentifier bundle:nil] forCellReuseIdentifier:kCheckInCellIndentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadScreen {
    
    self.groupPicDic = [NSMutableDictionary dictionary];
    for (NSDictionary *picDic in self.dataArr) {
        
        NSString *date = picDic[@"date"];
        NSMutableArray *picArr = self.groupPicDic[date];
        if (!picArr) {
            
            picArr = [NSMutableArray array];
        }
        
        [picArr addObject:@{@"image_url":picDic[@"image_url"], @"event_name":picDic[@"event_name"]}];
        
        if (picArr.count > 0) {
            [self.groupPicDic setObject:picArr forKey:picDic[@"date"]];
        }
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 30)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 30, 20)];
    imgView.image = [UIImage imageNamed:@"engagements"];
//    [headerView addSubview:imgView];
    headerView.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1.0];
    headerView.backgroundColor = [UIColor whiteColor];


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, kScreenWidth-54, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.text = [self.groupPicDic allKeys][section];
    
    NSString *myString = label.text;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *yourDate = [dateFormatter dateFromString:myString];
    dateFormatter.dateFormat = @"dd-MMM-yyyy";

    label.text = [dateFormatter stringFromDate:yourDate];
    
    [headerView addSubview:label];
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.groupPicDic allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = [self.groupPicDic allKeys][section];
    NSArray *rowArr = self.groupPicDic[key];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *key = [self.groupPicDic allKeys][indexPath.section];
    NSArray *rowArr = self.groupPicDic[key];
    NSDictionary *rowDic = rowArr[indexPath.row];
    
    CheckInCell *cell = [tableView dequeueReusableCellWithIdentifier:kCheckInCellIndentifier];
    cell.tag = indexPath.row;
    [cell loadCell:rowDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
