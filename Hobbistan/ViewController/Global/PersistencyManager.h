//
//  PersistencyManager.h
//  Hobbistan
//
//  Created by KPTech on 1/10/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Preference.h"

@interface PersistencyManager : NSObject

+ (instancetype)sharedInstance;
- (NSArray*)getPreferences;
- (void)addPreference:(Preference*)preference;
- (void)deletePreferenceWithIndex:(NSInteger)index;
- (void)savePreferences:(NSMutableArray *)arrData;

@end
