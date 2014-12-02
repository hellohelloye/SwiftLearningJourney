//
//  TestingViewBackgroundCircleViewController.m
//  Practice
//
//  Created by Yukui ye on 11/14/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import "TestingViewBackgroundCircleViewController.h"
#import "DetailTableViewCell.h"
#import "MainTableViewCell.h"

@interface TestingViewBackgroundCircleViewController ()
@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@property (strong, nonatomic) UIButton *btn4;
@property (strong, nonatomic) UIButton *btn5;
@property (strong, nonatomic) UIButton *btn6;
@property (strong, nonatomic) UITableView *tableView;
@property (readwrite, assign) BOOL collapse;
@property (readwrite, assign) int rowNub;
@property (nonatomic, assign) long selectedRow;
@end

@implementation TestingViewBackgroundCircleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowNub = 6;
    self.collapse = NO;
    
    [self animatedViewBackgroundCircle];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MainTableViewCell class])];
    [self.tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DetailTableViewCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview).with.offset(62);
        make.left.equalTo(self.tableView.superview);
        make.right.equalTo(self.tableView.superview);
        make.bottom.equalTo(self.tableView.superview).with.offset(32);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.rowNub;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.collapse) {
            DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailTableViewCell class]) forIndexPath:indexPath];
            cell.textLabel.text = @"hihi";
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        } else {
            MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainTableViewCell class]) forIndexPath:indexPath];
            cell.textLabel.text = @"hellohello";
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == self.selectedRow) {
            return 20;
        } else {
            return 40;
        }
    } else {
        return 44;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.collapse) {
            self.collapse = NO;
            self.selectedRow = NULL;
            long index = indexPath.row + 1;
            NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:indexPath.section];;
            NSMutableArray *deletedIndexPaths = [NSMutableArray arrayWithObject: ip];
            self.rowNub -= 1;
            
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:deletedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            
            if (self.rowNub <= [[deletedIndexPaths lastObject] row]) {
                [self.tableView reloadData];
            } else {
                [self.tableView scrollToRowAtIndexPath:[deletedIndexPaths lastObject] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            }
        } else {
            long index = indexPath.row + 1;
            NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:indexPath.section];;
            NSMutableArray *indexPaths = [NSMutableArray arrayWithObject: ip];
            self.rowNub += 1;
            self.collapse = YES;
            self.selectedRow = indexPath.row +1;
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            [self.tableView scrollToRowAtIndexPath:[indexPaths lastObject] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    } else {
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.collapse = NO;
}

#pragma - mark backgroundCircle

- (void)animatedViewBackgroundCircle {
    self.btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/8 - 5, self.view.frame.size.height/4 - 25, 44, 44)];
    self.btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/8 - 10, self.view.frame.size.height/4 - 10 , self.view.frame.size.width/4 + 44, self.view.frame.size.width/4 + 44)];
    self.btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.btn2.frame.size.width - 20, self.view.frame.size.height/6 + self.btn2.frame.size.height + 10, 44, 44)];
    self.btn4 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/8 + (self.btn2.frame.size.width/3)*2+10 , self.view.frame.size.height/3 + self.view.frame.size.height/6, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    self.btn5 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - self.view.frame.size.width/4 - 44, self.view.frame.size.height - self.view.frame.size.height/4 - 44, self.view.frame.size.width/4 + 20, self.view.frame.size.width/4 + 20)];
    self.btn6 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - self.btn5.frame.size.width + 20, self.view.frame.size.height - self.btn5.frame.size.height - 40, self.view.frame.size.width/4, self.view.frame.size.width/4)];

    self.btn1.clipsToBounds = YES;
    self.btn1.layer.cornerRadius = self.btn1.frame.size.width/2;
    self.btn2.clipsToBounds = YES;
    self.btn2.layer.cornerRadius = self.btn2.frame.size.width/2;
    self.btn3.clipsToBounds = YES;
    self.btn3.layer.cornerRadius = self.btn3.frame.size.width/2;
    self.btn4.clipsToBounds = YES;
    self.btn4.layer.cornerRadius = self.btn4.frame.size.width/2;
    self.btn5.clipsToBounds = YES;
    self.btn5.layer.cornerRadius = self.btn5.frame.size.width/2;
    self.btn6.clipsToBounds = YES;
    self.btn6.layer.cornerRadius = self.btn6.frame.size.width/2;

    self.btn1.backgroundColor = [UIColor redColor];
    self.btn2.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:0.6];
    self.btn3.backgroundColor = [UIColor colorWithRed:238./225 green:130./225 blue:238./225 alpha:0.6];
    self.btn4.backgroundColor = [UIColor colorWithRed:64./225 green:224./225 blue:208./225 alpha:0.6];
    self.btn5.backgroundColor = [UIColor colorWithRed:0./225 green:255./225 blue:255./225 alpha:0.6];
    self.btn6.backgroundColor = [UIColor colorWithRed:255./225 green:235./225 blue:205./225 alpha:0.6];

    self.btn1.alpha = 0.2;
    self.btn2.alpha = 0.2;
    self.btn3.alpha = 0.2;
    self.btn4.alpha = 0.2;
    self.btn5.alpha = 0.2;
    self.btn6.alpha = 0.2;

    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
    [self.view addSubview:self.btn6];

//    [UIView animateWithDuration:4.0 animations:^{
//        self.btn1.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:1];
//        self.btn2.backgroundColor = [UIColor clearColor];
//        self.btn3.backgroundColor = [UIColor clearColor];
//        self.btn4.backgroundColor = [UIColor clearColor];
//        self.btn5.backgroundColor = [UIColor clearColor];
//        self.btn6.backgroundColor = [UIColor clearColor];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:6.0 animations:^{
//            self.btn1.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:1];
//            self.btn2.backgroundColor = [UIColor colorWithRed:255./225 green:192./225 blue:203./225 alpha:1];
//            self.btn3.backgroundColor = [UIColor clearColor];
//            self.btn4.backgroundColor = [UIColor clearColor];
//            self.btn5.backgroundColor = [UIColor clearColor];
//            self.btn6.backgroundColor = [UIColor clearColor];
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:2.0 animations:^{
//                self.btn1.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:1];
//                self.btn2.backgroundColor = [UIColor colorWithRed:255./225 green:192./225 blue:203./225 alpha:1];
//                self.btn3.backgroundColor = [UIColor colorWithRed:238./225 green:130./225 blue:238./225 alpha:1];
//                self.btn4.backgroundColor = [UIColor colorWithRed:240./225 green:255./225 blue:240./225 alpha:1];
//                self.btn5.backgroundColor = [UIColor clearColor];
//                self.btn6.backgroundColor = [UIColor clearColor];
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:2.0 animations:^{
//                    self.btn1.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:1];
//                    self.btn2.backgroundColor = [UIColor colorWithRed:255./225 green:192./225 blue:203./225 alpha:1];
//                    self.btn3.backgroundColor = [UIColor colorWithRed:238./225 green:130./225 blue:238./225 alpha:1];
//                    self.btn4.backgroundColor = [UIColor colorWithRed:240./225 green:255./225 blue:240./225 alpha:1];
//                    self.btn5.backgroundColor = [UIColor colorWithRed:240./225 green:255./225 blue:255./225 alpha:1];
//                    self.btn6.backgroundColor = [UIColor clearColor];
//                } completion:^(BOOL finished) {
//                    self.btn1.backgroundColor = [UIColor colorWithRed:135./225 green:206./225 blue:235./225 alpha:1];
//                    self.btn2.backgroundColor = [UIColor colorWithRed:255./225 green:192./225 blue:203./225 alpha:1];
//                    self.btn3.backgroundColor = [UIColor colorWithRed:238./225 green:130./225 blue:238./225 alpha:1];
//                    self.btn4.backgroundColor = [UIColor colorWithRed:240./225 green:255./225 blue:240./225 alpha:1];
//                    self.btn5.backgroundColor = [UIColor colorWithRed:240./225 green:255./225 blue:255./225 alpha:1];
//                    self.btn6.backgroundColor = [UIColor colorWithRed:255./225 green:228./225 blue:225./225 alpha:1];
             //   }];
           // }];
      //  }];
 //   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
