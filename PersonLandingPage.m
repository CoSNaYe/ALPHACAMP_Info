//
//  PersonLandingPage.m
//  ALPHACamp
//
//  Created by CoSNaYe on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "PersonLandingPage.h"
#import "PersonalInfoVC.h"

@interface PersonLandingPage()
@property (weak, nonatomic) IBOutlet UIButton *toPersonDetailButton;
@property (strong, nonatomic) UIImageView *navigationTitleImageView;
@end
@implementation PersonLandingPage

- (void)viewDidLoad
{
    NSLog(@"person landing page load");
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

@end
