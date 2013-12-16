#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface RecipeCell : UITableViewCell

- (void)addLabelWithIngredient:(Ingredient *)ingredient;

- (void)addLabelsForIngredients:(NSArray *)ingredients;

@end