//
//  AppDelegate.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 02.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "RightBasketViewController.h"
#import "IIViewDeckController.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (void)customizeAppearance
{
    UIImage *gradientImage44 = [[UIImage imageNamed:@"navigationBar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [
  
    [NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(reachabilityChanged:)
                                         name:kReachabilityChangedNotification
                                         object:nil];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    _hostReach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [_hostReach startNotifier];
    
    [self updateInterfaceWithReachability: _hostReach];
    
    HomeViewController * homeController = [[HomeViewController alloc] init];
    LeftMenuViewController *leftMenuController = [[LeftMenuViewController alloc]init];
    RightBasketViewController * basket=[[RightBasketViewController alloc] init];
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeController];

    IIViewDeckController *deckController = [[IIViewDeckController alloc] initWithCenterViewController:homeNavigationController leftViewController:leftMenuController rightViewController:basket];
  
    self.leftController = deckController.leftController;
    self.centerController = deckController.centerController;
    
    self.window.rootViewController = deckController;
    
    [self customizeAppearance];
    [self.window makeKeyAndVisible];
    
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
- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    self.netStatus = [curReach currentReachabilityStatus];
}

- (void) reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

@end
