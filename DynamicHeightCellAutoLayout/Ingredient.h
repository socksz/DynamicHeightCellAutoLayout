#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property (nonatomic, strong) NSString *name;

+ (Ingredient *)ingredientWithName:(NSString *)name;

@end
