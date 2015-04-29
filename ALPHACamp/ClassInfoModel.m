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
        _classes = [[NSMutableArray alloc] init];
        [_classes addObject:@"Week1: 認識ALPHA CAMP"];
        [_classes addObject:@"Week2: 認識創業"];
    }
    return self;
}

- (void)fetchData
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"]);
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"auth_token" : [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"]};
    
    if ( manager.reachabilityManager ) {
        [manager GET:@"/api/v1/courses" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"下載錯誤" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }];
    }

}

@end
