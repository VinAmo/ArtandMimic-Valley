//
//  VAUserHostWorkTableViewCell.m
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserHostWorkTableViewCell.h"
#import "VAUserHostSubject.h"

@interface VAUserHostWorkTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *workRahmen;            // pid
@property (weak, nonatomic) IBOutlet UILabel *workTitleLabel;            // name
@property (weak, nonatomic) IBOutlet UILabel *workSubtitleLabel;         // times

@end

@implementation VAUserHostWorkTableViewCell

- (void)awakeFromNib {
	
}

- (void)loadCellWithModel:(VAUserHostSubject *)model {
	
	NSURL *workURL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:model.pid]];
	[self.workRahmen setImageWithURL:workURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	
	self.workTitleLabel.text = model.name;
	self.workSubtitleLabel.text = model.times;
}

@end
