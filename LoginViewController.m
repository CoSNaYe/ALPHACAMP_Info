//
//  LoginViewController.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/29/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "generalConstant.h"

@interface LoginViewController () <UITextFieldDelegate> //textField delegate for textFieldShouldReturn:textField: function
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

#define kToken @"auth_token"
#define kUserID @"user_id"

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _accountTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(UIButton *)sender {
    [self loginAction];
}

- (void)loginAction
{
    [self.view endEditing:YES];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
    //                                 @"email" : self.accountTextField.text,
    //                                 @"password" : self.passwordTextField.text};
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"email" : @"c.cosnaye@gmail.com",
                                 @"password" : @"Superstar"};
    
    if (manager.reachabilityManager) {
        [manager POST:loginAPIroute parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            // store the auth_token into userDefaults
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            //NSLog(@"%@", responseObject);
            //NSString *user_id = [responseObject objectForKey:kUserID];
            
            [defaults setValue:[responseObject objectForKey:kToken] forKey:kToken];
            [defaults synchronize];
            
            // present the first tableBar
            UIViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
            [self presentViewController:mainVC animated:YES completion:nil];
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@ %@", error,  [error localizedDescription]);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"帳號/密碼錯誤"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
        
    }else{
        NSLog(@"Can't reach server");
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if ( nextResponder ) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        
        // the "return" kay for last input doing same thing as login button
        [self loginAction];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

// auto call this function if view is tapped
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // hide keyboard
    [self.view endEditing:YES];
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
