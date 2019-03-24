#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    
    NSInteger summArray = 0;
    for (int i = 0; i < array.count; i++) {
        summArray = summArray + (( NSNumber *)array[i]).integerValue;
    }
    return @(summArray);
}

@end
