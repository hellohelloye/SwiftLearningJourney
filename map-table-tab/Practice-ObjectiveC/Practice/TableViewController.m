//
//  TableViewController.m
//  Practice
//
//  Created by Yukui ye on 11/10/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import "TableViewController.h"
#import "TestingViewBackgroundCircleViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) UIButton *goBackBtn;
//@property (strong, nonatomic) UIButton *btnNext;
//@property (strong, nonatomic) TestingViewBackgroundCircleViewController *tvbcVC;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 0.8;
   // self.tvbcVC = [[TestingViewBackgroundCircleViewController alloc] init];
   // [self animatedViewBackgroundCircle];
    
    self.goBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 16, 44, 44)];
    self.goBackBtn.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:250./225 alpha:0.4];
    [self.goBackBtn addTarget:self action:@selector(backToMapView) forControlEvents:UIControlEventTouchUpInside];
    self.goBackBtn.clipsToBounds = YES;
    self.goBackBtn.layer.cornerRadius = self.goBackBtn.frame.size.width/2;
    [self.view addSubview:self.goBackBtn];
    
//    self.btnNext = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 20, 16, 44, 44)];
//    self.btnNext.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:250./225 alpha:0.4];
//    [self.btnNext addTarget:self action:@selector(testBackgroundViewCircle) forControlEvents:UIControlEventTouchUpInside];
//    self.btnNext.clipsToBounds = YES;
//    self.btnNext.layer.cornerRadius = self.btnNext.frame.size.width/2;
//    [self.view addSubview:self.btnNext];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 40, self.view.bounds.origin.y + 120, self.view.frame.size.width - 80, self.view.frame.size.height - 260)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:0.8];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.clipsToBounds = YES;
    self.tableView.layer.cornerRadius = self.tableView.frame.size.width/2;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
}


// Bodoni Ornaments || AppleColorEmoji
#pragma - mark UITableViewDataSource Method

//light blue (173,216,230)  sky blue (135,206,235)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:173./225 green:216./225 blue:230./225 alpha:0.8];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:145./225 green:206./225 blue:250./225 alpha:0.4];
    }
    cell.textLabel.text = @"hellohelloWorld  HIHIHI";
    cell.textLabel.font = [UIFont fontWithName:@"AppleColorEmoji" size:16];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.306 green:0.306 blue:0.275 alpha:1];
    return cell;
}

#pragma - mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


#pragma - mark go back to mapView

- (void)backToMapView {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

//- (void)testBackgroundViewCircle {
//    [self addChildViewController:self.tvbcVC];
//    [self.view addSubview:self.tvbcVC.view];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
