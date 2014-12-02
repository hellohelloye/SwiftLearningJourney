//
//  AppDelegate.m
//  Practice
//
//  Created by Yukui ye on 11/7/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBarController = [[UITabBarController alloc] init];
    self.pvc = [[PracticeViewController alloc] init];
    self.tvbcvc = [[TestingViewBackgroundCircleViewController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.pvc, self.tvbcvc, nil];
    [self.tabBarController setSelectedIndex:1];
    
    for (UIViewController *vc in self.tabBarController.viewControllers) {
        if ([self.tabBarController.viewControllers indexOfObject:vc] == 0) {
            //vc.tabBarItem.image = [UIImage imageNamed:@"tab-search-select"];
            [vc.tabBarItem setTitle:@"Map"];
        } else if ([self.tabBarController.viewControllers indexOfObject:vc] == 1) {
            //vc.tabBarItem.image = [UIImage imageNamed:@"tab-picks"];
            [vc.tabBarItem setTitle:@"Sunshine"];
        }
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                     forState:UIControlStateSelected];
        
    }

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
