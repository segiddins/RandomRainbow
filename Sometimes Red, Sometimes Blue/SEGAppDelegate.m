//
//  SEGAppDelegate.m
//  Sometimes Red, Sometimes Blue
//
//  Created by Samuel E. Giddins on 1/31/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGAppDelegate.h"
#ifdef DEBUG
//#import <PDDebugger.h>
#endif
#import "SEGScoreManager.h"

@interface SEGAppDelegate ()

@property UIView *view;
@property NSInteger counter;
@property UILabel *counterLabel;
@property UIViewController *rvc;

@end

@implementation SEGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DEBUG
//    [[PDDebugger defaultInstance] autoConnect];
//    [[PDDebugger defaultInstance] enableNetworkTrafficDebugging];
//    [[PDDebugger defaultInstance] forwardAllNetworkTraffic];
//    [[PDDebugger defaultInstance] enableViewHierarchyDebugging];
//    [[PDDebugger defaultInstance] setDisplayedViewAttributeKeyPaths:@[@"frame", @"alpha", @"hidden", @"backgroundColor"]];
#endif
    [Crashlytics startWithAPIKey:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.counter = [defaults integerForKey:@"Gallagher Counter"];

    [[SEGScoreManager sharedScoreManager] authenticateLocalPlayer];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}



@end
