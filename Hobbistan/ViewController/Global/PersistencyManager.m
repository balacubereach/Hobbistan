//
//  PersistencyManager.m
//  Hobbistan
//
//  Created by KPTech on 1/10/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager {
    NSMutableArray *preferences;
}

+ (instancetype)sharedInstance
{
    static PersistencyManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[PersistencyManager alloc] init];
        
    });
    return _sharedInstance;
}

- (id)init {
    self    = [super init];
    if (self) {
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/preferences.plist"]];
        preferences = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return self;
}

#pragma mark-
#pragma STORE PREFERENCES

- (NSArray *)getPreferences {
    return preferences;
}

- (void)addPreference:(Preference *)preference {
    [preferences addObject:preference];
}

- (void)deletePreferenceWithIndex:(NSInteger)index {
    [preferences removeObjectAtIndex:index];
}

- (void)savePreferences:(NSMutableArray *)arrData
{
    preferences = arrData;
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/preferences.plist"];
    NSLog(@"%@", filename);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:preferences];
    [data writeToFile:filename atomically:YES];
}


- (void)savePreferences
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/preferences.plist"];
    NSLog(@"%@", filename);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:preferences];
    [data writeToFile:filename atomically:YES];
}

@end
