//
//  VAMainViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAMainViewController.h"

static NSString * const hotViewControllerClass       = @"VAHotViewController";
static NSString * const artistViewControllerClass    = @"VAArtistViewController";
static NSString * const saleViewControllerClass      = @"VASaleViewController";
static NSString * const readViewControllerClass      = @"VAReadViewController";
static NSString * const personageViewControllerClass = @"VAPersonageViewController";
static NSString * const exhibitViewControllerClass   = @"VAExhibitViewController";

@interface VAMainViewController ()

@end

@implementation VAMainViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	self.navigationController.navigationBarHidden = YES;
}

- (void)setupViewControllers {
	
	NSArray *viewControllerClasses = @[ hotViewControllerClass,
										artistViewControllerClass,
										saleViewControllerClass,
										readViewControllerClass,
										personageViewControllerClass,
										exhibitViewControllerClass ];
	
	[viewControllerClasses enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
		Class class = NSClassFromString(obj);
		UIViewController *viewController = [[class alloc] init];
		[self addChildViewController:viewController];
	}];
	
}

@end
