//
//  VAArtistTableViewCell.h
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageViewDelegate.h"

@interface VAArtistTableViewCell : UITableViewCell

@property (nonatomic, weak) id<UIImageViewDelegate> delegate;

- (void)loadCellWithModel:(id)model;

@end
