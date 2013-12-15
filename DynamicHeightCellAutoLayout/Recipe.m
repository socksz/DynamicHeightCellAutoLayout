#import "Recipe.h"

@implementation Recipe

- (id)init
{
    self = [super init];
    if (self) {
        _ingredients = [NSMutableArray new];
    }
    return self;
}

@end
