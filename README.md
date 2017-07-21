# TAutoArchiver
use to KeyedArchiver, auto NSCoding

/**/
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

/**/
@implementation ATest

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
if (self = [super init]) {
[self autoDecoder:aDecoder];
}
return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
[self autoEncoder:aCoder];
}

//- (NSArray *)allowedCodingPropertyNames
//{
//    return @[@"allowStr"];
//}

//- (NSArray *)ignoredCodingPropertyNames
//{
//    return @[@"ignoreStr", @"ignoreInt", @"ignoreArrs", @"ignoreDics", @"ignoreBTest"];
//}

@end

@implementation BTest

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
if (self = [super init]) {
[self autoDecoder:aDecoder];
}
return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
[self autoEncoder:aCoder];
}

@end

@implementation CTest

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
if (self = [super init]) {
[self autoDecoder:aDecoder];
}
return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
[self autoEncoder:aCoder];
}

@end

/**/
/*TAutoCoder TKeyedArchiver*/
ATest *aTest = [[ATest alloc] init];
aTest.uid = @"TAutoArchiver1";
aTest.code = 1;
aTest.flag = YES;
aTest.scoreDict = @{ @(StudentScoreStageStart) : @"98",
@(StudentScoreStageMid) : @"89",
@(StudentScoreStageEnd) : @"85"
};

BTest *bTest = [[BTest alloc] init];
bTest.age = 16;
bTest.area = @"sz";
bTest.flag = NO;
bTest.height = 178.f;

aTest.bTest = bTest;

CTest *cTest = [[CTest alloc] init];
cTest.name = @"tfile";
cTest.phone = 12345678901;
cTest.flag = YES;

aTest.cTests = @[cTest, cTest, cTest];

aTest.ignoreStr = @"whatever, the value will ignore";
aTest.ignoreInt = 404;
aTest.ignoreArrs = aTest.cTests;
aTest.ignoreBTest = aTest.bTest;
aTest.ignoreDics = aTest.scoreDict;

aTest.allowStr = @"whatever, the value just allow";

BOOL suc = [TKeyedArchiver setObject:aTest forKey:@"info3" forDirectoryPath:nil];
NSLog(@"TKeyedArchiver setObject suc:%d", suc);

//to test，after 2s，Unarchiver
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
ATest *aTest2 = [TKeyedArchiver objectForKey:@"info3" forDirectoryPath:nil];
NSLog(@"%@", aTest2); //maybe you need description or breakpoint
});
