//
//  ViewController.h
//  TAutoArchiver
//
//  Created by Fmyz on 2017/7/21.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

typedef NS_ENUM(NSInteger, StudentScoreStage)
{
    StudentScoreStageStart = 0,
    StudentScoreStageMid,
    StudentScoreStageEnd,
    
};

@class BTest, CTest;
@interface ATest : NSObject <NSCoding>

@property (strong, nonatomic) NSString *uid;
@property (assign, nonatomic) int code;
@property (assign, nonatomic) BOOL flag;
@property (strong, nonatomic) NSDictionary<NSNumber *, NSString *> *scoreDict;

@property (strong, nonatomic) BTest *bTest;
@property (strong, nonatomic) NSArray<CTest *> *cTests;

@property (copy, nonatomic) NSString *nullStr;

@property (assign, nonatomic) int ignoreInt;
@property (copy, nonatomic) NSString *ignoreStr;
@property (strong, nonatomic) NSArray<CTest *> *ignoreArrs;
@property (strong, nonatomic) NSDictionary<NSNumber *, NSString *> *ignoreDics;
@property (strong, nonatomic) BTest *ignoreBTest;

@property (copy, nonatomic) NSString *allowStr;

@end

@interface BTest : NSObject <NSCoding>

@property (assign, nonatomic) int age;
@property (copy, nonatomic) NSString *area;
@property (assign, nonatomic) BOOL flag;
@property (assign, nonatomic) CGFloat height;

@property (copy, nonatomic) NSString *nullStr;

@end

@interface CTest : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger phone;
@property (assign, nonatomic) BOOL flag;

@property (copy, nonatomic) NSString *nullStr;

@end
