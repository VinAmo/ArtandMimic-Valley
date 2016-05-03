//
//  VAUserCollectionViewCell.m
//  Valley
//
//  Created by V on 24/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserCollectionViewCell.h"
#import "VAUserCollectionSubject.h"

@interface VAUserCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverRahmen;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numWorkLabel;

@end

@implementation VAUserCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadCellWithModel:(VAUserCollectionSubject *)model {
	
	NSURL *coverURL = [NSURL URLWithString:[COLLECTION_COVER_URL_STRING stringByAppendingPathComponent:model.coverID]];
	[self.coverRahmen setImageWithURL:coverURL placeholderImage:nil options:SDWebImageLowPriority usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	
	self.nameLabel.text = model.name;
	self.numWorkLabel.text = [model.numWork stringByAppendingString:@"件作品"];
}

@end
