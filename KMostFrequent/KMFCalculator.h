//
//  KMFCalculator.h
//  KMostFrequent
//

#import <Foundation/Foundation.h>

@interface KMFCalculator : NSObject

-(NSArray *)calculateKMostFrequent:(NSString *)textInput
                  numberOfElements:(NSUInteger)numElements;

@end
