//
//  TableViewController.h
//  Practice
//
//  Created by Yukui ye on 11/10/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end
