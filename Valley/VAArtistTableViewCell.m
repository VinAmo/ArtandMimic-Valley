//
//  VAArtistTableViewCell.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAArtistTableViewCell.h"
#import "VAArtistSubject.h"
#import "VAUser.h"
#import "VAWork.h"

@interface VAArtistTableViewCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *worksScrollView;      // works
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarRahmen;      // user.userID
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;             // user.uname
@property (weak, nonatomic) IBOutlet UIImageView *userIsVerifiedRahmen;  // isVerify
@property (weak, nonatomic) IBOutlet UILabel *userWorksLabel;            // numWork
@property (weak, nonatomic) IBOutlet UILabel *userFansLabel;             // numFollowed
@property (weak, nonatomic) IBOutlet UILabel *userCityLabel;             // city
@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end

@implementation VAArtistTableViewCell

- (void)awakeFromNib {
	
	self.userAvatarRahmen.userInteractionEnabled = YES;
	[self.userAvatarRahmen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
}

- (void)loadCellWithModel:(VAArtistSubject *)model {
	
    CGFloat rahmenLength = CGRectGetHeight(self.worksScrollView.bounds);
    [[model.works allObjects] enumerateObjectsUsingBlock:^(VAWork * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] initWithWebImage];
		imageNode.frame = VASquareMake(rahmenLength*idx, 0, rahmenLength);
		imageNode.contentMode = UIViewContentModeScaleAspectFill;
		imageNode.clipsToBounds = YES;
		imageNode.userInteractionEnabled = YES;
		imageNode.view.tag = idx;
		imageNode.URL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:obj.pid]];
		[imageNode.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
		[self.worksScrollView addSubnode:imageNode];
		
//        UIImageView *workRahmen = [[UIImageView alloc] initWithFrame:VASquareMake(rahmenLength*idx, 0, rahmenLength)];
//		workRahmen.contentMode = UIViewContentModeScaleAspectFill;
//		workRahmen.clipsToBounds = YES;
//		workRahmen.userInteractionEnabled = YES;
//		workRahmen.tag = idx;
//		[workRahmen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)]];
//        NSURL *workURL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:obj.pid]];
//        [workRahmen sd_setImageWithURL:workURL placeholderImage:[UIImage imageNamed:@"fengmian"]];
//        [self.worksScrollView addSubview:workRahmen];
    }];
    self.worksScrollView.contentSize = CGSizeMake(rahmenLength*model.works.count, 0);
    
	VAUser *user = model.user;
	NSURL *avatarURL = [NSURL URLWithString:[HEAD_URL_STRING stringByAppendingPathComponent:user.userID]];
	[self.userAvatarRahmen sd_setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"Defaultheadphotp"]];
	
	self.userNameLabel.text = user.uname;
	self.userIsVerifiedRahmen.hidden = ![user.isVerify boolValue];
    self.userWorksLabel.text = [NSString stringWithFormat:@"%@件作品", user.numWork];
    self.userFansLabel.text = [NSString stringWithFormat:@"%@个粉丝", user.numFollowed];
	self.userCityLabel.text = user.city;
}

- (void)handleTouch:(UIGestureRecognizer *)sender {
	
	if (sender.state == UIGestureRecognizerStateEnded) {
		
		if ([sender.view isEqual:self.userAvatarRahmen]) {
			[self.delegate didTouchImageView:USER_AVATAR_RAHMEN withGestureRecognizer:sender];
		}
		else {
			[self.delegate didTouchImageView:WORK_RAHMEN withGestureRecognizer:sender];
		}
	}
	
	
}

@end
