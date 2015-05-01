//
//  ClassInfoModel.h
//  ALPHACamp
//
//  Created by 陳逸仁 on 4/3/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassInfo : NSObject
@property (strong, nonatomic) NSDictionary *classDownloadInfo;

- (void)fetchDataWithCourseName:(NSString *)courseName;
@end
