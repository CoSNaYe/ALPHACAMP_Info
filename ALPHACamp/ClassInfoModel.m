//
//  ClassInfoModel.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "ClassInfoModel.h"

@implementation ClassInfo

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _classes = [[NSMutableArray alloc] init];
        [_classes addObject:@"Week1: 認識ALPHA CAMP"];
        [_classes addObject:@"Week2: 認識創業"];
    }
    return self;
}

@end
