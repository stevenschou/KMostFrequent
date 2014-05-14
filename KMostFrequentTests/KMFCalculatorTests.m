//
//  KMFCalculatorTests.m
//  KMostFrequent
//
//  Created by Steven Chou on 5/12/14.
//  Copyright (c) 2014 stevenschou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KMFCalculator.h"

@interface KMFCalculatorTests : XCTestCase

@property (nonatomic, strong) KMFCalculator *calculator;

@end

@implementation KMFCalculatorTests

- (void)setUp
{
    _calculator = [[KMFCalculator alloc] init];
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSmallInput
{
    NSString *string = @"this is a test test this is a bb b b a test a";
    NSArray *result = [_calculator calculateKMostFrequent:string numberOfElements:2];
    
    XCTAssert([result containsObject:@"a"], @"result should contain the string 'a' ");
    XCTAssert([result containsObject:@"test"], @"result should contain the string 'test' ");
    
    XCTAssertEqual([result count], 2, @"size of the result should be 2");
}

- (void)testZero
{
    NSString *string = @"this is a test test this is a bb b b a test a";
    NSArray *result = [_calculator calculateKMostFrequent:string numberOfElements:0];
    
    XCTAssertEqual([result count], 0, @"size of the result should be 0");
}

- (void)testSanitizedInput
{
    NSString *string = @"this ,is &a test    test :this /is a !  a test *,a";
    NSArray *result = [_calculator calculateKMostFrequent:string numberOfElements:2];
    
    XCTAssert([result containsObject:@"a"], @"result should contain the string 'a' ");
    XCTAssert([result containsObject:@"test"], @"result should contain the string 'test' ");
    
    XCTAssertEqual([result count], 2, @"size of the result should be 2");
}

- (void)testNilInput
{
    NSString *string = nil;
    NSArray *result = [_calculator calculateKMostFrequent:string numberOfElements:2];
    
    XCTAssertEqual([result count], 0, @"size of the result should be empty");
}

@end
