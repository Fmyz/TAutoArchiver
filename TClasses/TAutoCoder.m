//
//  TAutoCoder.m
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "TAutoCoder.h"
#import <objc/runtime.h>

@implementation NSObject (TAutoCoder)

- (void)autoEncoder:(NSCoder *)encoder
{
    id model = self;
    if (!encoder || !model) {
        return;
    }
    
    NSArray *allows = [self getAllowedPropertyNames];
    NSArray *ignores = [self getIgnoredPropertyNames];
    
    Class class = [model class];
    unsigned int count;
    Ivar *ivar = class_copyIvarList(class, &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        NSString *compareName = [self replaceFirstUnderline:propertyName];
        if (allows.count && ![allows containsObject:compareName]) continue;
        if ([ignores containsObject:compareName]) continue;
        
        //利用KVC取值
        id value = [model valueForKey:propertyName];
        [encoder encodeObject:value forKey:propertyName];
    }
    free(ivar);
}

- (void)autoDecoder:(NSCoder *)decoder
{
    id model = self;
    if (!decoder || !model) {
        return;
    }
    
    NSArray *allows = [self getAllowedPropertyNames];
    NSArray *ignores = [self getIgnoredPropertyNames];
    
    Class class = [model class];
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList(class, &count);
    for (int i = 0; i<count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        NSString *compareName = [self replaceFirstUnderline:propertyName];
        if (allows.count && ![allows containsObject:compareName]) continue;
        if ([ignores containsObject:compareName]) continue;
        
        //进行解档取值
        id value = [decoder decodeObjectForKey:propertyName];
        //利用KVC对属性赋值
        if (value) {
            [model setValue:value forKey:propertyName];
        }
    }
    free(ivar);
}

- (NSArray *)getAllowedPropertyNames
{
    NSArray *allows = nil;
    if ([self respondsToSelector:@selector(allowedCodingPropertyNames)]) {
        allows = [self performSelector:@selector(allowedCodingPropertyNames)];
    }
    return allows;
}

- (NSArray *)getIgnoredPropertyNames
{
    NSArray *ignores = nil;
    if ([self respondsToSelector:@selector(ignoredCodingPropertyNames)]) {
        ignores = [self performSelector:@selector(ignoredCodingPropertyNames)];
    }
    return ignores;
}

- (NSString *)replaceFirstUnderline:(NSString *)propertyName
{
    // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
    // 比如 @property(retain) NSString *abc;则 key == _abc;
    
    NSString *firstStr = [propertyName substringToIndex:1];
    
    if ([firstStr isEqualToString:@"_"]) {
        propertyName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    return propertyName;
}

@end



