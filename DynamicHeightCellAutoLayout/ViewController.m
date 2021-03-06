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
        
        
        Recipe *cottonCandy = [[Recipe alloc] init];
        cottonCandy.name = @"Cotton Candy";
        
        [cottonCandy.ingredients addObject:[Ingredient ingredientWithName:@"Sugar"]];
        
        [self.recipes addObject:cottonCandy];
        
        Recipe *pumpkinPie = [[Recipe alloc] init];
        pumpkinPie.name = @"Pumpkin Pie";
        
        [pumpkinPie.ingredients addObject:[Ingredient ingredientWithName:@"Pumpkin"]];
        [pumpkinPie.ingredients addObject:[Ingredient ingredientWithName:@"Flour"]];
        [pumpkinPie.ingredients addObject:[Ingredient ingredientWithName:@"Butter"]];
        
        [self.recipes addObject:pumpkinPie];
    }
    return self;
}

#pragma mark - Table view

- (void)configureCell:(RecipeCell *)recipeCell atIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = [self.recipes objectAtIndex:indexPath.row];
    
    [recipeCell addLabelsForIngredients:recipe.ingredients];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Commenting out cell reuse, because you'll need to do some more work here to make sure that
    // different combinations of views (e.g. # of labels) and constraints each get their own reuse
    // identifier. As currently written, things will blow up because there is 1 reuse pool for all
    // cells, and each cell has a different number of labels and different set of constraints.
//    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    RecipeCell *cell = [[RecipeCell alloc] init];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // See above comment in tableView:cellForRowAtIndexPath: about cell reuse.
//    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell"];
    RecipeCell *cell = [[RecipeCell alloc] init];
    
    [self configureCell:cell atIndexPath:indexPath];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}

@end
