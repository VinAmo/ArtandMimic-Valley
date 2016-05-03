//
//  VADiscoverTableViewCell.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VADiscoverTableViewCell.h"
#import "VAWork.h"
#import "VAUser.h"

@interface VADiscoverTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsRahmen;            // pid
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;                // title
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;        // desc
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarRahmen;      // user.userID
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;             // user.uname
@property (weak, nonatomic) IBOutlet UIImageView *userIsVerifiedRahmen;  // isVerify
@property (weak, nonatomic) IBOutlet UILabel *userLastLoginLabel;        //
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;             // city
@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;

@end

@implementation VADiscoverTableViewCell

- (void)awakeFromNib {
	
	self.userAvatarRahmen.userInteractionEnabled = YES;
	[self.userAvatarRahmen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
}

- (void)handleTouch:(UIGestureRecognizer *)sender {
	
	if (sender.state == UIGestureRecognizerStateEnded) {
	
		if ([sender.view isEqual:self.userAvatarRahmen]) {
			[self.delegate didTouchImageView:USER_AVATAR_RAHMEN withGestureRecognizer:sender];
		}
	}
}

- (void)loadCellWithModel:(VAWork *)model {
    
    VAUser *user = model.user;
    
    NSURL *newsURL = [NSURL URLWithString:[NEWS_URL_STRING stringByAppendingPathComponent:model.pid]];
    NSURL *avatarURL = [NSURL URLWithString:[HEAD_URL_STRING stringByAppendingPathComponent:user.userID]];

	[self.newsRahmen setImageWithURL:newsURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[self.userAvatarRahmen sd_setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"Defaultheadphotp"] options:SDWebImageRefreshCached];
    
    self.titleLabel.text = model.title;
    self.contentTextView.text = model.desc;
    self.userNameLabel.text = user.uname;
    self.userIsVerifiedRahmen.hidden = ![user.isVerify boolValue];
	self.userLastLoginLabel.text = model.mtime;
    self.userCityLabel.text = user.city;
}

@end
