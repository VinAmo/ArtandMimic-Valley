//
//  VAUserCoverViewController.m
//  Valley
//
//  Created by V on 30/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserCoverViewController.h"
#import "VAUser.h"

@interface VAUserCoverViewController () <UMSocialUIDelegate, UMSocialDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverRahmen;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, copy) NSString *cover;

@end

@implementation VAUserCoverViewController

- (void)viewDidLoad {

	[super viewDidLoad];
	
	[self setupUserInterface];
	[self loadData];

//	[[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//	[UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];

	
}

- (void)setupUserInterface {
	

}

- (void)loadData {
	
	[[VAWell well] GET:[USER_URL_STRING stringByAppendingPathComponent:self.userID] parameters:nil success:^(id responseObject) {
		
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			
			self.cover = [responseObject valueForKeyPath:@"owner.cover"];
			
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
	
	self.nameLabel.text = self.name;
	
	NSURL *coverURL = [NSURL URLWithString:[COVER_URL_STRING stringByAppendingPathComponent:self.cover]];
	[self.coverRahmen setImageWithURL:coverURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)share {
	
	[UMSocialSnsService presentSnsIconSheetView:self
										 appKey:UMENG_APP_KEY
									  shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
									 shareImage:[UIImage imageNamed:@"icon"]
								shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
									   delegate:self];
}

#pragma mark - UM social delegate

- (BOOL)isDirectShareInIconActionSheet {
	
	return YES;
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
	
	//根据`responseCode`得到发送结果,如果分享成功
	if(response.responseCode == UMSResponseCodeSuccess)
	{
		//得到分享到的微博平台名
		NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
	}
}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response {
	
	
}

@end
