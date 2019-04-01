#import "TinyURL.h"

@implementation TinyURL {
    NSMutableDictionary<NSURL*, NSURL*>* urls;
}

-(instancetype)init {
    self = [super init];
    if (self != nil) {
        urls = [NSMutableDictionary new];
    }
    return self;
}

- (NSURL *)encode:(NSURL *)originalURL {
    NSString* encodedUrl = [NSString stringWithFormat:@"http://myhost.com/%lud", originalURL.hash];
    NSURL* result = [NSURL URLWithString:encodedUrl];
    urls[result] = originalURL;
    return result;
}

- (NSURL *)decode:(NSURL *)shortenedURL {
    return urls[shortenedURL];
}

@end
