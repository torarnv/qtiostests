
#import "DetailViewController.h"

@implementation DetailViewController

- (void)dealloc
{
    [super dealloc];
}

- (UIColor *)getRandomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)loadView
{
    UIView *view = [[[UIView alloc] init] autorelease];
    view.backgroundColor = [self getRandomColor];
    self.view = view;
}

@end
