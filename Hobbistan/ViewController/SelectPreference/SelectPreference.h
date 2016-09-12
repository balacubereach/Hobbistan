//
//  SelectPreference.h
//  Hobbistan
//
//  Created by KPTech on 1/6/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+XibConfiguration.h"

@interface SelectPreference : UIViewController <UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *preferenceCollectionview;
@end
