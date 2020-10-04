//
//  AppDelegate.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Liad Elidan on 14/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

#import "AppDelegate.h"
#import <TaboolaSDK/TaboolaSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TBLPublisherInfo *publisherInfo = [[TBLPublisherInfo alloc]initWithPublisherName:@"sdk-tester-demo"];

    
    publisherInfo.apiKey = @"30dfcf6b094361ccc367bbbef5973bdaa24dbcd6";
    
    [Taboola initWithPublisherInfo:publisherInfo];
    
    return YES;
}

@end
