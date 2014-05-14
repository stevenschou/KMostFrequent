//
//  KMFMinHeapTests.m
//  KMostFrequent
//
//  Created by Steven Chou on 5/12/14.
//  Copyright (c) 2014 stevenschou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KMFMinHeap.h"

@interface KMFMinHeapTests : XCTestCase

@property (nonatomic, strong) KMFMinHeap *minHeap;

@end

@implementation KMFMinHeapTests

- (void)setUp
{
    [super setUp];
    _minHeap = [[KMFMinHeap alloc] initWithSize:5 heapOrderProperty:
                       ^NSComparisonResult(KMFMinHeapElement *o1, KMFMinHeapElement *o2) {
                           if(o1.integerValue < o2.integerValue) {
                               return NSOrderedAscending;
                           }
                           else if(o1.integerValue > o2.integerValue) {
                               return NSOrderedDescending;
                           }
                           else {
                               return NSOrderedSame;
                           }
                       }];

}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBasicInsert
{
    [_minHeap insertElement:@"a" withInteger:10];
    
    NSInteger minValue = [_minHeap getMinimumValue];
    
    XCTAssertEqual(minValue, 10, @"Minimum should be 10");
    
    [_minHeap insertElement:@"b" withInteger:3];
    
    minValue = [_minHeap getMinimumValue];
    
    XCTAssertEqual(minValue, 3, @"Minimum should be 3");
    
    [_minHeap insertElement:@"c" withInteger:5];
    
    minValue = [_minHeap getMinimumValue];
    
    XCTAssertEqual(minValue, 3, @"Minimum should be 3");
    
    [_minHeap insertElement:@"d" withInteger:7];
    
    minValue = [_minHeap getMinimumValue];
    
    XCTAssertEqual(minValue, 3, @"Minimum should be 3");
    
    [_minHeap insertElement:@"e" withInteger:2];

    minValue = [_minHeap getMinimumValue];

    XCTAssertEqual(minValue, 2, @"Minimum should be 2");
    
    NSArray *elements = [_minHeap elementsSorted];
    
    KMFMinHeapElement *e0 = [elements objectAtIndex:0];
    KMFMinHeapElement *e1 = [elements objectAtIndex:1];
    KMFMinHeapElement *e2 = [elements objectAtIndex:2];
    KMFMinHeapElement *e3 = [elements objectAtIndex:3];
    KMFMinHeapElement *e4 = [elements objectAtIndex:4];
    
    XCTAssertEqual(e0.integerValue, 10, @"value should be 2");
    XCTAssertEqual(e1.integerValue, 7, @"value should be 3");
    XCTAssertEqual(e2.integerValue, 5, @"value should be 5");
    XCTAssertEqual(e3.integerValue, 3, @"value should be 10");
    XCTAssertEqual(e4.integerValue, 2, @"value should be 7");
    
    XCTAssertEqual([elements count], 5, @"size of heap should be 5");
}

- (void)testInsertWithMoreElementsThanCapacity
{
    [_minHeap insertElement:@"a" withInteger:8];
    [_minHeap insertElement:@"b" withInteger:3];
    [_minHeap insertElement:@"c" withInteger:2];
    [_minHeap insertElement:@"d" withInteger:5];
    [_minHeap insertElement:@"e" withInteger:6];
    [_minHeap insertElement:@"f" withInteger:1];
    [_minHeap insertElement:@"g" withInteger:7];
    [_minHeap insertElement:@"h" withInteger:9];
    [_minHeap insertElement:@"i" withInteger:10];
    [_minHeap insertElement:@"j" withInteger:15];
    
    NSArray *elements = [_minHeap elementsSorted];
    
    KMFMinHeapElement *e0 = [elements objectAtIndex:0];
    KMFMinHeapElement *e1 = [elements objectAtIndex:1];
    KMFMinHeapElement *e2 = [elements objectAtIndex:2];
    KMFMinHeapElement *e3 = [elements objectAtIndex:3];
    KMFMinHeapElement *e4 = [elements objectAtIndex:4];
    
    XCTAssertEqual(e0.element, @"j", @"value should be j");
    XCTAssertEqual(e1.element, @"i", @"value should be i");
    XCTAssertEqual(e2.element, @"h", @"value should be h");
    XCTAssertEqual(e3.element, @"a", @"value should be a");
    XCTAssertEqual(e4.element, @"g", @"value should be g");
    
    XCTAssertEqual(e0.integerValue, 15, @"value should be 15");
    XCTAssertEqual(e1.integerValue, 10, @"value should be 10");
    XCTAssertEqual(e2.integerValue, 9, @"value should be 9");
    XCTAssertEqual(e3.integerValue, 8, @"value should be 8");
    XCTAssertEqual(e4.integerValue, 7, @"value should be 7");
    
    XCTAssertEqual([elements count], 5, @"size of heap should be 5");
}

@end
