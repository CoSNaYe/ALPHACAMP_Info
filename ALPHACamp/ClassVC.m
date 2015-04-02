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
    _classTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *anotherClassButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇課程" style:UIBarButtonItemStylePlain target:self action:@selector(toClassDetail)];
    self.navigationItem.rightBarButtonItem = anotherClassButton;
    //[anotherButton release];
    
    
    NSLog(@"tableView did load");
}

- (void)toClassDetail
{
    NSLog(@"to class detail");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"IOS APP 開發工程師實戰營";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
    header.contentView.backgroundColor = [UIColor grayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"classTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( !cell ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
    }else{
        
    }
    
    cell.textLabel.text = self.classInfo.classes[indexPath.row];
    return cell;
}





@end
