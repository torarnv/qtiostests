#import "AppDelegate.h"
#import "MasterViewController.h"
#import "QtViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_splitViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil] autorelease];
    [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];

    self.splitViewController = [[[UISplitViewController alloc] init] autorelease];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [masterViewController.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    [masterViewController tableView:[masterViewController tableView] didSelectRowAtIndexPath:indexPath];

    self.window.rootViewController = self.splitViewController;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
