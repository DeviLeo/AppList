//
//  ViewController.m
//  DataContainer
//
//  Created by Liu Junqi on 10/26/17.
//  Copyright © 2017 DeviLeo. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppInfoViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    AppInfo *_appInfoForSegue;
}

@property (nonatomic, weak) IBOutlet UITableView *tvTableView;

@property (nonatomic, strong) NSArray<AppInfo *> *userApps;
@property (nonatomic, strong) NSArray<AppInfo *> *systemApps;
@property (nonatomic, strong) NSArray<AppInfo *> *otherApps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self displayAllInstalledApps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)listAllInstalledApps {
    Class c = NSClassFromString(@"LSApplicationWorkspace");
    SEL sel = NSSelectorFromString(@"defaultWorkspace");
    NSObject *workspace = [c performSelector:sel];
    SEL selAll = NSSelectorFromString(@"allInstalledApplications");
    NSArray *allInstalledApps = [workspace performSelector:selAll]; // NSArray<LSApplicationProxy *> *
    return allInstalledApps;
}

- (void)displayAllInstalledApps {
    NSArray *apps = [self listAllInstalledApps];
    NSMutableArray *userApps = [NSMutableArray arrayWithCapacity:apps.count];
    NSMutableArray *systemApps = [NSMutableArray arrayWithCapacity:apps.count];
    NSMutableArray *otherApps = [NSMutableArray array];
    for (id proxy in apps) {
        AppInfo *info = [[AppInfo alloc] initWithLSApplicationProxy:proxy];
        if ([info.applicationType isEqualToString:ApplicationTypeUser]) {
            [userApps addObject:info];
        } else if ([info.applicationType isEqualToString:ApplicationTypeSystem]) {
            [systemApps addObject:info];
        } else {
            [otherApps addObject:info];
        }
    }
    
    NSComparator cmptr = ^NSComparisonResult(AppInfo * _Nonnull obj1, AppInfo * _Nonnull obj2) {
        NSString *name1 = obj1.itemName ? : obj1.localizedName;
        NSString *name2 = obj2.itemName ? : obj2.localizedName;
        NSComparisonResult result = [name1 compare:name2];
        return result;
    };
    
    [userApps sortUsingComparator:cmptr];
    [systemApps sortUsingComparator:cmptr];
    [otherApps sortUsingComparator:cmptr];
    
    self.userApps = userApps;
    self.systemApps = systemApps;
    self.otherApps = otherApps;
    [self.tvTableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_otherApps.count == 0) return 2;
    else return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"User";
    else if (section == 1) return @"System";
    else return @"Other";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return _userApps.count;
    else if (section == 1) return _systemApps.count;
    else if (section == 2) return _otherApps.count;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSArray *apps = nil;
    if (section == 0) apps = _userApps;
    else if (section == 1) apps = _systemApps;
    else if (section == 2) apps = _otherApps;
    AppInfo *info = apps[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    
    NSString *name = info.itemName ? : info.localizedName;
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@", name, info.shortVersionString];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSArray *apps = nil;
    if (section == 0) apps = _userApps;
    else if (section == 1) apps = _systemApps;
    else if (section == 2) apps = _otherApps;
    AppInfo *info = apps[indexPath.row];
    _appInfoForSegue = info;
    
    [self performSegueWithIdentifier:@"A2D" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AppInfoViewController *vc = segue.destinationViewController;
    vc.appInfo = _appInfoForSegue;
}

@end
