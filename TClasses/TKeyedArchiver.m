//
//  TKeyedArchiver.m
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "TKeyedArchiver.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TKeyedArchiver

+ (BOOL)setObject:(id)anObject forKey:(NSString *)key forDirectoryPath:(NSString *)directorypath
{
    NSString *archiverPath = directorypath;
    if (!archiverPath || archiverPath.length == 0) {
        archiverPath = [TKeyedArchiver defaultArchiverDirectory];
    }
    
    if (!key || key.length == 0) {
        key = [TKeyedArchiver defaultArchiverKey];
    }
    NSString *fileName = key;
    
    archiverPath = [archiverPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", fileName]];
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:anObject toFile:archiverPath];
    return flag;
}

+ (id)objectForKey:(NSString *)key forDirectoryPath:(NSString *)directorypath
{
    NSString *archiverPath = directorypath;
    if (!archiverPath || archiverPath.length == 0) {
        archiverPath = [TKeyedArchiver defaultArchiverDirectory];
    }
    
    if (!key || key.length == 0) {
        key = [TKeyedArchiver defaultArchiverKey];
    }
    NSString *fileName = key;
    archiverPath = [archiverPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", fileName]];
    
    id anObject = [NSKeyedUnarchiver unarchiveObjectWithFile:archiverPath];
    return anObject;
}

+ (NSString *)defaultArchiverDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths firstObject];
    return directory;
}

+ (NSString *)defaultArchiverKey
{
    NSString *key = @"tCache";
    return key;
}

@end
