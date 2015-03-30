//
//  ClassVC.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 3/29/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "ClassVC.h"

@interface ClassVC() 
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@end

@implementation ClassVC

- (void)viewDidLoad{
    _classTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSLog(@"tableView did load");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"tableView will appear");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"IOS APP 開發工程師實戰營";
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
    
    cell.textLabel.text = @"test";
    return cell;
}





@end
