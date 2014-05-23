//
//  KMFCalculator.m
//  KMostFrequent
//

#import "KMFCalculator.h"
#import "KMFMinHeap.h"

@implementation KMFCalculator

-(NSArray *)calculateKMostFrequent:(NSString *)textInput numberOfElements:(NSUInteger)numElements
{
    KMFMinHeap *mh = [[KMFMinHeap alloc] initWithMaxSize:numElements heapOrderProperty:^NSComparisonResult(KMFMinHeapElement *o1, KMFMinHeapElement *o2) {
            if(o1.integerValue < o2.integerValue) {
                return NSOrderedAscending;
            }
            else if (o1.integerValue > o2.integerValue) {
                return NSOrderedDescending;
            }
            else {
                return NSOrderedSame;
            }
    }];
    
    NSMutableDictionary *frequencyTable = [[NSMutableDictionary alloc] init];
    
    // only allow letters and digits
    NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
    NSCharacterSet *charDelimeters = [allowedCharacters invertedSet];
    
    NSArray *words = [textInput componentsSeparatedByCharactersInSet:charDelimeters];
    
    // input the words into a dictionary so we can keep track of the counts
    for(NSString *word in words) {
        if([word length] > 0) { // make sure we don't include whitespace
            NSString *lowercaseWord = [word lowercaseString];
            if([frequencyTable objectForKey:lowercaseWord] == nil) {
                [frequencyTable setValue:[NSNumber numberWithInt:1] forKey:lowercaseWord];
            }
            else {
                NSInteger value = [[frequencyTable valueForKey:lowercaseWord] integerValue];
                [frequencyTable setValue:[NSNumber numberWithInt:value+1] forKey:lowercaseWord];
            }
        }
    }
    
    // now we iterate through the dictionary to input into our min heap
    NSEnumerator *enumerator = [frequencyTable keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSInteger count = [[frequencyTable valueForKey:key] integerValue];
        [mh insertElement:key withInteger:count];
    }
    
    NSArray *elements = [mh elementsSorted];
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:numElements];
    
    for (KMFMinHeapElement *e in elements) {
        [result addObject:e.element];
    }
    
    return result;
}

@end
