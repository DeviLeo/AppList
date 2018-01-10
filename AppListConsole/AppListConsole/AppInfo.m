//
//  AppInfo.m
//  DataContainer
//
//  Created by Liu Junqi on 12/27/17.
//  Copyright © 2017 DeviLeo. All rights reserved.
//

#import "AppInfo.h"
#import "LSApplicationProxy.h"

@implementation AppInfo

- (instancetype)initWithLSApplicationProxy:(LSApplicationProxy *)proxy {
    self = [super init];
    if (self) {
        [self parseInfo:proxy];
    }
    return self;
}

- (void)parseInfo:(LSApplicationProxy *)proxy {
    self.localizedName = proxy.localizedName;
    self.shortVersionString = proxy.shortVersionString;
    self.vendorName = proxy.vendorName;
    self.applicationIdentifier = proxy.applicationIdentifier;
    self.itemID = [proxy.itemID stringValue];
    self.itemName = proxy.itemName;
    self.teamID = proxy.teamID;
    self.bundleURL = [proxy.bundleURL absoluteString];
    self.dataContainerURL = [proxy.dataContainerURL absoluteString];
    self.applicationType = proxy.applicationType;
}

- (NSString *)shortDescription {
    NSString *s = [NSString stringWithFormat:@"%@(%@)\n",
                   _itemName ? : _localizedName,
                   _applicationIdentifier];
    return s;
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
