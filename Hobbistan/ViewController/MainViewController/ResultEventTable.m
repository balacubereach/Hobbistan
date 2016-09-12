//
//  ResultEventTable.m
//  Hobbistan
//
//  Created by KPTech on 1/14/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "ResultEventTable.h"
#import "SVPullToRefresh.h"

static NSString *const kCellIdentifier = @"EventCell";

@interface ResultEventTable ()

@end

@implementation ResultEventTable

- (id)initWithSlectionBlock:(didSelectEvent)didSelectEventBlock {
    self    = [super init];
    if (self) {
        _didSelectEvent = didSelectEventBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    
}

#pragma tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)[_dataEventArray count]);
    
    return [_dataEventArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    Event *event = [_dataEventArray objectAtIndex:indexPath.row];
    [cell configCellWithEvent:event];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Event *event = [_dataEventArray objectAtIndex:indexPath.row];
    if (_didSelectEvent) {
        _didSelectEvent(event);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
