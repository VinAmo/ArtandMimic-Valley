//
//  VAUserMainViewController.m
//  Valley
//
//  Created by V on 06/01/2016.
//  Copyright © 2016 V. All rights reserved.
//

#import "VAUserMainViewController.h"

static NSString * const hostViewControllerClass       = @"VAUserHostViewController";
static NSString * const resumeViewControllerClass     = @"VAUserResumeViewController";
static NSString * const collectionViewControllerClass = @"VAUserCollectionViewController";
static NSString * const articleViewControllerClass    = @"VAUserArticleViewController";
static NSString * const saleViewControllerClass       = @"VAUserSaleViewController";
static NSString * const likedViewControllerClass      = @"VAUserLikedViewController";

static NSString * const kUserUrlString = @"userUrlString";

@interface VAUserMainViewController ()

@end

@implementation VAUserMainViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	self.navigationItem.title = self.name;
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	
}

- (void)setupViewControllers {
	
	NSArray *viewControllerClasses = @[ hostViewControllerClass,
										resumeViewControllerClass,
										collectionViewControllerClass,
										articleViewControllerClass,
										saleViewControllerClass,
										likedViewControllerClass ];
	
	[viewControllerClasses enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
		Class class = NSClassFromString(obj);
		UIViewController *viewController = [[class alloc] init];
		[viewController setValue:[USER_URL_STRING stringByAppendingPathComponent:self.userID] forKey:kUserUrlString];
		[self addChildViewController:viewController];
	}];
	
}

@end
