//
//  AppInfo.m
//  DataContainer
//
//  Created by Liu Junqi on 12/27/17.
//  Copyright © 2017 DeviLeo. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

- (instancetype)initWithLSApplicationProxy:(id)proxy {
    self = [super init];
    if (self) {
        [self parseInfo:proxy];
    }
    return self;
}

- (void)parseInfo:(id)proxy {
    SEL sel_localizedName = NSSelectorFromString(@"localizedName");
    self.localizedName = [proxy performSelector:sel_localizedName];
    
    SEL sel_shortVersionString = NSSelectorFromString(@"shortVersionString");
    self.shortVersionString = [proxy performSelector:sel_shortVersionString];
    
    SEL sel_vendorName = NSSelectorFromString(@"vendorName");
    self.vendorName = [proxy performSelector:sel_vendorName];
    
    SEL sel_applicationIdentifier = NSSelectorFromString(@"applicationIdentifier");
    self.applicationIdentifier = [proxy performSelector:sel_applicationIdentifier];
    
    SEL sel_itemID = NSSelectorFromString(@"itemID");
    self.itemID = [proxy performSelector:sel_itemID];
    
    SEL sel_itemName = NSSelectorFromString(@"itemName");
    self.itemName = [proxy performSelector:sel_itemName];
    
    SEL sel_teamID = NSSelectorFromString(@"teamID");
    self.teamID = [proxy performSelector:sel_teamID];
    
    SEL sel_bundleURL = NSSelectorFromString(@"bundleURL");
    self.bundleURL = [proxy performSelector:sel_bundleURL];
    
    SEL sel_dataContainerURL = NSSelectorFromString(@"dataContainerURL");
    self.dataContainerURL = [proxy performSelector:sel_dataContainerURL];
    
    SEL sel_applicationType = NSSelectorFromString(@"applicationType");
    self.applicationType = [proxy performSelector:sel_applicationType];
}

- (NSString *)description {
    NSString *s = [NSString stringWithFormat:
                   @"localizedName: \n%@\n\n"
                   @"shortVersionString: \n%@\n\n"
                   @"vendorName: \n%@\n\n"
                   @"applicationIdentifier: \n%@\n\n"
                   @"itemID: \n%@\n\n"
                   @"itemName: \n%@\n\n"
                   @"teamID: \n%@\n\n"
                   @"bundleURL: \n%@\n\n"
                   @"dataContainerURL: \n%@\n\n"
                   @"applicationType: \n%@\n\n",
                   _localizedName,
                   _shortVersionString,
                   _vendorName,
                   _applicationIdentifier,
                   _itemID,
                   _itemName,
                   _teamID,
                   _bundleURL,
                   _dataContainerURL,
                   _applicationType];
    return s;
}

@end
