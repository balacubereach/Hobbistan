//
//  EventDetail.m
//  Hobbistan
//
//  Created by Varun on 10/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.

//  Modified by UITOUX Solutions Pvt Ltd.
//

#import "EventDetail.h"
#import "ImageSliderCellCollectionViewCell.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UIImageView+WebCache.h"
#import "UIButton+Extra.h"
#import "MapEvents.h"

#define kAppDescription @"Hobbistan"
#define kAppLink @"http://www.hobbistan.com"


@interface EventDetail () {
    
    NSMutableArray *arrImages;
}

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *addressHeight, *descriptionHeight, *childViewHeight, *childViewWidth;
@property (nonatomic,weak) IBOutlet UIView *contentView, *imageBaseView, *toolBarView;
@end

@implementation EventDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(self.view.frame.size.width, 100)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    [self.collectionView setBounces:YES];
    [self.collectionView setCollectionViewLayout:self.flowLayout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[ImageSliderCellCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageSliderCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    [self sendActivity:@"1"];

    self.pageControl.numberOfPages = arrImages.count;

    CGRect rect = self.scrollView.frame;
    rect.origin.x = rect.origin.y = 0.0;
    rect.origin.y = self.imageBaseView.frame.size.height;
    rect.size.height = self.view.frame.size.height - self.imageBaseView.frame.size.height;
    self.scrollView.frame = rect;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;

    arrImages = [[NSMutableArray alloc]init];
    [arrImages addObject:self.eventObject.eventLogo];
    
    self.lblLocation.numberOfLines = 0;
    [self.lblLocation sizeToFit];
    [self displayEventDetailData];
    
    self.toolBarView.layer.cornerRadius = 20.0f;
    self.toolBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.toolBarView.layer.borderWidth = 0.5f;

//    [self.toolBarView setRoundCorner:20.0f boderColor:[UIColor clearColor]];

    [self.navigationController setLeftTitle:@"EVENT"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    self.childViewHeight.constant = self.childViewHeight.constant - self.descriptionHeight.constant - self.addressHeight.constant;
    
    self.addressHeight.constant = self.lblLocation.frame.origin.y * 2 + self.lblLocation.frame.size.height;
    
    [self.lblDescription sizeToFit];
    self.descriptionHeight.constant = self.lblDescription.frame.origin.y * 2 + self.lblDescription.frame.size.height;
    
    self.lblDescription.font = self.lblLocation.font;
    self.lblDescription.textColor = self.lblLocation.textColor;
    
    self.childViewHeight.constant = self.childViewHeight.constant + self.descriptionHeight.constant + self.addressHeight.constant;
    
    CGRect rect = self.scrollView.frame;
    rect.origin.x = rect.origin.y = 0.0;
    rect.origin.y = self.imageBaseView.frame.size.height;
    rect.size.height = self.view.frame.size.height - self.imageBaseView.frame.size.height;
    rect.size.width = self.view.frame.size.width;
    self.scrollView.frame = rect;
    self.childViewWidth.constant = self.view.frame.size.width;

    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.childViewHeight.constant + 10.0)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrImages.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width, 200);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    ImageSliderCellCollectionViewCell *cell = (ImageSliderCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
     
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ImageSliderCellCollectionViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]]  placeholderImage:[UIImage imageNamed:@"ic_launcher"]];

//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[arrImages objectAtIndex:indexPath.row]]];
//    
//    cell.imageView.image = [UIImage imageWithData: imageData];
    
    int pages = floor(self.collectionView.contentSize.width / self.collectionView.frame.size.width);
    [_pageControl setNumberOfPages:pages];
    
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    float currentPage = self.collectionView.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f)) {
        
        _pageControl.currentPage = currentPage + 1;
    }
    else {
        
        _pageControl.currentPage = currentPage;
    }
}

- (void)displayEventDetailData {
    
    self.lblEventTitle.text = self.eventObject.eventName;
    self.lblCategoryName.text = self.eventObject.categoryName;
    self.lblDate.text =[NSString stringWithFormat:@"%@\n%@",self.eventObject.startDate,self.eventObject.endDate];
    self.lblTime.text = [NSString stringWithFormat:@"%@\n%@",self.eventObject.startTime,self.eventObject.endTime];
    self.lblLocation.text = self.eventObject.eventVenue;
    self.lblEntery.text = self.eventObject.eventCost;
    self.lblContact.text = self.eventObject.contact;
    self.lblMail.text = self.eventObject.eventContactEmail;
    self.lblWebSite.text = self.eventObject.eventBanner;
    self.lblDescription.text = self.eventObject.internalBaseClassDescription;
    
    if ([appDelegate.selectedTabDetail isEqualToString:@"StaticTab"]) {
        
           // self.timeView.hidden = true;
           // self.dateView.hidden = true;
        
        //UIView *theView = [self dateView];
        
        
        self.timeView.hidden = true;
        self.dateInsideView.hidden = true;
        self.dateView.hidden = true;
        self.timeInsideView.hidden = true;
        
        
        self.fromTime.text = [NSString stringWithFormat:@"%@",self.eventObject.startTime];
        self.toTime.text = [NSString stringWithFormat:@"%@",self.eventObject.endTime];
//
//        
//        CGRect theFrame = self.staticLabel.frame;
//        
//        [_staticLabel removeFromSuperview];
//        
//        theFrame.origin.x = self.dateView.frame.origin.x;
//        theFrame.origin.y = self.dateView.frame.origin.y;
//        
//        theFrame.size.width = self.timeView.frame.size.width+self.dateView.frame.size.width;
//        theFrame.size.height = self.dateView.frame.size.height;
//        
//        
//        
//        [self.collectionView addSubview:_staticLabel];
        
        
//        self.lblDate.text =[NSString stringWithFormat:@"%@\n%@",self.eventObject.startTime,self.eventObject.endTime];
//        self.lblTime.text = @"";
//        
//        
//        
//                UIView *theView = [self dateInsideView];
//                CGRect theFrame = theView.frame;
//        
//        theFrame.size.width = self.timeView.frame.size.width+self.timeView.frame.size.width;
//        
//                theView.frame = theFrame;
//                
//               // [self.dateView addSubview:theView];
//        
//        [self.dateInsideView setFrame:theFrame];
        
        
       // self.calenderimg.image = [UIImage imageNamed:@"time-content"];
        
                
//        self.dateInsideView.hidden = YES;
//        
//        
//        UIView *theView = [self timeInsideView];
//        CGRect theFrame = theView.frame;
//        
//        [theView removeFromSuperview];
//        
//        theFrame.origin.x = 0;
//        //theFrame.origin.y = 160;
//        
//        
//        
//        theView.frame = theFrame;
//        
//        [self.dateView addSubview:theView];
        
        
//        CGRect newFrame1 = self.timeView.frame;
//        
//        newFrame1.origin.x = self.timeView.frame.size.width-self.timeView.frame.size.width;
//        // newFrame.origin.y = self.timeView.frame.origin.y;
//        
//        newFrame1.size.width = self.timeView.frame.size.width+self.timeView.frame.size.width;
//        //newFrame.size.height = self.timeView.frame.size.height;
//        
//        [self.timeView setFrame:newFrame1];
        
        
    }else{
        
        self.timeView.hidden = false;
        self.dateInsideView.hidden = false;
        self.dateView.hidden = false;
        self.timeInsideView.hidden = false;
        
        
        self.staticLabel.hidden = true;
        
        
    }
    
    
}

- (IBAction)backToMainBtn:(id)sender {
    
    [appDelegate initMainScreen];
}



- (IBAction)whatsAppAction:(id)sender {

    NSString *urlStr = @"whatsapp://send?";
    
    urlStr = [urlStr stringByAppendingFormat:@"text='%@'",kAppDescription];
    
    NSURL *whatsappURL = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        
        [[UIApplication sharedApplication] openURL: whatsappURL];
        [self sendActivity:@"1"];
    }

}

- (IBAction)facebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [tweetSheet setInitialText:kAppDescription];
        
        if (arrImages.count > 0) {
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[arrImages objectAtIndex:0]]];
            [tweetSheet addImage:[UIImage imageWithData: imageData]];
        }
        else {
           
            [tweetSheet addImage:[UIImage imageNamed:@"icon"]];
        }

        
        BOOL isYes  = [tweetSheet addURL:[NSURL URLWithString:kAppLink]];
        
        if (isYes == YES) {
            
            NSLog(@"YES");
        }
        else {
            
            NSLog(@"NO");
        }
        
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             
             switch (result)
             {
                 case SLComposeViewControllerResultCancelled:
                     
                     break;
                 case SLComposeViewControllerResultDone:
                 {
                     [self sendActivity:@"1"];
                 }
                     break;
                 default:
                     break;
             }
         }];

        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Make sure your device has an internet connection and you have at least one Facebook account setup."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)twitter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet setInitialText:kAppDescription];
        if (arrImages.count > 0) {
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[arrImages objectAtIndex:0]]];
            [tweetSheet addImage:[UIImage imageWithData: imageData]];
        }
        else {
            
            [tweetSheet addImage:[UIImage imageNamed:@"icon"]];
        }
        
        BOOL isYes  = [tweetSheet addURL:[NSURL URLWithString:kAppLink]];
        
        if (isYes == YES) {
            
            NSLog(@"YES");
        }
        else {
            NSLog(@"NO");
        }
        
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             
             switch (result)
             {
                 case SLComposeViewControllerResultCancelled:
                     
                     break;
                 case SLComposeViewControllerResultDone:
                 {
                     [self sendActivity:@"1"];
                 }
                     break;
                 default:
                     break;
             }
         }];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Hobbistan"
                                   message:@"Make sure your device has an internet connection and you have at least one Twitter account setup."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)sendActivity:(NSString *)activityId {
    
    BOOL shouldSendToServer = NO;
    if ([activityId isEqualToString:@"1"]) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMddYYYY"];
        
        NSDate *now = [[NSDate alloc] init];
        NSString *dateString = [format stringFromDate:now];
        
        NSDictionary *photoCountDic = [userDefaults objectForKey:@"PhotoCountDic"];
        NSString *photoCountStr = [photoCountDic objectForKey:dateString];
        
        NSInteger photoCount = [photoCountStr integerValue];
        if (photoCount < 3) {
            
            shouldSendToServer = YES;
        }
        
        photoCount = photoCount + 1;
        photoCountStr = [NSString stringWithFormat:@"%d",photoCount];
        NSDictionary *photoCountDic1 = @{dateString:photoCountStr};;
        [userDefaults setObject:photoCountDic1 forKey:@"PhotoCountDic"];
    }
    
    if (shouldSendToServer) {

        NSString *eventDescription = [NSString stringWithFormat:@"You have shared %@ photo.",self.eventObject.eventName];
        NSString *eventUrl = self.eventObject.eventLogo;
        [[UIHelper sharedInstance] showHudInView:self.view];
        AppDelegate *appDel = appDelegate;
        NSString *apiUrl = [NSString stringWithFormat:@"%@/user_api.php?insertActivity=true&event=%@&user=%@&ruleid=%@&activity_detail=%@&image_url=%@&ticket_count=%@",kBaseAppUrl1, self.eventObject.eventId, appDel.user.userId,activityId,eventDescription,eventUrl,@"0"];
        
        NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject) {
            
            id events = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"events %@",events);
            [[UIHelper sharedInstance] hideHudInView:self.view];
        }
        withFailure:^(NSError * _Nonnull error) {

            [[UIHelper sharedInstance] hideHudInView:self.view];
        }];
    }
}

- (IBAction)bookmarkAction:(id)sender
{
        [[UIHelper sharedInstance] showHudInView:self.view];
        AppDelegate *appDel = appDelegate;
        NSString *apiUrl = [NSString stringWithFormat:@"%@?func_name=add_event_bookmark&user_id=%@&event_id=%@",kBaseAppUrl,appDel.user.userId, self.eventObject.eventId];
        
        NSString *escapedPath = [apiUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [appDel.apiCall PostDataWithUrl:escapedPath withParameters:nil withSuccess:^(id responseObject)
         {
             
             id events = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"events %@",events);
             [[UIHelper sharedInstance] hideHudInView:self.view];
             
             self.wishImg.image = [UIImage imageNamed:@"wishlistGray"];
             self.wishlabel.textColor = [UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0];
             
             
         }
                            withFailure:^(NSError * _Nonnull error) {
                                
                                NSLog(@"error %@",error);
                                
                                [[UIHelper sharedInstance] hideHudInView:self.view];
                            }];

    }

- (IBAction)shareButtonAction:(id)sender
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Share Event Photo!!!"
                                                                    message:@""
                                                             preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *facebook = [UIAlertAction actionWithTitle:@"Facebook"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
    {
                                                   
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   [self facebook:nil];

                                               }];
    UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"Twitter"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
                                                         
                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                         [self twitter:nil];
                                                     }];
    UIAlertAction *whatsapp = [UIAlertAction actionWithTitle:@"WhatsApp"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
                                                         
                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                         [self whatsAppAction:nil];

                                                     }];


    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
    {
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    [alert addAction:facebook];
    [alert addAction:twitter];
    [alert addAction:whatsapp];
    [alert addAction:cancel];
    
    alert.popoverPresentationController.sourceView = sender;
   
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)callButtonAction:(id)sender {
    
    NSString *phoneNumberStr = self.eventObject.contact;
    if (![phoneNumberStr isEqualToString:@""])
    {
        
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:phoneNumberStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

- (IBAction)gotoMapAction:(id)sender {
    
    MapEvents *mapViewFormat = [[MapEvents alloc] initWithNibName:@"MapEvents" bundle:nil];
    mapViewFormat.popularityEventArr = [[NSMutableArray alloc] initWithObjects:self.eventObject, nil];
    mapViewFormat.isBookMark = YES;
    
    [self.navigationController pushViewController:mapViewFormat animated:YES];
}
@end
