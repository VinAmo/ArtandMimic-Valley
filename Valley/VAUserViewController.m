//
//  VAUserViewController.m
//  Valley
//
//  Created by V on 06/01/2016.
//  Copyright © 2016 V. All rights reserved.
//

#import "VAUserViewController.h"
#import "VAUserMainViewController.h"
#import "VAUserCoverViewController.h"

@interface VAUserViewController ()

@end

@implementation VAUserViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	self.navigationController.navigationBarHidden = NO;
}

- (void)setupViewControllers {
	
	self.hasTitleView = NO;
	
	VAUserCoverViewController *userCoverViewController = [VAUserCoverViewController new];
	userCoverViewController.userID = self.userID;
	userCoverViewController.name = self.name;
	
	VAUserMainViewController *userMainViewController = [VAUserMainViewController new];
	userMainViewController.userID = self.userID;
	userMainViewController.name = self.name;
	
	[self addChildViewController:userCoverViewController];
	[self addChildViewController:userMainViewController];
}

- (BOOL)prefersStatusBarHidden {
	
	return YES;
}

@end
