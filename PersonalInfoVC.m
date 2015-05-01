//
//  PersonalInfoVC.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 3/26/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "CorePartnerLibary.h"

@interface PersonalInfoVC(){
    NSInteger personIndex;
    BOOL nextOrPreviousPerson;   //next:TRUE, previous: FALSE
}
@property (strong, nonatomic) CorePartnerLibary *corePartner;
@property (weak, nonatomic) IBOutlet UIImageView *personPic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation PersonalInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeNext)];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePrevious)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)swipeNext
{
    nextOrPreviousPerson = true;  //next:TRUE, previous: FALSE
    [self anotherPerson];
}

- (void)swipePrevious
{
    nextOrPreviousPerson = false;  //next:TRUE, previous: FALSE
    [self anotherPerson];
}

- (void)updateUI
{
    _personPic.image = [UIImage imageNamed: [self.corePartner.peoples[personIndex] objectForKey:@"image"]];
    _nameLabel.text = [NSString stringWithFormat:@"%@",[self.corePartner.peoples[personIndex] objectForKey:@"name"]];
    _descriptionLabel.text = [self.corePartner.peoples[personIndex] objectForKey:@"description"];
}

- (CorePartnerLibary *)corePartner
{
    if (!_corePartner) {
        _corePartner = [[CorePartnerLibary alloc] init];
    }
    return _corePartner;
}

- (IBAction)nextButton:(UIButton *)sender
{
    [self swipeNext];
}

- (IBAction)previousButton:(UIButton *)sender
{
    [self swipePrevious];
}
     
- (void)anotherPerson
{
    //next:TRUE, previous: FALSE
    if ( nextOrPreviousPerson ) {
        if ( personIndex == ([self.corePartner.peoples count] - 1) )
            personIndex = 0;
        else
            personIndex++;
        
    }else{
        //NSLog(@"swipe previous");
        if ( personIndex == 0 )
            personIndex = ([self.corePartner.peoples count] - 1);
        else
            personIndex--;
    }
    
    [self updateUI];
}

@end
