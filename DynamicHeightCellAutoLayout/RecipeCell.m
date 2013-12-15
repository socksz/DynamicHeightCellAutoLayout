#import "RecipeCell.h"

#define kLabelHorizontalInsets 20.0f

@interface RecipeCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UIView *labelsContainer;

@property (nonatomic, strong) IBOutlet UIView *iconView;

@end

@implementation RecipeCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        _labelsContainer = [[UIView alloc] initWithFrame:CGRectZero];
        [_labelsContainer setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.7 alpha:0.4]];
        [_labelsContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:_labelsContainer];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return;
    
    [self.labelsContainer autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconView withOffset:kLabelHorizontalInsets];
    [self.labelsContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.iconView withOffset:0];
    [self.labelsContainer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kLabelHorizontalInsets];
    
    self.didSetupConstraints = YES;
}

- (void)addLabelWithIngredient:(Ingredient *)ingredient
{
    NSInteger exerciseCount = [self.labels count];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setMinimumScaleFactor:0.8];
    [label setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.2]];
    label.text = ingredient.name;
    
    [self.labelsContainer addSubview:label];
    
    if (exerciseCount == 0) {
        [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    } else {
        UILabel *lastLabel = [self.labels lastObject];
        
        [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastLabel withOffset:10];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    }
    
    [self.labels addObject:label];
}

@end
