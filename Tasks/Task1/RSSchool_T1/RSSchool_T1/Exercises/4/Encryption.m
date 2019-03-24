#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    NSString* noSpacesString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger columns = ceil(sqrt(noSpacesString.length));
    NSString* gridRow = [NSString new];
    NSArray *grid = [NSArray new];
    NSString* result = [NSString new];
    
    for (int i = 0; i < noSpacesString.length; i++) {
        if (i != 0 && i % columns == 0) {
            grid = [grid arrayByAddingObject:gridRow];
            gridRow = @"";
        }
        gridRow = [gridRow stringByAppendingFormat:@"%c", [noSpacesString characterAtIndex:i]];
    }
    if (gridRow.length != 0) {
        grid = [grid arrayByAddingObject:gridRow];
    }
        
    for (int column = 0; column < columns; column++) {
        NSString* columnString = column == 0 ? @"" : @" ";
        
        for (int row = 0; row < grid.count; row++) {
            NSString* rowString = grid[row];
            if (column < rowString.length) {
                columnString = [columnString stringByAppendingFormat:@"%c", [rowString characterAtIndex:column]];
            }
        }
        result = [result stringByAppendingString:columnString];
    }
    return result;
}

@end
