//
//  EventDetail.h
//  Hobbistan
//
//  Created by Varun on 10/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetail : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *wishlabel;
@property (weak, nonatomic) IBOutlet UIImageView *wishImg;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet UILabel *lblEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblEntery;
@property (weak, nonatomic) IBOutlet UILabel *lblContact;
@property (weak, nonatomic) IBOutlet UILabel *lblMail;
@property (weak, nonatomic) IBOutlet UILabel *lblWebSite;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;
@property (strong, nonatomic) Event *eventObject;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *timeInsideView;

@property (weak, nonatomic) IBOutlet UIView *dateInsideView;
@property (weak, nonatomic) IBOutlet UIImageView *calender;
@property (weak, nonatomic) IBOutlet UIView *staticLabel;
@property (weak, nonatomic) IBOutlet UILabel *staticTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *staticToTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromTime;
@property (weak, nonatomic) IBOutlet UILabel *toTime;

@property (weak, nonatomic) IBOutlet UIView *dateView;
- (IBAction)backToMainBtn:(id)sender;
- (IBAction)bookmarkAction:(id)sender;
@end
