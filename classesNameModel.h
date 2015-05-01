//
//  classesNameModel.h
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/30/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassesNameModel : NSObject
@property (strong, nonatomic) NSDictionary *classesName;

- (void)getClassesName;
@end
