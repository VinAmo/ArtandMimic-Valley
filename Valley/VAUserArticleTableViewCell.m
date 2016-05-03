//
//  VAUserArticleTableViewCell.m
//  Valley
//
//  Created by V on 24/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserArticleTableViewCell.h"
#import "VAUserArticleSubject.h"

@interface VAUserArticleTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsRahmen;            // pid
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;                // title
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;        // desc

@end

@implementation VAUserArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadCellWithModel:(VAUserArticleSubject *)model {
	VALog(model);
	NSURL *newsURL = [NSURL URLWithString:[NEWS_URL_STRING stringByAppendingPathComponent:model.pid]];
	[self.newsRahmen setImageWithURL:newsURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	
	self.titleLabel.text = model.title;
	self.contentTextView.text = model.desc;
}

@end
