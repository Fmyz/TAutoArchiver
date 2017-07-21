//
//  TAutoCoder.h
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/19.
//  Copyright © 2017年 Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TAutoCoding <NSObject>

@optional

///这个数组中的属性名才会进行归档
- (NSArray *)allowedCodingPropertyNames;

///这个数组中的属性名将会被忽略：不进行归档
- (NSArray *)ignoredCodingPropertyNames;

@end

@interface NSObject (TAutoCoder) <TAutoCoding>
/*用于archive编解码，model需要NSCoding代理*/

///编码 encodeWithCoder里调用
- (void)autoEncoder:(NSCoder *)encoder;

///解码 initWithCoder里调用
- (void)autoDecoder:(NSCoder *)decoder;

@end
