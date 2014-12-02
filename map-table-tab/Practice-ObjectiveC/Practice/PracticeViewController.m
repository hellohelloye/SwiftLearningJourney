//
//  PracticeViewController.m
//  Practice
//
//  Created by Yukui ye on 11/7/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import "PracticeViewController.h"
#import "TableViewController.h"

@interface PracticeViewController ()

@property (readwrite, assign) BOOL isShowingLandscapeView;
@property (readwrite, assign) BOOL previousOrientation;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TableViewController *tableViewControlelr;

@end

@implementation PracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 62)];
    self.toolBar.barTintColor = [UIColor colorWithRed:145./225 green:206./225 blue:250./225 alpha:0.4];
    self.toolBar.alpha = 0.4;
    self.toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(showList)];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"Direction" style:UIBarButtonItemStylePlain target:self action:@selector(showDirection)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor orangeColor];
    shadow.shadowOffset = CGSizeMake(1, 0);
    [leftBarBtn setTitleTextAttributes:@{
                                             NSForegroundColorAttributeName: [UIColor blueColor],
                                             NSShadowAttributeName:shadow,
                                             NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:10.0f]
                                             }
                                  forState:UIControlStateNormal];
    
    [rightBarBtn setTitleTextAttributes:@{
                                               NSForegroundColorAttributeName: [UIColor blueColor],
                                               NSShadowAttributeName:shadow,
                                               NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:10.0f]
                                               }
                                    forState:UIControlStateNormal];
    
    
    [self.toolBar setItems:[[NSArray alloc] initWithObjects:leftBarBtn, flexibleSpace, rightBarBtn, nil]];
    [self.view addSubview:self.toolBar];
     
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView.superview).with.offset(62);  //navBar
        make.left.equalTo(self.mapView.superview);
        make.right.equalTo(self.mapView.superview);
       // make.bottom.equalTo(self.mapView.superview).with.offset(-32); //tabBarItem
        make.bottom.equalTo(self.mapView.superview);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.locationManager = [[CLLocationManager alloc] init] ;
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    [self wtsCheckingInternectConnection];
    [self registerAllNotification];
}

#pragma - mark - MKMapViewDelegate



#pragma - mark - UIBarButtonItem Action

- (void)showList {
    self.tableViewControlelr = [[TableViewController alloc] init];
    [self addChildViewController:self.tableViewControlelr];
    [self.view addSubview:self.tableViewControlelr.view];
    [self.tableViewControlelr didMoveToParentViewController:self];
    [self.tableViewControlelr beginAppearanceTransition:YES animated:YES];
}

-(void)showDirection {
    MKUserLocation *userLocation = self.mapView.userLocation;
    if (userLocation.location.coordinate.latitude == 0 || userLocation.location.coordinate.longitude == 0) {
        [TSMessage showNotificationInViewController:self
                                              title:NSLocalizedString(@"Location Service Disabled", nil)
                                           subtitle:NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Service for this app.", nil)
                                              image:nil
                                               type:TSMessageNotificationTypeWarning
                                           duration:5
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                               canBeDismissedByUser:NO];
    } else {
//        NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@,%@",self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude, , ];
//        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }

}

#pragma mark - Internet Reachability Checking

- (void)wtsCheckingInternectConnection {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
}

- (void) reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    
    if (reachability == self.internetReachability || reachability == self.wifiReachability) {
        if (netStatus == ReachableViaWWAN || netStatus == ReachableViaWiFi) {
            self.mapView.showsUserLocation = YES;
            [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.782865, -73.965355), MKCoordinateSpanMake(9.0/69.0, 9.0/69.0)) animated:YES];
        } else if (netStatus == NotReachable) {
            [TSMessage showNotificationInViewController:self
                                                  title:NSLocalizedString(@"Something failed", nil)
                                               subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                                  image:nil
                                                   type:TSMessageNotificationTypeWarning
                                               duration:5
                                               callback:nil
                                            buttonTitle:nil
                                         buttonCallback:nil
                                             atPosition:TSMessageNotificationPositionTop
                                   canBeDismissedByUser:NO];
        }
    } else {
        if (connectionRequired) {
            [TSMessage showNotificationInViewController:self
                                                  title:NSLocalizedString(@"Connection Required", nil)
                                               subtitle:NSLocalizedString(@"Concatenation of status string with connection requirement!", nil)
                                                  image:nil
                                                   type:TSMessageNotificationTypeWarning
                                               duration:5
                                               callback:nil
                                            buttonTitle:nil
                                         buttonCallback:nil
                                             atPosition:TSMessageNotificationPositionTop
                                   canBeDismissedByUser:NO];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
}

#pragma DeviceOrientationDetection -- rearrange view layout for iPhone&iPad

- (void)registerAllNotification {
    self.isShowingLandscapeView = UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    self.previousOrientation    = NO;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)orientationChanged:(NSNotification *)notification {
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        //do something
    } else {
        UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
        if (UIDeviceOrientationIsLandscape(deviceOrientation) && !self.isShowingLandscapeView) {
            self.isShowingLandscapeView = YES;
        }
        else if (UIDeviceOrientationIsPortrait(deviceOrientation) && self.isShowingLandscapeView) {
            self.isShowingLandscapeView = NO;
        }
        if (self.previousOrientation != self.isShowingLandscapeView) {
            if (self.isShowingLandscapeView) {
                // NSLog(@"Orientation Change Occur: Landscape Mode");
            }
        } else {
                // NSLog(@"Orientation Change Occur: Portrait Mode");
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OrientationChange" object:nil];
    }
    self.previousOrientation = self.isShowingLandscapeView;
}

- (NSUInteger)supportedInterfaceOrientations {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
