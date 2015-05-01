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

@interface ClassVC() 
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (strong, nonatomic) ClassInfo *classInfo;
@property (strong, nonatomic) ClassesNameModel *className;
@end

@implementation ClassVC

- (void)awakeFromNib
{
    self.classInfo = [[ClassInfo alloc] init];
    self.className = [[ClassesNameModel alloc] init];
}

- (void)viewDidLoad{
    [self setupUI];
    //[self.classInfo fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:NOTIFICATION_DETAIL_FOUND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClassGet) name:NOTIFICATION_CLASSNAME_FOUND object:nil];
}

- (void)setupUI
{
    // "select another class" button at right side
    UIBarButtonItem *classBarButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇課程" style:UIBarButtonItemStylePlain target:self action:@selector(selectClass)];
    classBarButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItems = @[classBarButton];
    
    // setup footer view of tableView
    _classTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)updateTable
{
    [self.classTableView reloadData];
}

- (void)didClassGet
{
    //NSLog(@"Got class name");
    [self showClassDetail];
}

 - (void)selectClass
{
    [self.className getClassesName];
}

- (void)showClassDetail
{
    UIAlertController *seclectClassAlertSheet = [UIAlertController alertControllerWithTitle:@"選擇班級" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    seclectClassAlertSheet.view.tintColor = [UIColor grayColor];
    
    // create cancel button
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    [seclectClassAlertSheet addAction:cancelButton];
    
    for (int i = 0 ; i < [self.className.classesName[@"courses"] count] ; i++){
        
        NSString *className = self.className.classesName[@"courses"][i][@"name"];
        NSString *classID = self.className.classesName[@"courses"][i][@"id"];
        
        UIAlertAction *classButton = [UIAlertAction actionWithTitle:className
                                                              style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 [self.classInfo fetchDataWithCourseName:classID];
                                                             }];
        [seclectClassAlertSheet addAction:classButton];
    }
    
    [self presentViewController:seclectClassAlertSheet animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.classInfo.classDownloadInfo[@"syllabus"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.classInfo.classDownloadInfo[@"syllabus"][section][@"lessons"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
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
    //cell.backgroundColor = [UIColor colorWithRed:25/255 green:28/255 blue:43/255 alpha:0.5];
    cell.textLabel.text = self.classInfo.classDownloadInfo[@"syllabus"][indexPath.section][@"lessons"][indexPath.row][@"name"];
    
//    cell.detailTextLabel.textColor = [UIColor grayColor];
//    cell.detailTextLabel.text = self.classInfo.classDownloadInfo[@"syllabus"][indexPath.section][@"lessons"][indexPath.row][@"url"];

    return cell;
}





@end
