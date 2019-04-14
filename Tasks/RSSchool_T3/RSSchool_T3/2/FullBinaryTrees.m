#import "FullBinaryTrees.h"
// good luck
@interface Node : NSObject
@property (nonatomic,retain) Node* leftNode;
@property (nonatomic,retain) Node* rightNode;
@end
@implementation Node
@end

@interface FullBinaryTrees()
@property(nonatomic, retain) Node* rootNode;
@property(nonatomic, retain) NSString* result;
@property(nonatomic,retain) NSMutableArray* allNodesForTree;
@property NSInteger count;
@end


typedef void(^TreeCompletedCallback)(void);

@implementation FullBinaryTrees

-(void)saveTree{
    _allNodesForTree = [NSMutableArray new];
    [self visitNode:self.rootNode forLevel:0];
    
    if (self.result.length > 0) {
        self.result = [self.result stringByAppendingString:@",\n"];
    }
    self.result = [self.result stringByAppendingString:@"["];
    BOOL isFirst = YES;
    
    NSInteger counter = 0;
    
    for (int level = 0; level < self.allNodesForTree.count; ++level) {
        if (counter == self.count) break;
        NSArray* levelNodes = self.allNodesForTree[level];
        
        for (int nodeIndex = 0; nodeIndex < levelNodes.count; ++nodeIndex) {
            id node = levelNodes[nodeIndex];
            
            if (!isFirst) {
                self.result = [self.result stringByAppendingString:@","];
            }
            isFirst = NO;
            
            if ([node isKindOfClass:[NSNull class]]) {
                self.result = [self.result stringByAppendingString:@"null"];
            } else {
                self.result = [self.result stringByAppendingString:@"0"];
                if (++counter == self.count) break;
            }
        }
    }
    
    self.result = [self.result stringByAppendingString:@"]"];
}

-(void)visitNode:(Node *)node forLevel:(NSInteger)level{
    [self addNode:node forLevel:level];
    
    if (node.leftNode != nil) {
        [self visitNode:node.leftNode forLevel:level + 1];
    } else {
        [self addNode:nil forLevel:level + 1];
    }
    
    if (node.rightNode != nil) {
        [self visitNode:node.rightNode forLevel:level + 1];
    } else {
        [self addNode:nil forLevel:level + 1];
    }
}

-(void) addNode:(Node*)node forLevel:(NSInteger)level {
    NSMutableArray* levelNodes = nil;
    
    if (level >= self.allNodesForTree.count) {
        levelNodes = [NSMutableArray new];
        [self.allNodesForTree addObject:levelNodes];
    } else {
        levelNodes = self.allNodesForTree[level];
    }
    
    [levelNodes addObject:node != nil ? node : [NSNull null]];
}

-(void)buildTree:(NSInteger)count forNode:(Node*)node onTreeCompleted:(TreeCompletedCallback)onTreeCompleted {
    if (count == 0) {
        onTreeCompleted();
        return;
    }
    
    node.leftNode = [[Node alloc] init];
    node.rightNode = [[Node alloc] init];
   

    for (int countToLeft = 0; countToLeft < count; countToLeft += 2) {
        
        [self buildTree:countToLeft forNode:node.leftNode onTreeCompleted:^{
            [self buildTree:(count - 2 - countToLeft) forNode:node.rightNode onTreeCompleted:^{
                onTreeCompleted();
            }];
        }];
    }
    
    node.leftNode = nil;
    node.rightNode = nil;
}

-(NSString *)stringForNodeCount:(NSInteger)count {
    
    if ((count % 2) == 0) {
        return @"[]";
    }
    
    self.result = @"";
    self.count = count;
    
    _rootNode = [[Node alloc] init];
    
    [self buildTree:(count - 1) forNode:_rootNode onTreeCompleted:^{
        [self saveTree];
    }];

    return [NSString stringWithFormat:@"[%@]", self.result];
}

@end

