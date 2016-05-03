//
//  VAUserResumeViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserResumeViewController.h"

@interface VAUserResumeViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *htmlString;

@end

@implementation VAUserResumeViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.title = @"Resume";
	
	[self setupUserInterface];
	
	[self loadData];
}

#pragma mark - basic methods

- (void)setupUserInterface {
	
	self.webView = [[UIWebView alloc] initWithFrame:VIEW_BOUNDS];
	[self.view addSubview:self.webView];
}

- (void)loadData {
	
	[[VAWell well] POST:[self.userUrlString stringByAppendingPathComponent:@"resume"] parameters:nil success:^(id responseObject) {
		
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			
			self.htmlString = responseObject[@"resume"][@"resume"];
			[self updateUserInterface];
			
		}
		
		
	} failure:^(NSError *error) {
		
		[[VAVictim victim] alertWithTitle:@"Request error"
								  message:[error localizedDescription]
							 cancelAction:@"OK"
								  handler:^(UIAlertAction * _Nullable action) {
									  
									  VALogSelector;
									  
								  } completion:^{
									  
									  
								  } via:self];
		
	}];
}

- (void)updateUserInterface {
	
	[self.webView loadHTMLString:self.htmlString baseURL:nil];
	
}

@end
