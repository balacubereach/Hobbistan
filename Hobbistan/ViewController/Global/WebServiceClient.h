//
//  WebServiceClient.h
//  Bodhi
//
//  Created by Moweb_macmini on 23/09/15.
//  Copyright © 2015 Moweb-MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface WebServiceClient : NSObject{
    
    AFHTTPRequestOperationManager *managerObject;
}
+(WebServiceClient * _Nonnull)sharedInstance;
-(nonnull id)init;

-(void)GetDataFromUrl:(nonnull NSString *)url withParameters:(nullable id)parameters withSuccess:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject))success withFailure:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error))failure;

-(void)PostDataWithUrl:(nonnull NSString *)urlstr
        withParameters:(nullable id)parameters
           withSuccess:(nonnull void (^)(id _Nonnull responseObject))
success withFailure:(nonnull void (^)(NSError * _Nonnull error))failure;
    

-(void)PostDataWithImageAndUrl:(nonnull NSString *)url  withParameters:(nullable id)parameters andfilePath:(nonnull NSString *)filePath andControlName:(nonnull NSString *)controlName withSuccess:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject))success withFailure:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error))failure;

-(void)uploadImage:(NSData *)imageData userId:(NSString *)userId;

@end
