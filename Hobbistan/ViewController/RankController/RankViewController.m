//
//  RankViewController.m
//  Hobbistan
//
//  Created by Khagesh on 23/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "RankViewController.h"
#import "ExplorerLeaderBoardsCell.h"

static NSString *const kLeaderBoardCellIndentifier = @"ExplorerLeaderBoardsCell";

@interface RankViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pointsLbl.text = self.rank;
    self.levelLbl.text = self.levelStr;

    [self.navigationController setLeftTitle:@"LEADERBOARD"];

    [self.tableView registerNib:[UINib nibWithNibName:kLeaderBoardCellIndentifier bundle:nil] forCellReuseIdentifier:kLeaderBoardCellIndentifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 44)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 30, 30)];
    imgView.image = [UIImage imageNamed:@"amateur trophy"];
    [headerView addSubview:imgView];
    headerView.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1.0];;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46, 7, kScreenWidth-54, 30)];
    label.textColor = [UIColor brownColor];
    label.text = @"Full Leaderboard";
    [headerView addSubview:label];
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExplorerLeaderBoardsCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeaderBoardCellIndentifier];
    cell.tag = indexPath.row;
    NSDictionary *cellDic = [self.dataArr objectAtIndex:indexPath.row];
    [cell loadCell:cellDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
