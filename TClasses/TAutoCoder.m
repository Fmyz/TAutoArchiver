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
        NSString *ivarName = [NSString stringWithUTF8String:name];
        NSString *propertyName = [self replaceFirstUnderline:ivarName];

        if (allows.count && ![allows containsObject:propertyName]) continue;
        if ([ignores containsObject:propertyName]) continue;
        
        //利用KVC取值
        id value = [model valueForKey:ivarName];
        [encoder encodeObject:value forKey:ivarName];
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
        NSString *ivarName = [NSString stringWithUTF8String:name];
        NSString *propertyName = [self replaceFirstUnderline:ivarName];
        
        if (allows.count && ![allows containsObject:propertyName]) continue;
        if ([ignores containsObject:propertyName]) continue;
        
        //进行解档取值
        id value = [decoder decodeObjectForKey:ivarName];
        //利用KVC对属性赋值
        if (value) {
            [model setValue:value forKey:ivarName];
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

- (NSString *)replaceFirstUnderline:(NSString *)ivarName
{
    // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
    // 比如 @property(retain) NSString *abc;则 key == _abc;
    
    NSString *propertyName = ivarName;
    
    NSString *firstStr = [ivarName substringToIndex:1];
    if ([firstStr isEqualToString:@"_"]) {
        propertyName = [ivarName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    
    return propertyName;
}


@end



