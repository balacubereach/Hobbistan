//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
{
    BOOL ismultiple;
}
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;
@synthesize animationDirection;

- (id)showDropDown:(UIButton *)b :(BOOL)isMultiple :(CGFloat *)height :(NSArray *)arr :(NSArray *)imgArr :(NSString *)direction {
    btnSender = b;
    ismultiple = isMultiple;
    animationDirection = direction;

    self.table = (UITableView *)[super init];
    
    self.isShown = YES;

    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];

        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0;

        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        
        if (ismultiple) {
            
            table.allowsMultipleSelectionDuringEditing = YES;
            [table setEditing:YES animated:YES];
 
        }
        
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    
    self.isShown = NO;

    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"Cell";
   
    UITableViewCell *cell = nil ;//= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor redColor];
        cell.backgroundColor = [UIColor whiteColor];
    }

    cell.textLabel.text     = [list objectAtIndex:indexPath.row];
    
    if ([self.selectedRowArr containsObject:cell.textLabel.text]) {
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
   // if ( [cell.textLabel.text isEqualToString:@"Select Your City"]) {
       
        //cell.selectionStyle = UITableViewCellSelectionStyleNone ;
   // }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!ismultiple) {
    
        [self hideDropDown:btnSender];
    }

    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate selectedStr:c.textLabel.text :self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!ismultiple) {
        
        [self hideDropDown:btnSender];
    }
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate deSelectStr:c.textLabel.text :self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor colorWithRed:255/255.f green:242/255.f blue:242/255.f alpha:1.0f]];
    [cell setSelectedBackgroundView:view];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectionStyle == UITableViewCellSelectionStyleNone)
        return nil;
    
    else
        return indexPath;
}

@end
