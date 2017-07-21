//
//  TUserDirectory.h
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUserDirectory : NSObject

+ (NSString *)userHomeDirectory;

+ (NSString *)userCacheDirectory;

+ (NSString *)userDocumentDirectory;

+ (NSString *)userTempDirectory;

@end
