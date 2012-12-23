
#import <UIKit/UIKit.h>

@interface QtViewController : UIViewController
@end

#ifdef __cplusplus
class QWindow;

@interface UIView (QtExtras)
- (void)addSubviewForWindow:(QWindow *)window;
@end
#endif