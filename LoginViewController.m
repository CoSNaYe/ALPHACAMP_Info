//
//  LoginViewController.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/29/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UILabel *loginStatusLabel;
@end

#define BaseURLString @"https://dojo.alphacamp.co"

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(UIButton *)sender {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"email" : @"c.cosnaye@gmail.com",
                                 @"password" : @"Superstar"};
    
    if (manager.reachabilityManager) {
        [manager POST:@"/api/v1/login" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"%@", responseObject);
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
