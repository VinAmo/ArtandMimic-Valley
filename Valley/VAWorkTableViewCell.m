//
//  VAWorkTableViewCell.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAWorkTableViewCell.h"
#import "VAWork.h"
#import "VAPicture.h"
#import "VAUser.h"

@interface VAWorkTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *workRahmen;            // pid
@property (weak, nonatomic) IBOutlet UILabel *workTitleLabel;            // name
@property (weak, nonatomic) IBOutlet UILabel *workSubtitleLabel;         // times
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarRahmen;      // user.userID
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;             // user.uname
@property (weak, nonatomic) IBOutlet UIImageView *userIsVerifiedRahmen;  // isVerify
@property (weak, nonatomic) IBOutlet UILabel *userLastLoginLabel;        //
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;             // city
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;


@end

@implementation VAWorkTableViewCell

- (void)awakeFromNib {
	
	self.workRahmen.userInteractionEnabled = YES;
	[self.workRahmen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
	
	self.userAvatarRahmen.userInteractionEnabled = YES;
	[self.userAvatarRahmen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
}

- (void)handleTouch:(UIGestureRecognizer *)sender {
	
	if (sender.state == UIGestureRecognizerStateEnded) {
		
		if ([sender.view isEqual:self.workRahmen]) {
			[self.delegate didTouchImageView:WORK_RAHMEN withGestureRecognizer:sender];
		}
		if ([sender.view isEqual:self.userAvatarRahmen]) {
			[self.delegate didTouchImageView:USER_AVATAR_RAHMEN withGestureRecognizer:sender];
		}
	}
}

- (void)loadCellWithModel:(VAWork *)model {
	
	VAUser *user = model.user;
	
	NSURL *workURL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:model.pid]];
	NSURL *avatarURL = [NSURL URLWithString:[HEAD_URL_STRING stringByAppendingPathComponent:user.userID]];

	[self.workRahmen setImageWithURL:workURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[self.userAvatarRahmen sd_setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"Defaultheadphotp"] options:SDWebImageRetryFailed];
	
	self.workTitleLabel.text = model.name;
	self.workSubtitleLabel.text = model.times;
	self.userNameLabel.text = user.uname;
	self.userIsVerifiedRahmen.hidden = ![user.isVerify boolValue];
	self.userLastLoginLabel.text = model.mtime;
	self.userCityLabel.text = user.city;
}

@end
