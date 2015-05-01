//
//  ClassVC.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 3/29/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "ClassVC.h"
#import "ClassInfoModel.h"
#import "classesNameModel.h"
#import "ClassConstants.h"
#import "generalConstant.h"
#import <AFNetworking/AFNetworking.h>
#import "LoginViewController.h"

@interface ClassVC() 
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (strong, nonatomic) ClassInfo *classInfo;
@property (strong, nonatomic) ClassesNameModel *className;
@property (strong, nonatomic) UIImageView *navigationTitleImageView;
@end

@implementation ClassVC

- (void)awakeFromNib
{
    self.classInfo = [[ClassInfo alloc] init];
    self.className = [[ClassesNameModel alloc] init];
}

- (void)viewDidLoad
{
    [self setupUI];
    
    // notification of class detailed info download completion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:NOTIFICATION_DETAIL_FOUND object:nil];
    
    // notification of class rough info download completion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClassGet) name:NOTIFICATION_CLASSNAME_FOUND object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI related
- (void)setupUI
{
    //set the navigationBar image
    self.navigationItem.titleView = self.navigationTitleImageView;
    //[self.navigationItem.titleView clipsToBounds];
    self.navigationController.navigationBar.backgroundColor = [UIColor grayColor];
    
    // "select another class" button at right side
    UIBarButtonItem *classBarButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇課程" style:UIBarButtonItemStylePlain target:self action:@selector(selectClass)];
    classBarButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItems = @[classBarButton];
    
    // "select log out" button at left side
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"登出" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    logoutButton.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItems = @[logoutButton];
    
    // setup footer view of tableView
    _classTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)updateTable
{
    [self.classTableView reloadData];
}

#pragma mark - setter & getter
- (UIImageView *)navigationTitleImageView
{
    if (!_navigationTitleImageView) {
        UIImage *myImage = [UIImage imageNamed:@"navigationImage"];
        UIImageView *titleImage = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(self.view.frame.size.width/3, 50, self.view.frame.size.width/3, 20)];
        //NSLog(@"%f", self.view.frame.size.width);
        
        titleImage.image = myImage;
        titleImage.contentMode = UIViewContentModeScaleAspectFit;
        
        _navigationTitleImageView = titleImage;
    }
    return _navigationTitleImageView;
}

#pragma mark - actions
- (void)didClassGet
{
    [self showClassDetail];
}

- (void)selectClass
{
    [self.className getClassesName];
}

- (void)logout
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BaseURLString]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"api_key": @"1c48668d3efbd358186cdfea6d9cf2697f8e7846",
                                 @"auth_token" : [[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"]};
    
    if (manager.reachabilityManager) {
        [manager POST:logoutAPIroute parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Server got user logout message.");
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Notify server after logout failed");
        }];
    }else{
        NSLog(@"Can't reach server");
    }
    
    // remove user token
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // move to login page
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)showClassDetail
{
    // create action sheet
    UIAlertController *seclectClassAlertSheet = [UIAlertController alertControllerWithTitle:@"選擇班級" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    seclectClassAlertSheet.view.tintColor = [UIColor grayColor];
    
    // create cancel button to action sheet
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    [seclectClassAlertSheet addAction:cancelButton];
    
    // add class name to action sheet as buttons
    for (int i = 0 ; i < [self.className.classesName[@"courses"] count] ; i++){
        
        NSString *className = self.className.classesName[@"courses"][i][@"name"];
        NSString *classID = self.className.classesName[@"courses"][i][@"id"];
        
        UIAlertAction *classButton = [UIAlertAction actionWithTitle:className
                                                              style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 // download class detailed info as button pressed
                                                                 [self.classInfo fetchDataWithCourseName:classID];
                                                             }];
        [seclectClassAlertSheet addAction:classButton];
    }
    
    [self presentViewController:seclectClassAlertSheet animated:YES completion:nil];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // section is divided by week or topic
    return [self.classInfo.classDownloadInfo[@"syllabus"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // how many lessons in one week or topic
    return [self.classInfo.classDownloadInfo[@"syllabus"][section][@"lessons"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // week number or topic name
    return self.classInfo.classDownloadInfo[@"syllabus"][section][@"section"][@"name"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Text Color & Background color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor orangeColor];
    header.contentView.backgroundColor = [UIColor colorWithRed:25/255 green:28/255 blue:43/255 alpha:0.8];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"classTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor blackColor];
    // show the lesson name
    cell.textLabel.text = self.classInfo.classDownloadInfo[@"syllabus"][indexPath.section][@"lessons"][indexPath.row][@"name"];
    return cell;
}

@end
