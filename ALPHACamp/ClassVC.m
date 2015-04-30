//
//  ClassVC.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 3/29/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "ClassVC.h"
#import "ClassInfoModel.h"

@interface ClassVC() 
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (strong, nonatomic) ClassInfo *classInfo;
@end

@implementation ClassVC

- (void)awakeFromNib
{
    self.classInfo = [[ClassInfo alloc] init];
}

- (void)viewDidLoad{
    [self setupUI];
    
    [self.classInfo fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kNOTIFICATION_CLASSINFO_FOUND object:nil];
}

- (void)setupUI
{
    // "select another class" button at right side
    UIBarButtonItem *classBarButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇課程" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    classBarButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItems = @[classBarButton];
    
    // setup footer view of tableView
    _classTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)updateTable
{
    [self.classTableView reloadData];
}

 - (void)test
{
    NSLog(@"Another class button pressed");
}

- (void)toClassDetail
{
    NSLog(@"to class detail");
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
    //if (section == 0) {
        return 30;
    //}
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Text Color & Background color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor blackColor];
    //[header.textLabel setTextColor:[UIColor blackColor]];
    header.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"classTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.classInfo.classDownloadInfo[@"syllabus"][indexPath.section][@"lessons"][indexPath.row][@"name"];
    
//    cell.detailTextLabel.textColor = [UIColor grayColor];
//    cell.detailTextLabel.text = self.classInfo.classDownloadInfo[@"syllabus"][indexPath.section][@"lessons"][indexPath.row][@"url"];

    return cell;
}





@end
