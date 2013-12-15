#import "ViewController.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "RecipeCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *recipes;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _recipes = [NSMutableArray new];
        
        Recipe *cheeseCake = [[Recipe alloc] init];
        cheeseCake.name = @"Cheese Cake";
        
        [cheeseCake.ingredients addObject:[Ingredient ingredientWithName:@"Sugar"]];
        [cheeseCake.ingredients addObject:[Ingredient ingredientWithName:@"Butter"]];
        [cheeseCake.ingredients addObject:[Ingredient ingredientWithName:@"Egg"]];
        [cheeseCake.ingredients addObject:[Ingredient ingredientWithName:@"Milk"]];

        [self.recipes addObject:cheeseCake];
        
        
        Recipe *donut = [[Recipe alloc] init];
        cheeseCake.name = @"Donut";
        
        [donut.ingredients addObject:[Ingredient ingredientWithName:@"Chocolate"]];
        [donut.ingredients addObject:[Ingredient ingredientWithName:@"Egg"]];
        
        [self.recipes addObject:donut];
    }
    return self;
}

#pragma mark - Table view

- (void)configureCell:(RecipeCell *)recipeCell atIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = [self.recipes objectAtIndex:indexPath.row];
    
    for (Ingredient *ingredient in recipe.ingredients) {
        [recipeCell addLabelWithIngredient:ingredient];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell"];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height = MAX(height, 90);
    
    return height;
}

@end
