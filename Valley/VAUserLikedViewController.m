//
//  VAUserLikedViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserLikedViewController.h"
#import "VAWorkTableViewCell.h"
#import "VADiscoverTableViewCell.h"
#import "VAUserLikedSubject.h"
#import "VAUser.h"

#import "VAUserViewController.h"
#import "VAArtViewController.h"
#import "VAArticleViewController.h"

@interface VAUserLikedViewController () <UIImageViewDelegate>

@end

@implementation VAUserLikedViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.title = @"Liked";
	
	self.tableView.allowsSelection = YES;
	[self.tableView registerNib:[UINib nibWithNibName:WORK_CELL bundle:nil] forCellReuseIdentifier:WORK_CELL];
	[self.tableView registerNib:[UINib nibWithNibName:DISCOVER_CELL bundle:nil] forCellReuseIdentifier:DISCOVER_CELL];
	
	[VAUserLikedSubject MR_truncateAll];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:[self.userUrlString stringByAppendingPathComponent:@"like"] parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			
			[VAUserLikedSubject MR_importFromObject:subjectDir];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAUserLikedSubject MR_requestAllSortedBy:nil ascending:YES];
	
	return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserLikedSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	NSString *identifier = nil;
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		identifier = WORK_CELL;
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		identifier = DISCOVER_CELL;
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	VAUserLikedSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		VAWorkTableViewCell *workCell = (VAWorkTableViewCell *)cell;
		workCell.delegate = self;
		[workCell loadCellWithModel:subject];
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		VADiscoverTableViewCell *discoverCell = (VADiscoverTableViewCell *)cell;
		discoverCell.delegate = self;
		[discoverCell loadCellWithModel:subject];
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserLikedSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		return WORK_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		return DISCOVER_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
	}
	
	return DEFAULT_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserLikedSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		
		VAArtViewController *artViewController = [[VAArtViewController alloc] init];
		artViewController.artID = subject.workID;
		
		[self.navigationController pushViewController:artViewController animated:YES];
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		
		VAArticleViewController *articleViewController = [[VAArticleViewController alloc] init];
		articleViewController.articleID = subject.workID;
		
		[self.navigationController pushViewController:articleViewController animated:YES];
	}
	
	
}

#pragma mark - image view delegate

- (void)didTouchImageView:(NSString *)identifier withGestureRecognizer:(UIGestureRecognizer *)sender {
	
	NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender.view superview] superview]];
	VAUserLikedSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([identifier isEqualToString:USER_AVATAR_RAHMEN]) {
		
		VAUserViewController *userViewController = [[VAUserViewController alloc] init];
		VAUser *user = subject.user;
		userViewController.userID = user.userID;
		
		[self.navigationController pushViewController:userViewController animated:YES];
	}
	
}

@end
