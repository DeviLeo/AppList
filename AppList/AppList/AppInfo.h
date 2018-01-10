//
//  AppInfo.h
//  DataContainer
//
//  Created by Liu Junqi on 12/27/17.
//  Copyright © 2017 DeviLeo. All rights reserved.
//

/*
 * localizedName: 腾讯新闻
 * shortVersionString: 5.5.20
 * vendorName: Tencent Technology (Beijing) Company Limited
 * applicationIdentifier: com.tencent.info
 * itemID: 399363156
 * itemName: 腾讯新闻-事实派的热点资讯娱乐短视频软件
 * teamID: 73CRRD7Y4Y
 * bundleURL: file:///private/var/containers/Bundle/Application/5511B8AB-E652-4853-82F4-82571ED34B74/QQNews.app
 * dataContainerURL: file:///private/var/mobile/Containers/Data/Application/5FA59CF1-DD65-4665-A30E-853629E5B805
 * applicationType: User
 */

#import <Foundation/Foundation.h>

#define ApplicationTypeUser     @"User"
#define ApplicationTypeSystem   @"System"

@interface AppInfo : NSObject

@property (nonatomic, strong) NSString *localizedName;
@property (nonatomic, strong) NSString *shortVersionString;
@property (nonatomic, strong) NSString *vendorName;
@property (nonatomic, strong) NSString *applicationIdentifier;
@property (nonatomic, strong) NSString *itemID;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *teamID;
@property (nonatomic, strong) NSString *bundleURL;
@property (nonatomic, strong) NSString *dataContainerURL;
@property (nonatomic, strong) NSString *applicationType;

- (instancetype)initWithLSApplicationProxy:(id)proxy;

@end
