#import "Ingredient.h"

@implementation Ingredient

+ (Ingredient *)ingredientWithName:(NSString *)name
{
    Ingredient *ingredient = [Ingredient new];
    ingredient.name = name;
    return ingredient;
}

@end
