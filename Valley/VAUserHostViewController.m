//
//  VAUserHostViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserHostViewController.h"
#import "VAUserHostWorkTableViewCell.h"
#import "VAUserHostDiscoverTableViewCell.h"
#import "VAUserHostSubject.h"

#import "VAArticleViewController.h"
#import "VAArtViewController.h"

@interface VAUserHostViewController ()

@end

@implementation VAUserHostViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.title = @"Host";
	
	self.tableView.allowsSelection = YES;
	[self.tableView registerNib:[UINib nibWithNibName:USER_HOST_WORK_CELL bundle:nil] forCellReuseIdentifier:USER_HOST_WORK_CELL];
	[self.tableView registerNib:[UINib nibWithNibName:USER_HOST_DISCOVER_CELL bundle:nil] forCellReuseIdentifier:USER_HOST_DISCOVER_CELL];

	[VAUserHostSubject MR_truncateAll];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:[self.userUrlString stringByAppendingPathComponent:@"host"] parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			
			[VAUserHostSubject MR_importFromObject:subjectDir];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAUserHostSubject MR_requestAllSortedBy:@"mtime" ascending:NO];
	
	return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserHostSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	NSString *identifier = nil;
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		identifier = USER_HOST_WORK_CELL;
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		identifier = USER_HOST_DISCOVER_CELL;
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	VAUserHostSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		VAUserHostWorkTableViewCell *workCell = (VAUserHostWorkTableViewCell *)cell;
		[workCell loadCellWithModel:subject];
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		VAUserHostDiscoverTableViewCell *discoverCell = (VAUserHostDiscoverTableViewCell *)cell;
		[discoverCell loadCellWithModel:subject];
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserHostSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([subject.rowType isEqualToString:CELL_TYPE_WORK]) {
		return USER_HOST_WORK_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
	}
	
	if ([subject.rowType isEqualToString:CELL_TYPE_DISCOVER]) {
		return USER_HOST_DISCOVER_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
	}
	
	return DEFAULT_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserHostSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
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

@end
