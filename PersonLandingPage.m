//
//  PersonLandingPage.m
//  ALPHACamp
//
//  Created by CoSNaYe on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "PersonLandingPage.h"
#import "PersonalInfoVC.h"
#import <AFNetworking/AFNetworking.h>

@interface PersonLandingPage()
@property (weak, nonatomic) IBOutlet UIButton *toPersonDetailButton;
@property (strong, nonatomic) UIImageView *navigationTitleImageView;
@end
@implementation PersonLandingPage

#define BaseURLString @"https://dojo.alphacamp.co"
- (void)viewDidLoad
{
    [self setupUI];
}

- (void)setupUI
{
    //set the push button
    self.toPersonDetailButton.layer.masksToBounds = YES;
    self.toPersonDetailButton.layer.cornerRadius = 3.0;
    
    //set the navigation header image
    self.navigationItem.titleView = self.navigationTitleImageView;
    self.navigationController.navigationBar.backgroundColor = [UIColor grayColor];
}

- (UIImageView *)navigationTitleImageView
{
    if (!_navigationTitleImageView) {
        UIImage *myImage = [UIImage imageNamed:@"navigationImage"];
        UIImageView *titleImage = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(self.view.frame.size.width/3, 50, self.view.frame.size.width/3, 20)];
        
        titleImage.image = myImage;
        titleImage.contentMode = UIViewContentModeScaleAspectFit;
        
        _navigationTitleImageView = titleImage;
    }
    return _navigationTitleImageView;
    
    //another way to set navigation bar image
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationImage"]];
}
- (IBAction)logoutButton:(UIButton *)sender {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"auth_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"]};
    
    if (manager.reachabilityManager) {
        [manager POST:@"/api/v1/logout" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"User logout.");
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@", [error localizedDescription]);
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                message:@"帳號/密碼錯誤"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//            
//            NSLog(@"Can't reach server");
            NSLog(@"Notify server failed");
        }];
    }else{
        NSLog(@"Can't reach server");
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
