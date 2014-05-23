//
//  KMFMinHeap.h
//  KMostFrequent
//

#import <Foundation/Foundation.h>

@interface KMFMinHeapElement : NSObject<NSCopying>

// default initializer
-(id)initWithString:(NSString *)element integerValue:(NSUInteger)value;

@property (nonatomic, strong) NSString *element;
@property (nonatomic) NSUInteger integerValue;

@end

// heap order property
typedef NSComparisonResult (^KMFHEAP_ORDER_PROPERTY)(KMFMinHeapElement *o1, KMFMinHeapElement *o2);
    
@interface KMFMinHeap : NSObject

// default initializer
-(id)initWithMaxSize:(NSUInteger)size heapOrderProperty:(KMFHEAP_ORDER_PROPERTY)heapOrderProperty;

// an immutable array of the strings currently in the heap in sorted order (largest first)
-(NSArray *)elementsSorted;

-(void)insertElement:(NSString *)element withInteger:(NSInteger)integerValue;

-(NSUInteger)getMinimumValue;

@end

