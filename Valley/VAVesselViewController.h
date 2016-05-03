//
//  VAVesselViewController.h
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VAVesselViewController : UIViewController

@property (nonatomic, assign) BOOL hasTitleView;

@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic, strong) UIScrollView *vesselView;

@end
