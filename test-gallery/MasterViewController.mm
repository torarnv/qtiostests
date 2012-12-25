
#import "AppDelegate.h"
#import "MasterViewController.h"

#import "QtViewController.h"

#pragma mark BasicViewController

#include <basicwindow.h>

@interface BasicViewController : QtViewController
{
    QWindow *window;
}
@end

@implementation BasicViewController

- (void)loadView
{
    [super loadView];

    window = new BasicWindow;
    window->create();
    [self.view addSubviewForWindow: window];

    window->show();
}

- (void)dealloc
{
    delete window;
    [super dealloc];
}

@end

#pragma mark -
#pragma mark Wiggly

#include <dialog.h>

@interface WigglyViewController : QtViewController
{
    QWidget *widget;
}
@end

@implementation WigglyViewController

- (void)loadView
{
    [super loadView];

    widget = new Dialog;
    widget->winId();
    [self.view addSubviewForWindow: widget->windowHandle()];

    widget->show();
}

- (void)dealloc
{
    delete widget;
    [super dealloc];
}

@end


#pragma mark -
#pragma mark MasterViewController

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Tests", @"Tests");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }

    [self addTest: @{ @"description": @"Basic", @"controller": [BasicViewController class] }];
    [self addTest: @{ @"description": @"Wiggly", @"controller": [WigglyViewController class] }];

    return self;
}

- (void)dealloc
{
    [_currentViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addTest:(NSObject*)object
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects addObject:object];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    NSDictionary *object = _objects[indexPath.row];
    cell.textLabel.text = [object objectForKey: @"description"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = _objects[indexPath.row];

    Class dictionaryClass = [object valueForKey:@"controller"];
    self.currentViewController = [[[dictionaryClass alloc] init] autorelease];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.splitViewController.viewControllers = @[self.navigationController, self.currentViewController];
}

@end
