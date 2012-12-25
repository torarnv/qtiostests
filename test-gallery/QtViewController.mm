
#import "QtViewController.h"

#include <QtWidgets/QApplication>
#include <QtGui/5.0.0/QtGui/qpa/qplatformnativeinterface.h>

@implementation QtViewController

- (id)init
{
    if ((self = [super init])) {
        if (!qApp) {
            int argc = 0;
            char *argv[] = {};
            new QApplication(argc, argv);
        }
    }

    return self;
}

- (void)loadView
{
    UIView *view = [[[UIView alloc] init] autorelease];
    view.backgroundColor = [UIColor greenColor];
    self.view = view;
}

@end

@implementation UIView (QtExtras)

- (void)addSubviewForWindow:(QWindow *)window
{
    QPlatformNativeInterface *native = QGuiApplication::platformNativeInterface();
    UIView *uiView = reinterpret_cast<UIView*>(native->nativeResourceForWindow("uiview", window));
    [self addSubview: uiView];
}

@end