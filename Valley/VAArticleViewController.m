//
//  VAArticleViewController.m
//  Valley
//
//  Created by V on 23/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAArticleViewController.h"
#import "VAArticleSubject.h"

@interface VAArticleViewController ()

@property (nonatomic, strong) VAArticleSubject *article;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation VAArticleViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.navigationController.navigationBarHidden = NO;
	
	[self setupUserInterface];
	
	[self loadData];
}

#pragma mark - basic methods

- (void)setupUserInterface {
	
	self.webView = [[UIWebView alloc] initWithFrame:VIEW_BOUNDS];
	[self.view addSubview:self.webView];
}

- (void)loadData {
	
	[[VAWell well] POST:[ARTICLE_URL_STRING stringByAppendingPathComponent:self.articleID] parameters:nil success:^(id responseObject) {
		
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			
			self.article = [VAArticleSubject MR_importFromObject:responseObject[@"article"]];
			
			[self updateUserInterface];
			
		}
		
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (void)updateUserInterface {
	
	[self.webView loadHTMLString:self.article.content baseURL:[[NSBundle mainBundle] bundleURL]];
	VALog(self.article.content);
}

#pragma mark - view controller delgate

- (BOOL)prefersStatusBarHidden {
	
	return YES;
}


@end
