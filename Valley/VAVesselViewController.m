//
//  VAVesselViewController.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAVesselViewController.h"

@interface VAVesselViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation VAVesselViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	self.navigationController.navigationBar.translucent = NO;
	
	self.hasTitleView = YES;
	
	[self setupViewControllers];
	[self setupUserInterface];
}
	 
- (void)setupViewControllers {
	
	VAAssert;
}

- (void)setupUserInterface {
	
	if (self.hasTitleView) {
		_titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VESSEL_TITLE_HEIGHT)];
		_titleView.showsHorizontalScrollIndicator = NO;
		_titleView.backgroundColor = [UIColor whiteColor];
		_titleView.layer.borderWidth = 1;
		_titleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
		[self.view addSubview:_titleView];
	}
	
	if (self.hasTitleView) {
		_vesselView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), VIEW_WIDTH, VESSEL_VIEW_HEIGHT)];
	}
	else {
		_vesselView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
	}
	_vesselView.showsHorizontalScrollIndicator = NO;
    _vesselView.backgroundColor = [UIColor whiteColor];
	_vesselView.pagingEnabled = YES;
	_vesselView.bounces = NO;
	_vesselView.delegate = self;
	[self.view addSubview:_vesselView];
	
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		obj.view.frame = CGRectMake(VIEW_WIDTH*idx, 0, VIEW_WIDTH, CGRectGetHeight(self.vesselView.bounds));
        [self.vesselView addSubview:obj.view];
        [obj didMoveToParentViewController:self];
		
		if (self.hasTitleView) {
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.frame = CGRectMake(VESSEL_BUTTON_WIDTH*idx, 0, VESSEL_BUTTON_WIDTH, CGRectGetHeight(self.titleView.bounds));
			button.backgroundColor = [UIColor whiteColor];
			button.tag = idx;
			[button setTitle:obj.title forState:UIControlStateNormal];
			[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.titleView addSubview:button];
		}
		
    }];
	
	if (self.hasTitleView) {
		_titleView.contentSize = CGSizeMake(VESSEL_BUTTON_WIDTH * self.childViewControllers.count, 0);
	}
	
	_vesselView.contentSize = CGSizeMake(VIEW_WIDTH * self.childViewControllers.count, 0);
	_currentViewController = [self.childViewControllers firstObject];
	
	[_currentViewController beginAppearanceTransition:YES animated:YES];
	[_currentViewController endAppearanceTransition];
}

#pragma mark - UIViewController methods

- (BOOL)prefersStatusBarHidden {
	
	return YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
	
	return NO;
}

#pragma mark - scroll view delegate

- (void)buttonClicked:(UIButton *)sender {
	
	NSUInteger index = sender.tag;
	
	[self.vesselView setContentOffset:CGPointMake(VIEW_WIDTH*index, 0) animated:YES];
	[self switchViewControllerToIndex:index];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	NSUInteger index = scrollView.contentOffset.x / VIEW_WIDTH;
	
	if (self.hasTitleView) {
		[self.titleView setContentOffset:CGPointMake(VESSEL_BUTTON_WIDTH*index, 0) animated:YES];
	}
	
	[self switchViewControllerToIndex:index];
}

- (void)switchViewControllerToIndex:(NSUInteger)index {
	
	UIViewController *vc = self.childViewControllers[index];
	
	if (![vc isEqual:self.currentViewController]) {
		
		// first paramter return YES for triggering viewWillApper, NO for viewWillDisappear
		[vc beginAppearanceTransition:YES animated:YES];
		[vc endAppearanceTransition];
	}
	
	self.currentViewController = vc;
}

@end
