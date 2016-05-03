//
//  VAArtViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAArtViewController.h"
#import "VAWork.h"
#import "VAUser.h"

@interface VAArtViewController ()

@property (nonatomic, strong) VAWork *work;

@property (weak, nonatomic) IBOutlet UIImageView *artRahmen;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;             // workType/size/times
@property (weak, nonatomic) IBOutlet UILabel *viewNumberLabel;       // numView;
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;         // numLiked;
@property (weak, nonatomic) IBOutlet UIButton *rewardButton;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarRahmen;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;         // uname
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescLabel;         // numWork/numFollowed

@end

@implementation VAArtViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.navigationController.navigationBarHidden = NO;
	
	[self setupUserInterface];
	
	[self loadData];
}

#pragma mark - basic methods

- (void)setupUserInterface {
	
	self.rewardButton.layer.borderColor = [VAPalette greenMint].CGColor;
	self.rewardButton.layer.borderWidth = 1;
}

- (void)loadData {
	
	[[VAWell well] POST:[ART_URL_STRING stringByAppendingPathComponent:self.artID] parameters:nil success:^(id responseObject) {
		
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			
			self.work = [VAWork MR_importFromObject:responseObject[@"work"]];
			[self updateUserInterface];
			
		}
		
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (void)updateUserInterface {
	
	VAUser *user = self.work.user;

	NSURL *workURL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:self.work.pid]];
	NSURL *avatarURL = [NSURL URLWithString:[HEAD_URL_STRING stringByAppendingPathComponent:user.userID]];
	[self.artRahmen sd_setImageWithURL:workURL placeholderImage:nil];
	[self.userAvatarRahmen sd_setImageWithURL:avatarURL placeholderImage:nil];

	self.nameLabel.text = self.work.name;
	self.descLabel.text = self.work.times;
	self.viewNumberLabel.text = [self.work.numView stringByAppendingString:@"浏览"];
	[self.upvoteButton setTitle:self.work.numLiked forState:UIControlStateNormal];
	self.userNameLabel.text = user.uname;
	self.userCityLabel.text = user.city;
	self.userDescLabel.text = [NSString stringWithFormat:@"%@件作品/%@位圈内人关注", user.numWork, user.numFollowed];
}

#pragma mark - view controller delgate

- (BOOL)prefersStatusBarHidden {
	
	return YES;
}

@end
