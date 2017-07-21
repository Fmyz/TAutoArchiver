//
//  TKeyedArchiver.h
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKeyedArchiver : NSObject

/*归解档*/

///归档Archiver
+ (BOOL)setObject:(id)anObject forKey:(NSString *)key forDirectoryPath:(NSString *)directorypath;

///解档Unarchiver
+ (id)objectForKey:(NSString *)key forDirectoryPath:(NSString *)directorypath;

@end
