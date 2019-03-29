#import "KidnapperNote.h"

@implementation KidnapperNote

-(NSDictionary*)getWords:(NSString*)text {
    NSArray* textComponents = [text.uppercaseString componentsSeparatedByString:@" "];
    NSMutableDictionary* words = [NSMutableDictionary new];
    for (NSString* word in textComponents) {
        NSNumber* wordCount = [words objectForKey:word];
        if (wordCount == nil) {
            words[word] = @(1);
        } else {
            words[word] = @(wordCount.integerValue + 1);
        }
    }
    return words;
}

- (BOOL)checkMagazine:(NSString *)magazine note:(NSString *)note {
    NSDictionary* magWords = [self getWords:magazine];
    NSDictionary* noteWords = [self getWords:note];
    
    for (NSString* word in noteWords.allKeys) {
        NSNumber* countInNote = noteWords[word];
        NSNumber* countInMagazine = [magWords objectForKey:word];
        if (countInMagazine == nil || countInMagazine.integerValue < countInNote.integerValue) {
            return NO;
        }
    }
    return YES;
}
@end
