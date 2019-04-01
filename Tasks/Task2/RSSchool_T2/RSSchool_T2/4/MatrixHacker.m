#import "MatrixHacker.h"
// your code here

typedef id<Character>(^InjectionBlock)(NSString*);

@implementation MatrixHacker {
    InjectionBlock injectedBlock;
}

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    injectedBlock = [theBlock retain];
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    NSMutableArray<id<Character>> * res = [NSMutableArray new];
    for (NSString* name in names) {
        id<Character> character = injectedBlock(name);
        [res addObject:character];
    }
    return [res autorelease];
}

-(void)dealloc {
    [super dealloc];
    [injectedBlock release];
}

@end
