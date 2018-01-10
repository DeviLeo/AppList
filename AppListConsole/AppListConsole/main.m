//
//  main.m
//  AppListConsole
//
//  Created by Liu Junqi on 1/10/18.
//  Copyright © 2018 DeviLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"
#import "LSApplicationWorkspace.h"
#import "LSApplicationProxy.h"

NSArray * listAllInstalledApps() {
    LSApplicationWorkspace *workspace = [LSApplicationWorkspace defaultWorkspace];
    NSArray *allInstalledApps = [workspace allInstalledApplications]; // NSArray<LSApplicationProxy *> *
    return allInstalledApps;
}

NSString *descriptionOfAppInfo(AppInfo *appInfo, BOOL verbose, NSInteger index) {
    NSString *infoString = nil;
    if (verbose) infoString = [NSString stringWithFormat:@"---> %zd\n%@", index, [appInfo description]];
    else infoString = [NSString stringWithFormat:@"%zd. %@", index, [appInfo shortDescription]];
    return infoString;
}

NSString *descriptionOfAppsInfo(NSArray<AppInfo *> *appsInfo, BOOL verbose) {
    NSMutableString *ms = [NSMutableString stringWithCapacity:2048];
    NSInteger i = 1;
    for (AppInfo *info in appsInfo) {
        [ms appendString:descriptionOfAppInfo(info, verbose, i++)];
    }
    return ms;
}

void displayAllInstalledApps(BOOL verbose, BOOL showUserApps, BOOL showSystemApps, BOOL showOtherApps) {
    NSArray *apps = listAllInstalledApps();
    NSMutableArray *userApps = showUserApps ? [NSMutableArray arrayWithCapacity:apps.count] : nil;
    NSMutableArray *systemApps = showSystemApps ? [NSMutableArray arrayWithCapacity:apps.count] : nil;
    NSMutableArray *otherApps = showOtherApps ? [NSMutableArray array] : nil;
    for (LSApplicationProxy *proxy in apps) {
        AppInfo *info = [[AppInfo alloc] initWithLSApplicationProxy:proxy];
        if ([info.applicationType isEqualToString:ApplicationTypeUser]) {
            if (showUserApps) [userApps addObject:info];
        } else if ([info.applicationType isEqualToString:ApplicationTypeSystem]) {
            if (showSystemApps) [systemApps addObject:info];
        } else {
            if (showOtherApps) [otherApps addObject:info];
        }
    }
    
    NSComparator cmptr = ^NSComparisonResult(AppInfo * _Nonnull obj1, AppInfo * _Nonnull obj2) {
        NSString *name1 = obj1.itemName ? : obj1.localizedName;
        NSString *name2 = obj2.itemName ? : obj2.localizedName;
        NSComparisonResult result = [name1 compare:name2];
        return result;
    };
    
    if (showUserApps) [userApps sortUsingComparator:cmptr];
    if (showSystemApps) [systemApps sortUsingComparator:cmptr];
    if (showOtherApps) [otherApps sortUsingComparator:cmptr];
    
    NSMutableString *printString = [NSMutableString stringWithCapacity:8192];
    if (showUserApps) {
        [printString appendString:@"=====> User\n"];
        if (userApps.count > 0) {
            [printString appendString:descriptionOfAppsInfo(userApps, verbose)];
        } else {
            [printString appendString:@"No user apps\n"];
        }
    }
    if (showSystemApps) {
        [printString appendString:@"=====> System\n"];
        if (systemApps.count > 0) {
            [printString appendString:descriptionOfAppsInfo(systemApps, verbose)];
        } else {
            [printString appendString:@"No system apps\n"];
        }
    }
    if (showOtherApps) {
        [printString appendString:@"=====> Other\n"];
        if (otherApps.count > 0) {
            [printString appendString:descriptionOfAppsInfo(otherApps, verbose)];
        } else {
            [printString appendString:@"No other apps\n"];
        }
    }
    printf("%s", [printString UTF8String]);
}

void displaySpecifiedApp(char *strBundleID) {
    if (strBundleID == NULL) return;
    NSString *bundleID = [NSString stringWithUTF8String:strBundleID];
    if (bundleID.length == 0) return;
    
    NSArray *apps = listAllInstalledApps();
    for (LSApplicationProxy * proxy in apps) {
        AppInfo *info = [[AppInfo alloc] initWithLSApplicationProxy:proxy];
        if ([info.applicationIdentifier isEqualToString:bundleID]) {
            printf("%s", [[info description] UTF8String]);
            return;
        }
    }
    
    printf("Not found!\n");
}

void displayHelp() {
    printf("applst -vausoh\n"
           "applst <Bundle ID>\n\n"
           "-v List apps with details\n"
           "-a List all apps\n"
           "-u List user apps\n"
           "-s List system apps\n"
           "-o List other apps\n"
           "-h Show help\n");
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        BOOL verbose = NO;
        BOOL showUserApps = YES;
        BOOL showSystemApps = NO;
        BOOL showOtherApps = NO;
        if (argc == 1) displayAllInstalledApps(verbose, showUserApps, showSystemApps, showOtherApps);
        else if (argc > 1) {
            char *arg = argv[1];
            if (arg[0] == '-') {
                BOOL showAll = NO, showHelp = NO;
                showUserApps = showSystemApps = showOtherApps = NO;
                int count = (int)strlen(arg);
                for (int i = 1; i < count; ++i) {
                    char p = arg[i];
                    switch (p) {
                        case 'a':
                            showAll = showUserApps = showSystemApps = showOtherApps = YES;
                            break;
                        case 'v':
                            verbose = YES;
                            break;
                        case 'u':
                            if (!showAll) showUserApps = YES; break;
                        case 's':
                            if (!showAll) showSystemApps = YES; break;
                        case 'o':
                            if (!showAll) showOtherApps = YES; break;
                        case 'h':
                            showHelp = YES; break;
                        default:
                            break;
                    }
                }
                // Use default
                if (showHelp == YES || (showUserApps == NO && showSystemApps == NO && showOtherApps == NO)) {
                    displayHelp();
                } else {
                    displayAllInstalledApps(verbose, showUserApps, showSystemApps, showOtherApps);
                }
            } else {
                displaySpecifiedApp(arg);
            }
        }
        return 0;
    }
}
