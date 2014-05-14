//
//  KMFMinHeap.m
//  KMostFrequent
//

#import "KMFMinHeap.h"

// Heap Element
@implementation KMFMinHeapElement

-(id)initWithString:(NSString *)element integerValue:(NSUInteger)value
{
    if(self = [super init]) {
        _element = element;
        _integerValue = value;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    KMFMinHeapElement *copyElement = [[KMFMinHeapElement allocWithZone:zone] initWithString:[NSString stringWithString:_element] integerValue:_integerValue];
    return copyElement;
}

@end

@interface KMFMinHeap()

// the actual heap - to access its children, we simply look at index 2n+1 and 2n+2.
@property (nonatomic, strong) NSMutableArray *heap;
@property (nonatomic) NSUInteger maxElements;
@property (nonatomic, strong) KMFHEAP_ORDER_PROPERTY heapOrderProperty;

@end

// macros for indexing into the heap
#define LEFT_INDEX(x) (2*x+1)
#define RIGHT_INDEX(x) (2*x+2)
#define HAS_LEFT_INDEX(x) (LEFT_INDEX(x) < _heap.count)
#define HAS_RIGHT_INDEX(x) (RIGHT_INDEX(x) < _heap.count)
// this is OK to do because we are using integers!
#define PARENT_INDEX(x) ((x-1)/2)

@implementation KMFMinHeap

-(id)initWithSize:(NSUInteger)size heapOrderProperty:(KMFHEAP_ORDER_PROPERTY)heapOrderProperty
{
    if(self = [super init]) {
        _heap = [[NSMutableArray alloc] initWithCapacity:size];
        _maxElements = size;
        _heapOrderProperty = heapOrderProperty;
    }
    return self;
}

-(NSArray *)elementsSorted
{
    // we need to create a copy here because we will be chanigng the original heap.
    NSMutableArray *heapCopy = [[NSMutableArray alloc] initWithArray:_heap copyItems:YES];
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:_maxElements];
    
    while([_heap count] > 0)
    {
        [result addObject:[self getMinimumElement]];
        [self removeMinimum];
    }
    
    _heap = heapCopy;
    
    // we need to reverse the array because we are moving min each time.
    NSArray* reversedResult = [[result reverseObjectEnumerator] allObjects];
    return [NSArray arrayWithArray:reversedResult];
}

-(void)insertElement:(NSString *)element withInteger:(NSInteger)integerValue
{
    if(_maxElements != 0) {
        KMFMinHeapElement *newElement = [[KMFMinHeapElement alloc] initWithString:element
                                                                 integerValue:integerValue];
        if(_maxElements == _heap.count) {
            // get the minimum element at the first element in the heap
            KMFMinHeapElement *minimum = [_heap objectAtIndex:0];
            if (_heapOrderProperty(minimum, newElement) == NSOrderedAscending) {
                [self removeMinimum];
                [self insertObjectIntoHeap:newElement];
            }
            else {
            // don't need to do anything here because its smaller than the minimum
            }
        }
        else {
            [self insertObjectIntoHeap:newElement];
        }
    }
}

-(void)insertObjectIntoHeap:(KMFMinHeapElement *)newElement;
{
    [_heap addObject:newElement];
    [self heapifyUp];
}

// by removing the minimum, we simply take the very last element and swap it to the top.
-(void)removeMinimum
{
    [self swapElementAtIndex:0 withIndex:(_heap.count-1)];
    [_heap removeLastObject];
    [self heapifyDown];
}

-(NSUInteger)getMinimumValue
{
    KMFMinHeapElement *minimumElement = [_heap objectAtIndex:0];
    return minimumElement.integerValue;
}

-(KMFMinHeapElement *)getMinimumElement
{
    KMFMinHeapElement *minimumElement = [_heap objectAtIndex:0];
    return minimumElement;
}

// takes the first element in the heap and heapifies it down.
-(void)heapifyDown
{
    NSUInteger currentIdx = 0;
    
    // if there isn't a left child, there is no way there could be a right child.
    while(HAS_LEFT_INDEX(currentIdx)) {
        KMFMinHeapElement *currentElement = [_heap objectAtIndex:currentIdx];
        KMFMinHeapElement *leftChild = [_heap objectAtIndex:LEFT_INDEX(currentIdx)];
        
        KMFMinHeapElement *smallerChildElement = leftChild;
        NSUInteger smallerChildIdx = LEFT_INDEX(currentIdx);
        
        if (HAS_RIGHT_INDEX(currentIdx)) {
            KMFMinHeapElement *rightChild = [_heap objectAtIndex:RIGHT_INDEX(currentIdx)];
            if(_heapOrderProperty(rightChild,smallerChildElement) == NSOrderedAscending) {
                smallerChildElement = rightChild;
                smallerChildIdx = RIGHT_INDEX(currentIdx);
            }
        }
        
        if (_heapOrderProperty(currentElement,smallerChildElement) == NSOrderedDescending) {
            [self swapElementAtIndex:smallerChildIdx withIndex:currentIdx];
            currentIdx = smallerChildIdx;
        }
        else {
            break; // we satisfied the heap ordering so we are done.
        }
    }
    
}

// takes the last element in the heap and heapifies it up.
-(void)heapifyUp
{
    NSUInteger idx = _heap.count - 1;
    while(idx != 0) {
        // we can do this conversion because we want to round down
        NSUInteger parentIdx = (NSUInteger)PARENT_INDEX(idx);
        KMFMinHeapElement *currentElement = [_heap objectAtIndex:idx];
        KMFMinHeapElement *parentElement = [_heap objectAtIndex:parentIdx];
        if(_heapOrderProperty(parentElement,currentElement) == NSOrderedDescending) {
            [self swapElementAtIndex:idx withIndex:parentIdx];
            idx = parentIdx;
        }
        else { // no need to continue
            break;
        }
    }
}

-(void)swapElementAtIndex:(NSUInteger)index1 withIndex:(NSUInteger)index2
{
    KMFMinHeapElement *element1 = [_heap objectAtIndex:index1];
    KMFMinHeapElement *element2 = [_heap objectAtIndex:index2];
    
    [_heap replaceObjectAtIndex:index1 withObject:element2];
    [_heap replaceObjectAtIndex:index2 withObject:element1];
}

@end
