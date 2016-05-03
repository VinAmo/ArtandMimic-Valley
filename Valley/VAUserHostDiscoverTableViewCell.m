//
//  VAUserHostDiscoverTableViewCell.m
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserHostDiscoverTableViewCell.h"
#import "VAUserHostSubject.h"

@interface VAUserHostDiscoverTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsRahmen;            // pid
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;                // title
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;        // desc

@end

@implementation VAUserHostDiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadCellWithModel:(VAUserHostSubject *)model {
	
	NSURL *newsURL = [NSURL URLWithString:[NEWS_URL_STRING stringByAppendingPathComponent:model.pid]];
	[self.newsRahmen setImageWithURL:newsURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	
	self.titleLabel.text = model.title;
	self.contentTextView.text = model.desc;
}

@end
