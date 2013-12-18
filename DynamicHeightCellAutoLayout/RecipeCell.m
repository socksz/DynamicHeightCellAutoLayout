#import "RecipeCell.h"

#define kLabelHorizontalInsets 20.0f
#define kLabelVerticalInsets   10.0f

@interface RecipeCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UIView *labelsContainer;

@property (nonatomic, strong) UIView *iconView;

@end

@implementation RecipeCell

- (id)init
{
    self = [super init];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        
        _iconView = [UIView newAutoLayoutView];
        [_iconView setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:_iconView];
        
        _labelsContainer = [UIView newAutoLayoutView];
        [_labelsContainer setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.7 alpha:0.4]];
        [self.contentView addSubview:_labelsContainer];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return;
    
    // Applying fix from this thread: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
    self.contentView.bounds = CGRectMake(0, 0, 99999, 99999);
    
    [self.iconView autoSetDimensionsToSize:CGSizeMake(50.0f, 50.0f)];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kLabelHorizontalInsets];
    
    [self.labelsContainer autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconView withOffset:kLabelHorizontalInsets];
    [self.labelsContainer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kLabelHorizontalInsets];
    
    // These constraints are important, they say that the labelsContainer must be at least kLabelVerticalInsets
    // from the top and bottom of the contentView. The reason they are inequalities is so the cell can be larger
    // (and we'll have extra spacing on top & bottom), without breaking any constraints.
    
    [self.labelsContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets relation:NSLayoutRelationEqual];
    [self.labelsContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.labelsContainer autoSetDimension:ALDimensionHeight toSize:80 relation:NSLayoutRelationGreaterThanOrEqual];
    
    self.didSetupConstraints = YES;
}

- (void)addLabelsForIngredients:(NSArray *)ingredients
{
    for (Ingredient *ingredient in ingredients) {
        UILabel *label = [UILabel newAutoLayoutView];
        [label setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.2]];
        
        label.text = ingredient.name;
        
        [self.labelsContainer addSubview:label];
        
        // TODO: in order to support cell reuse pools, the view and constraint-adding code needs to be
        // refactored and separated from the code that sets the label text.
        // View and constraint adding is done once during the lifetime of a particular cell object,
        // but as the cell gets reused the text in the labels will need to be updated each time.
        if ([ingredients count] == 1) {
            // Just one label
            [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        } else if ([self.labels count] == 0) {
            // First label
            [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        } else if ([self.labels count] == [ingredients count] - 1) {
            // Last label
            UILabel *previousLabel = [self.labels lastObject];
            [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:previousLabel withOffset:10];
            [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
            [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        } else {
            // Middle label(s)
            UILabel *previousLabel = [self.labels lastObject];
            [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:previousLabel withOffset:10];
            [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        }
        
        [self.labels addObject:label];
    }
}

@end
