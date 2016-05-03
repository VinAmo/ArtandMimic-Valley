//
//  VAHotViewController.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAHotViewController.h"
#import "VAWorkTableViewCell.h"
#import "VAHotSubject.h"
#import "VAUser.h"

#import "VAUserViewController.h"
#import "VAArtViewController.h"

@interface VAHotViewController () <UIImageViewDelegate>

@end

@implementation VAHotViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	self.title = @"Hot";
	[self.tableView registerNib:[UINib nibWithNibName:WORK_CELL bundle:nil] forCellReuseIdentifier:WORK_CELL];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:HOT_URL_STRING parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VAHotSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAHotSubject MR_requestAllSortedBy:@"workID" ascending:YES];
	
	return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WORK_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(VAWorkTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.delegate = self;
	[cell loadCellWithModel:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return WORK_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

#pragma mark - image view delegate

- (void)didTouchImageView:(NSString *)identifier withGestureRecognizer:(UIGestureRecognizer *)sender {
	
	NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender.view superview] superview]];
	VAHotSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([identifier isEqualToString:WORK_RAHMEN]) {
		
		VAArtViewController *artViewController = [[VAArtViewController alloc] init];
		artViewController.artID = subject.workID;
		
		[self.navigationController pushViewController:artViewController animated:YES];
	}
	
	if ([identifier isEqualToString:USER_AVATAR_RAHMEN]) {
		
		VAUserViewController *userViewController = [[VAUserViewController alloc] init];
		VAUser *user = subject.user;
		userViewController.userID = user.userID;
		userViewController.name = user.uname;
		
		[self.navigationController pushViewController:userViewController animated:YES];
	}
	
}

@end
