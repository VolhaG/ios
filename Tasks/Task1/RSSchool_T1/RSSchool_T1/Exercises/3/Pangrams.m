#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSArray * alphabet = [@"Q W E R T Y U I O P A S D F G H J K L Z X C V B N M" componentsSeparatedByString:@" "];
    NSString* upperStr = string.uppercaseString;
    
    for (int i = 0; i < alphabet.count; i++) {
        if (![upperStr containsString:alphabet[i]])
            return NO;
    }
    return YES;
}

@end
