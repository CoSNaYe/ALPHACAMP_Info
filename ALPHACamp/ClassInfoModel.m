//
//  ClassInfoModel.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "ClassInfoModel.h"
#import <AFNetworking/AFNetworking.h>

#define BaseURLString @"https://dojo.alphacamp.co"
@implementation ClassInfo

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _classDownloadInfo = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)fetchData
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"auth_token" : [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"]};
    
    if ( manager.reachabilityManager ) {
        [manager GET:@"/api/v1/courses/ios-bootcamp-4" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            self.classDownloadInfo = [[NSDictionary alloc] initWithDictionary:responseObject];
            NSLog(@"%@", self.classDownloadInfo);
            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_CLASSINFO_FOUND object:self];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Class download error: %@", [error localizedDescription]);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"下載錯誤" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }];
    }

}

@end
