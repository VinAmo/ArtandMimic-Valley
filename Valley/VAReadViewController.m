//
//  VAReadViewController.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAReadViewController.h"
#import "VADiscoverTableViewCell.h"
#import "VAReadSubject.h"
#import "VAUser.h"

#import "VAUserViewController.h"
#import "VAArticleViewController.h"

@interface VAReadViewController () <UIImageViewDelegate>

@end

@implementation VAReadViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	self.title = @"Read";
	
	self.tableView.allowsSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:DISCOVER_CELL bundle:nil] forCellReuseIdentifier:DISCOVER_CELL];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:READ_URL_STRING parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VAReadSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
    
    NSFetchRequest *fetchRequest = [VAReadSubject MR_requestAllSortedBy:@"mtime" ascending:YES];
    
    return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VADiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DISCOVER_CELL forIndexPath:indexPath];
    
	[self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(VADiscoverTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.delegate = self;
	[cell loadCellWithModel:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DISCOVER_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAReadSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	VAArticleViewController *articleViewController = [[VAArticleViewController alloc] init];
	articleViewController.articleID = subject.workID;
	
	[self.navigationController pushViewController:articleViewController animated:YES];
}

#pragma mark - image view delegate

- (void)didTouchImageView:(NSString *)identifier withGestureRecognizer:(UIGestureRecognizer *)sender {
	
	NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender.view superview] superview]];
	VAReadSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([identifier isEqualToString:USER_AVATAR_RAHMEN]) {
		
		VAUserViewController *userViewController = [[VAUserViewController alloc] init];
		VAUser *user = subject.user;
		userViewController.userID = user.userID;
		userViewController.name = user.uname;
		
		[self.navigationController pushViewController:userViewController animated:YES];
	}
	
}

@end
