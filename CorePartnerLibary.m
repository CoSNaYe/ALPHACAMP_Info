//
//  CorePartnerLibary.m
//  ALPHACamp
//
//  Created by 陳逸仁 on 3/26/15.
//  Copyright (c) 2015 ALPHACamp. All rights reserved.
//

#import "CorePartnerLibary.h"

//constant string for dictionary "key"
NSString *const dName = @"name";
NSString *const dImage = @"image";
NSString *const dDescription = @"description";

@implementation CorePartnerLibary

- (instancetype)init
{
    self = [super init];
    if (self) {

    _peoples = @[@{dName : @"Bernard Chan",
                   dImage : @"bernard",
                   dDescription : @"ALPHA Camp 創辦人。TMI 駐場創業家，曾任 Yahoo！亞太區廣告業務總監。美國MIT大學創業論壇mentor"},
                 
                 @{dName : @"Brian Fang",
                   dImage : @"brain",
                   dDescription : @"FUNTEK軟體架構師，5945呼叫師傅共同創辦人，前CyberLink資深工程師。作品Picaca獲選為Apple featured app (2013/08)，暢銷書《iPhone SDK 3 Programming 應用程式開發》作者"},
                 
                 @{dName : @"Edward Chiang",
                   dImage : @"edward",
                   dDescription : @"App 開發顧問. 日傑資訊負責人，前愛料理 App 開發隊長，寫過 LovingHeart for iOS, for Android, 愛料理 for iPhone, 愛料理 for iPad, Mr. Plurk for iOS 等知名五星等級 App"}
                 ];
    }
    
    return self;
}

@end
