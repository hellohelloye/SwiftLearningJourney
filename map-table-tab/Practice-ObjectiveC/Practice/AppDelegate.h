//
//  AppDelegate.h
//  Practice
//
//  Created by Yukui ye on 11/7/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeViewController.h"
#import "TestingViewBackgroundCircleViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (retain, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PracticeViewController *pvc;
@property (strong, nonatomic) TestingViewBackgroundCircleViewController *tvbcvc;

@end

