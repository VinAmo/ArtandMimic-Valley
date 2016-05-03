//
//  VAWork.m
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAWork.h"
#import "VAArtistSubject.h"
#import "VACategory.h"
#import "VAPicture.h"
#import "VASize.h"
#import "VAUser.h"

@implementation VAWork

// Insert code here to add functionality to your managed object subclass

- (void)setMtime:(NSString *)mtime {
	
	[self willChangeValueForKey:@"mtime"];
	
	NSTimeInterval secs = [[NSDate date] timeIntervalSince1970] - [mtime doubleValue];
	NSString *result = nil;
	long long int temp = 0;
	if (secs < 60) {
		result = @"Just now";
	}
	else if ((temp = secs/60) < 60) {
		result = [NSString stringWithFormat:@"%lldminutes ago", temp];
	}
	else if ((temp = temp/60) < 24) {
		result = [NSString stringWithFormat:@"%lldhours ago", temp];
	}
	else if ((temp = temp/24) < 7) {
		result = [NSString stringWithFormat:@"%llddays ago", temp];
	}
	else if ((temp/7) < 5) {
		result = [NSString stringWithFormat:@"%lldweeks ago", temp/7];
	}
	else if ((temp = temp/30) < 12) {
		result = [NSString stringWithFormat:@"%lldmonths ago", temp];
	}
	else if ((temp = temp/12) < 10) {
		result = [NSString stringWithFormat:@"%lldyears ago", temp];
	}
	else if ((temp = temp/10) < 10) {
		result = [NSString stringWithFormat:@"%llddecades ago", temp];
	}
	else if ((temp = temp/10) < 10) {
		result = [NSString stringWithFormat:@"%lldcenturies ago", temp];
	}
	else if ((temp = temp/10) < 1000) {
		result = [NSString stringWithFormat:@"%lldmillenniums ago", temp];
	}
	else if ((temp = temp/1000) < 1000) {
		result = [NSString stringWithFormat:@"%lldmegaannums ago", temp];
	}
	else if ((temp = temp/1000) < 1000) {
		result = [NSString stringWithFormat:@"%lldgigaannums ago", temp];
	}
	else if ((temp = temp/1000) < 1000) {
		result = [NSString stringWithFormat:@"%lldteraannums ago", temp];
	}
	else {
		temp = temp/1000;
		result = [NSString stringWithFormat:@"%lldpetaannums ago", temp];
	}
	
	[self setPrimitiveValue:result forKey:@"mtime"];
	[self didChangeValueForKey:@"mtime"];
}


//- (void)awakeFromFetch {
//	
//	[self addObserver:self forKeyPath:@"" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:NULL];
//}
//
//- (void)awakeFromInsert {
//	
//	[self addObserver:self forKeyPath:@"" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:NULL];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//	
//	if ([keyPath isEqualToString:@""]) {
//		NSString *oldValue = [change objectForKey:NSKeyValueChangeOldKey];
//		NSString *newValue = [change objectForKey:NSKeyValueChangeNewKey];
//		if (![newValue isEqualToString:oldValue]) {
//			// do something
//		}
//	}
//}
//
//- (void)willTurnIntoFault {
//	
//	[self removeObserver:self forKeyPath:@""];
//}

@end
