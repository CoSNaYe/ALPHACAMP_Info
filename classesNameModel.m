//
//  classesNameModel.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/30/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "classesNameModel.h"
#import <AFNetworking/AFNetworking.h>
#import "ClassConstants.h"

//#define BaseURLString @"https://dojo.alphacamp.co"

@implementation ClassesNameModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _classesName = [[NSDictionary alloc] init];
        //[self getClassesName];
    }
    return self;
}

- (void)getClassesName
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"auth_token" : [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"]};
    
    if ( manager.reachabilityManager ) {
        [manager GET:@"/api/v1/courses" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            self.classesName = [[NSDictionary alloc] initWithDictionary:responseObject];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CLASSNAME_FOUND object:self];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Class download error: %@", [error localizedDescription]);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"下載錯誤" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }];
    }
}
@end
