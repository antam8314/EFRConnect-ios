//
//  SILAppDelegate.m
//  SiliconLabsApp
//
//  Created by Colden Prime on 1/12/15.
//  Copyright (c) 2015 SiliconLabs. All rights reserved.
//

#import "SILAppDelegate.h"
#import "SILAppearance.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface SILAppDelegate ()

@end

@implementation SILAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(1);
    [SILAppearance setupAppearance];
    [Fabric with:@[CrashlyticsKit]];
    [SILRealmConfiguration updateRealmConfigurationIfNeeded];
    SILBrowserConnectionsViewModel.sharedInstance.centralManager = [[SILCentralManager alloc] initWithServiceUUIDs:@[]];
    return YES;
}

@end
