#import "RomanTranslator.h"



@implementation RomanTranslator {
    NSDictionary* _romanValues;
};

-(NSDictionary*)romanValues {
    if (_romanValues == nil) {
        _romanValues = @{@"I" : @(1),
                          @"IV" : @(4),
                          @"V" : @(5),
                          @"IX" : @(9),
                          @"X" : @(10),
                          @"XL" : @(40),
                          @"L" : @(50),
                          @"XC" : @(90),
                          @"C" : @(100),
                          @"CD" : @(400),
                          @"D" : @(500),
                          @"CM" : @(900),
                          @"M" : @(1000)
                          };
    }
    return _romanValues;
}

-(NSInteger)modifyRomanString:(NSMutableString*)romanString
                    origValue:(NSInteger)origValue
                    baseValue:(NSInteger)value
                   romanDigit:(NSString*)romanDigit
{
    NSInteger res = origValue;
    while (res >= value) {
        [romanString appendString:romanDigit];
        res -= value;
    }
    return res;
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSInteger value = arabicString.integerValue;
    
    NSMutableString* romanString = [NSMutableString new];
    value = [self modifyRomanString:romanString origValue:value baseValue:1000 romanDigit:@"M"];
    value = [self modifyRomanString:romanString origValue:value baseValue:900 romanDigit:@"CM"];
    value = [self modifyRomanString:romanString origValue:value baseValue:500 romanDigit:@"D"];
    value = [self modifyRomanString:romanString origValue:value baseValue:400 romanDigit:@"CD"];
    value = [self modifyRomanString:romanString origValue:value baseValue:100 romanDigit:@"C"];
    value = [self modifyRomanString:romanString origValue:value baseValue:90 romanDigit:@"XC"];
    value = [self modifyRomanString:romanString origValue:value baseValue:50 romanDigit:@"L"];
    value = [self modifyRomanString:romanString origValue:value baseValue:40 romanDigit:@"XL"];
    value = [self modifyRomanString:romanString origValue:value baseValue:10 romanDigit:@"X"];
    value = [self modifyRomanString:romanString origValue:value baseValue:9 romanDigit:@"IX"];
    value = [self modifyRomanString:romanString origValue:value baseValue:5 romanDigit:@"V"];
    value = [self modifyRomanString:romanString origValue:value baseValue:4 romanDigit:@"IV"];
    value = [self modifyRomanString:romanString origValue:value baseValue:1 romanDigit:@"I"];
    
    return [romanString autorelease];
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    long result = 0;
    for (int i = 0; i < romanString.length; ++i) {
        unichar curChar = [romanString characterAtIndex:i];
        unichar nextChar = i == romanString.length - 1 ? 0 : [romanString characterAtIndex:i + 1];
        NSNumber* value = nil;
        if (nextChar != 0) {
            value = [[self romanValues] objectForKey:[NSString stringWithFormat:@"%c%c", curChar, nextChar]];
            if (value != nil) i++;
        }
        if (value == nil) {
            value = [[self romanValues] objectForKey:[NSString stringWithFormat:@"%c", curChar]];
        }
        result += value.integerValue;
    }
    return [NSString stringWithFormat:@"%ld", result];

}

-(void)dealloc {
    [super dealloc];
    [_romanValues release];
}

@end
