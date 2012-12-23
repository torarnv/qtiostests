
#import "AppDelegate.h"
#import "MasterViewController.h"

#import "QtViewController.h"

#pragma mark BasicViewController

#include "../test-cases/basic/basicwindow.h"

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
    window->setGeometry(0, 0, 500, 500);
    window->show();

    [self.view addSubviewForWindow: window];
}

- (void)dealloc
{
    delete window;
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
    [_objects insertObject:object atIndex:0];
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
