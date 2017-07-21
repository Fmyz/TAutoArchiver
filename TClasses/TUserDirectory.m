//
//  TUserDirectory.m
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "TUserDirectory.h"

@implementation TUserDirectory

+ (NSString *)userHomeDirectory
{
    return NSHomeDirectory();
}

+ (NSString *)userCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths firstObject];
    return directory;
}

+ (NSString *)userDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths firstObject];
    return directory;
    
}

+ (NSString *)userTempDirectory
{
    return NSTemporaryDirectory();
}

@end
