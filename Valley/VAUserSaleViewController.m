//
//  VAUserSaleViewController.m
//  Valley
//
//  Created by V on 24/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserSaleViewController.h"
#import "VAUserSaleSubject.h"

@interface VAUserSaleViewController ()

@end

@implementation VAUserSaleViewController

- (void)viewDidLoad {

	[super viewDidLoad];
	
	self.title = @"Sale";

	[VAUserSaleSubject MR_truncateAll];
}

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:[self.userUrlString stringByAppendingPathComponent:@"sale"] parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VAUserSaleSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
//			[VAUserSaleSubject MR_importFromObject:subjectDir];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
	
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAUserSaleSubject MR_requestAllSortedBy:nil ascending:YES];
	
	return fetchRequest;
}

@end
