//
//  PersonLandingPage.m
//  ALPHACamp
//
//  Created by CoSNaYe on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "PersonLandingPage.h"
#import "PersonalInfoVC.h"

@implementation PersonLandingPage

- (void)viewDidLoad
{
    
}
- (IBAction)toPersonDetailButton:(UIButton *)sender {
    
    PersonalInfoVC *pIVC = [[PersonalInfoVC alloc] init];
    
    [self presentViewController: pIVC animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PersonalInfoVC class]]) {
        if ( [segue.identifier isEqualToString:@"toPersonalDetail"] ){
            
        }
    }
}

@end
