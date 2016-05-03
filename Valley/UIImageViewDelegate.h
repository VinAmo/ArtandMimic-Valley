//
//  UIImageViewDelegate.h
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIImageViewDelegate <NSObject>

- (void)didTouchImageView:(NSString *)identifier withGestureRecognizer:(UIGestureRecognizer *)sender;

@end
