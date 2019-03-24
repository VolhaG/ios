#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    NSInteger summDiagonal1 = 0;
    NSInteger summDiagonal2 = 0;
    
    for (int i = 0; i < array.count; i++) {
        NSString* row = array[i];
        NSArray* rowArray = [row componentsSeparatedByString:@" "];
        
        for (int j = 0; j < rowArray.count; j++) {
            if (i == j) {
                summDiagonal1 = summDiagonal1 + (( NSString *)rowArray[j]).integerValue;
            }
            if (j == rowArray.count - (i + 1)) {
                summDiagonal2 = summDiagonal2 + (( NSString *)rowArray[j]).integerValue;
            }
        }
    }
    
    return @(labs(summDiagonal2 - summDiagonal1));
}

@end
