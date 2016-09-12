//
//  ExplorerTab.m
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "ExplorerTab.h"
#import "ExplorerPersonalCell.h"
#import "ExplorerBoardCell.h"
#import "ExplorerLeaderBoardsCell.h"
#import "ExplorerActivityCell.h"
#import "RankViewController.h"
#import "PhotoSharingController.h"
#import "CheckInController.h"
#import "StatisticsViewController.h"

static NSString *const kPersonalCellIndentifier = @"ExplorerPersonalCell";
static NSString *const kBoardCellIndentifier = @"ExplorerBoardCell";
static NSString *const kLeaderBoardCellIndentifier = @"ExplorerLeaderBoardsCell";
static NSString *const kActivityCellIndentifier = @"ExplorerActivityCell";

@interface ExplorerTab ()
@property (nonatomic, strong) NSDictionary *userPointDic;
@end

@implementation ExplorerTab

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:kPersonalCellIndentifier bundle:nil] forCellReuseIdentifier:kPersonalCellIndentifier];
    [_tableView registerNib:[UINib nibWithNibName:kBoardCellIndentifier bundle:nil] forCellReuseIdentifier:kBoardCellIndentifier];
    [_tableView registerNib:[UINib nibWithNibName:kLeaderBoardCellIndentifier bundle:nil] forCellReuseIdentifier:kLeaderBoardCellIndentifier];
    [_tableView registerNib:[UINib nibWithNibName:kActivityCellIndentifier bundle:nil] forCellReuseIdentifier:kActivityCellIndentifier];
}

#pragma mark-
#pragma tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:

            return [UIScreen mainScreen].bounds.size.width * (427.0f/320.0f);
            break;
        case 1:
            return 44.0f;
            break;
        case 2:
            return 65.0f;
            break;
            
        default:
            return 65.0f;
            break;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return nil;
            break;
        case 1:{
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 44)];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 30, 30)];
            [imgView setBackgroundColor:[UIColor blackColor]];
            [headerView addSubview:imgView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46, 7, kScreenWidth-54, 30)];
            label.textColor = [UIColor brownColor];
            label.text = @"My Board";
            [headerView addSubview:label];
            return headerView;
            break;
        }
        case 2:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 44)];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 30, 30)];
            [imgView setBackgroundColor:[UIColor blackColor]];
            [headerView addSubview:imgView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46, 7, kScreenWidth-54, 30)];
            label.textColor = [UIColor brownColor];
            label.text = @"Leaderboards";
            [headerView addSubview:label];
            return headerView;
            break;
        }
        default:
        {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 44)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, kScreenWidth-164, 30)];
            label.textColor = [UIColor brownColor];
            label.text = @"Leaderboards";
            [headerView addSubview:label];
            return headerView;
            break;
        }
            break;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return [self tableView:tableView CellForPersonalExplorer:indexPath];
            break;
        case 1:
            return [self tableView:tableView CellForBoardExplorer:indexPath];
            break;
        case 2:
            return [self tableView:tableView CellForLeaderBoardsExplorer:indexPath];
            break;
        default:
            return [self tableView:tableView CellForActivitiesExplorer:indexPath];
            break;
    }
}

- (ExplorerPersonalCell *)tableView:(UITableView *)tableView CellForPersonalExplorer:(NSIndexPath *)indexPath
{
    ExplorerPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonalCellIndentifier];
    cell.explorerTab = self;
    cell.pointsLbl.text = [self.userPointDic objectForKey:@"total_points"];
    cell.visaCountLbl.text = [self.userPointDic objectForKey:@"visa_count"];
    cell.positionLbl.text = [self.userPointDic objectForKey:@"rank"];
    cell.photoSharingCount.text = [self.userPointDic objectForKey:@"photo_sharing_count"];
    cell.engamentCount.text = [self.userPointDic objectForKey:@"engagements_count"];
    cell.checkInCount.text = [self.userPointDic objectForKey:@"checkin_count"];
    cell.bookingCount.text = [self.userPointDic objectForKey:@"booking_count"];
    
    cell.nextLevelLbl.text = [NSString stringWithFormat:@"+%@ more points for next level",[self.userPointDic objectForKey:@"pointsfornextlevel"]];
    cell.nextPositionLbl.text = [NSString stringWithFormat:@"+%@ more points for next rank",[self.userPointDic objectForKey:@"pointsfornextrank"]];
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"] != nil)
    {
        cell.userImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]];
        
    }

    cell.levelName.text = [self.userPointDic objectForKey:@"level_name"];
    cell.userName.text = appDelegate.user.userName;
    return cell;
}

- (ExplorerBoardCell *)tableView:(UITableView *)tableView CellForBoardExplorer:(NSIndexPath *)indexPath
{
    ExplorerBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:kBoardCellIndentifier];
    return cell;
}
- (ExplorerLeaderBoardsCell *)tableView:(UITableView *)tableView CellForLeaderBoardsExplorer:(NSIndexPath *)indexPath
{
    ExplorerLeaderBoardsCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeaderBoardCellIndentifier];
    return cell;
}
- (ExplorerActivityCell *)tableView:(UITableView *)tableView CellForActivitiesExplorer:(NSIndexPath *)indexPath {
    ExplorerActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivityCellIndentifier];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPoints
{
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getUserPointsDetail=true&id=%@",kBaseAppUrl1, appDel.user.userId];
    
//    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        self.userPointDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        [self.tableView reloadData];
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
    
}

- (void)sharePhotoAction
{
    

    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getSharedPhotoList=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];
    
//    NSString *apiUrl = @"http://www.mocky.io/v2/56a3a5a7250000e2359819b3";

    
    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
            PhotoSharingController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"PhotoSharingController"];
        viewController.points = photoDic[@"totalpoints"];
        viewController.levelStr = photoDic[@"photo_sharing_count"];
        viewController.dataArr = photoDic[@"allPhotos"];
        [viewController loadScreen];
            [self.navigationController pushViewController:viewController animated:YES];
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
                            
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];

}

- (void)rankAction
{
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getLeaderBoard=true",kBaseAppUrl1];
    
//    NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSArray  *rankArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if(rankArr.count) {
        
            UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
            RankViewController *viewController = (RankViewController *)[eventStoryBoard instantiateViewControllerWithIdentifier:@"RankViewController"];
            viewController.dataArr = rankArr;
            viewController.rank = [self.userPointDic objectForKey:@"rank"];
            viewController.levelStr = [self.userPointDic objectForKey:@"level_name"];
            
            [self.navigationController pushViewController:viewController animated:YES];

        }
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
                        withFailure:^(NSError * _Nonnull error) {
                            
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }];

}

- (void)checkInAction {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getCheckedInList=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];
    
//    apiUrl = @"http://www.mocky.io/v2/56a3ce9b250000153e9819bd";
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
        CheckInController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CheckInController"];
        viewController.points = photoDic[@"checkinPoints"];
        viewController.levelStr = photoDic[@"checkin_count"];
        viewController.dataArr = photoDic[@"dataArr"];
        viewController.typeStr = @"3";

        [viewController loadScreen];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
                        withFailure:^(NSError * _Nonnull error) {
                            
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }];
    
}

- (void)visaAction {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getCheckedInList=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];
    
    //    apiUrl = @"http://www.mocky.io/v2/56a3ce9b250000153e9819bd";
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
        CheckInController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CheckInController"];
        viewController.points = photoDic[@"checkinPoints"];
        viewController.levelStr = photoDic[@"checkin_count"];
        viewController.dataArr = photoDic[@"dataArr"];
        
        [viewController loadScreen];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
                            
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
}

- (void)bookingAction {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getBookingList=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];
    
    //    apiUrl = @"http://www.mocky.io/v2/56a3ce9b250000153e9819bd";
    
    [appDel.apiCall PostDataWithUrl:apiUrl withParameters:nil withSuccess:^(id responseObject) {
        
        NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
        CheckInController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CheckInController"];
        viewController.points = photoDic[@"bookingPoints"];
        viewController.levelStr = photoDic[@"booking_count"];
        viewController.dataArr = photoDic[@"dataArr"];
        viewController.typeStr = @"4";

        [viewController loadScreen];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
                        withFailure:^(NSError * _Nonnull error) {
                            
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }];
}

- (void)engamentAction {
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?getEngagementsList=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];

    [appDel.apiCall PostDataWithUrl:apiUrl
                     withParameters:nil
                        withSuccess:^(id responseObject) {
        
        NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers error:nil];
        
        UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
        CheckInController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CheckInController"];
        viewController.points = photoDic[@"engagementsPoints"];
        viewController.levelStr = photoDic[@"engagements_count"];
        viewController.typeStr = @"2";
        viewController.dataArr = photoDic[@"dataArr"];
        [viewController loadScreen];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }
    withFailure:^(NSError * _Nonnull error) {
                            
        [[UIHelper sharedInstance] hideHudInView:self.view];
    }];
}

- (void)viewAllAction
{
    
    [[UIHelper sharedInstance] showHudInView:self.view];
    AppDelegate *appDel = appDelegate;
    NSString *apiUrl = [NSString stringWithFormat:@"%@/fetchActivity.php?fetchAll=true&id=%@",kBaseAppUrl1,appDelegate.user.userId];

    [appDel.apiCall PostDataWithUrl:apiUrl
                     withParameters:nil
                        withSuccess:^(id responseObject) {
                            
                            NSDictionary  *photoDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                      options:NSJSONReadingMutableContainers error:nil];
                            UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Points" bundle:nil];
                            StatisticsViewController *viewController = [eventStoryBoard instantiateViewControllerWithIdentifier:@"StatisticsViewController"];
                            
                            viewController.totalPointsStr = [self.userPointDic objectForKey:@"total_points"];

                            [viewController loadWithDic:photoDic];

                            [self.navigationController pushViewController:viewController animated:YES];
                            
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }
                        withFailure:^(NSError * _Nonnull error) {
                            
                            [[UIHelper sharedInstance] hideHudInView:self.view];
                        }];

}
@end
