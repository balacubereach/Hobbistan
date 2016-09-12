//
//  WebServiceClient.m
//  Bodhi
//
//  Created by Moweb_macmini on 23/09/15.
//  Copyright © 2015 Moweb-MacBook. All rights reserved.
//

#import "WebServiceClient.h"
#import "AppDelegate.h"
@implementation WebServiceClient{
    AppDelegate *appDel;
}

+(WebServiceClient *)sharedInstance
{
    static WebServiceClient *webService = nil;
    
    if (webService != nil) {
        return webService;
    }
    else
    {
        webService = [[WebServiceClient alloc] init];
    }
    return webService;
}

-(id)init
{
    if (!self)
    {
        self = [super init];
    }
    managerObject = [AFHTTPRequestOperationManager manager];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    return self;
}

-(void)GetDataFromUrl:(nonnull NSString *)url withParameters:(nullable id)parameters withSuccess:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject))success withFailure:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error))failure{
    
    managerObject.requestSerializer = [AFHTTPRequestSerializer serializer];
    managerObject.responseSerializer.acceptableContentTypes = [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [managerObject GET:url parameters:parameters success:success failure:failure];

}

-(void)PostDataWithUrl:(nonnull NSString *)urlstr
        withParameters:(nullable id)parameters
           withSuccess:(nonnull void (^)(id _Nonnull responseObject))success
           withFailure:(nonnull void (^)(NSError * _Nonnull error))failure {
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    if (parameters) {
        [urlRequest setHTTPBody:[NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]]];
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           if(error == nil) {
                                                               
                                                               NSString *text = [[NSString alloc] initWithData:data
                                        encoding: NSUTF8StringEncoding];
                                                               NSLog(@"%@ :\n %@",urlstr,text);                                                               success(data);
                                                           }
                                                           else {
                                                               
                                                               failure(error);
                                                           }
                                                       }];
    [dataTask resume];
}

-(void)PostDataWithImageAndUrl:(nonnull NSString *)url  withParameters:(nullable id)parameters andfilePath:(nonnull NSString *)filePath andControlName:(nonnull NSString *)controlName withSuccess:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject))success withFailure:(nonnull void (^)(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error))failure{

    if (![filePath isEqualToString:@""]) {
        
        NSURL *filePathURL=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",filePath]];
    
        managerObject.requestSerializer = [AFHTTPRequestSerializer serializer];
        managerObject.responseSerializer.acceptableContentTypes = [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        [managerObject POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSError *error;
            [formData appendPartWithFileURL:filePathURL name:controlName error:&error];
            NSLog(@"error %@",error.localizedDescription);
        } success:success failure:failure];
    }
}

-(void)uploadImage:(NSData *)imageData userId:(NSString *)userId
{    
    NSString *urlString = [NSString stringWithFormat:@"http://hobbistan.com/app/hobbistan/upload.php?user_id=%@",userId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",userId];

    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"%@\"\r\n", fileName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSLog(@"response %@",response);
                                                    
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                        NSLog(@"%@", text);
                                                        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSLog(@"%@", result);
                                                        [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"UserImage"];

                                                        appDelegate.user.userImageUrl = result[@"user_image"];
                                                    }
                                                }];
    [dataTask resume];
}

@end
