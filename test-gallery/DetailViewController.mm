
#import "DetailViewController.h"

#include <QtGui/QGuiApplication>
#include <QtGui/5.0.0/QtGui/qpa/qplatformnativeinterface.h>
#include "../test-cases/basic/basicwindow.h"

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
    int argc = 0;
    char *argv[] = {};
    new QGuiApplication(argc, argv);

    UIView *view = [[[UIView alloc] init] autorelease];
    view.backgroundColor = [self getRandomColor];
    self.view = view;

    BasicWindow* window = new BasicWindow;
    window->setGeometry(0, 0, 500, 500);
    window->show();

    QPlatformNativeInterface *native = QGuiApplication::platformNativeInterface();
    UIView *qtView = reinterpret_cast<UIView*>(native->nativeResourceForWindow("uiview", window));
    [self.view addSubview:qtView];
}

@end
