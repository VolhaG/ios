#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted


- (ResultObject*)isSorted:(NSArray*)data {
    for (int i = 1; i < data.count; i++) {
        NSNumber* current = (NSNumber*)data[i];
        NSNumber* prev = (NSNumber*)data[i - 1];
        if (current.integerValue < prev.integerValue) {
            return nil;
        }
    }
    ResultObject* result = [ResultObject new];
    result.status = YES;
    return result;
}

- (void)swap:(NSInteger)pos1 with:(NSInteger)pos2 inArray:(NSMutableArray*)array {
    NSNumber* temp = array[pos1];
    array[pos1] = array[pos2];
    array[pos2] = temp;
}

- (ResultObject*)canSortBySwap:(NSArray*)testData {
    ResultObject* result = nil;
    NSMutableArray* data = [NSMutableArray arrayWithArray:testData];
    
    int conflict1 = -1;
    int conflict2 = -1;
    int conflicts = 0;
    
    NSNumber* first = (NSNumber*)data[0];
    NSNumber* second = (NSNumber*)data[1];
    if (first.integerValue > second.integerValue) {
        conflicts = 1;
        conflict1 = 0;
    }
    
    int i = 1;
    for (; i < data.count - 1; i++) {
        NSNumber* prev = (NSNumber*)data[i - 1];
        NSNumber* current = (NSNumber*)data[i];
        NSNumber* next = (NSNumber*)data[i + 1];
        
        if (current.integerValue < prev.integerValue) {
            int conflict = next.integerValue >= prev.integerValue ? i : i - 1;
            switch (++conflicts) {
                case 1:
                    conflict1 = conflict;
                    break;
                case 2:
                    conflict2 = conflict;
                    break;
                default:
                    return nil;
            }
        }
    }
    
    NSNumber* prev = (NSNumber*)data[i - 1];
    NSNumber* last = (NSNumber*)data[i];
    
    if (last.integerValue < prev.integerValue) {
        switch (++conflicts) {
            case 2:
                conflict2 = i;
                break;
            default:
                return nil;
        }
    }
        
    if (conflicts == 2) {
        [self swap:conflict1 with:conflict2 inArray:data];
        result = [self isSorted:data];
        if (result != nil) {
            result.detail = [NSString stringWithFormat:@"swap %d %d", conflict1 + 1, conflict2 + 1];
        }
    }
    return result;
}

- (void)reverseData:(NSMutableArray*)data from:(int)start to:(int)finish {
    for (int i = 0; i <= (finish - start) / 2; ++i) {
        [self swap:start + i with:finish - i inArray:data];
    }
}

- (ResultObject*)canSortByReverse:(NSArray*)testData {
    NSMutableArray* data = [NSMutableArray arrayWithArray:testData];
    
    for (int i = 1; i < data.count; ++i) {
        NSNumber* prev = (NSNumber*)data[i - 1];
        NSNumber* current = (NSNumber*)data[i];

        if (prev.integerValue > current.integerValue) {
            int start = i - 1;
            for (; i < data.count; ++i) {
                NSNumber* prev = (NSNumber*)data[i - 1];
                NSNumber* current = (NSNumber*)data[i];
                
                if (current.integerValue > prev.integerValue) {
                    int finish = i - 1;
                    [self reverseData:data from:start to:finish];
                    ResultObject* result = [self isSorted:data];
                    if (result != nil) {
                        result.detail = [NSString stringWithFormat:@"reverse %d %d", start + 1, finish + 1];
                    }
                    return result;
                }
            }
        }
    }
    
    return nil;
}


// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    
    NSArray* dataStrings = [string componentsSeparatedByString:@" "];
    NSMutableArray* data = [NSMutableArray new];
    for (NSString* s in dataStrings) {
        [data addObject:@(s.integerValue)];
    }
    
    ResultObject *value = [self isSorted:data];
    if (value == nil) {
        value = [self canSortBySwap:data];
    }
    if (value == nil) {
        value = [self canSortByReverse:data];
    }
    if (value == nil) {
        value = [ResultObject new];
        value.status = NO;
    }
    return value;
}

@end
