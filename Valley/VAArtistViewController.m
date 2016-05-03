//
//  VAArtistViewController.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAArtistViewController.h"
#import "VAArtistTableViewCell.h"
#import "VAArtistSubject.h"
#import "VAWork.h"
#import "VAUser.h"

#import "VAUserViewController.h"
#import "VAArtViewController.h"

@interface VAArtistViewController () <UIImageViewDelegate>

@end

@implementation VAArtistViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	self.title = @"Artist";
    [self.tableView registerNib:[UINib nibWithNibName:ARTIST_CELL bundle:nil] forCellReuseIdentifier:ARTIST_CELL];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:ARTIST_URL_STRING parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VAArtistSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
    
    NSFetchRequest *fetchRequest = [VAArtistSubject MR_requestAllSortedBy:nil ascending:YES];
    
    return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VAArtistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ARTIST_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(VAArtistTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.delegate = self;
	[cell loadCellWithModel:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return ARTIST_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

#pragma mark - image view delegate

- (void)didTouchImageView:(NSString *)identifier withGestureRecognizer:(UIGestureRecognizer *)sender {
	
	if ([identifier isEqualToString:WORK_RAHMEN]) {
		
		NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[[sender.view superview] superview] superview]];
		VAArtistSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
		
		NSUInteger idx = sender.view.tag;
		VAWork *work = [subject.works allObjects][idx];
		
		VAArtViewController *artViewController = [[VAArtViewController alloc] init];
		artViewController.artID = work.workID;
		
		[self.navigationController pushViewController:artViewController animated:YES];
	}
	
	if ([identifier isEqualToString:USER_AVATAR_RAHMEN]) {
		
		NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender.view superview] superview]];
		VAArtistSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
		
		VAUserViewController *userViewController = [[VAUserViewController alloc] init];
		VAUser *user = subject.user;
		userViewController.userID = user.userID;
		userViewController.name = user.uname;
		
		[self.navigationController pushViewController:userViewController animated:YES];
	}
	
	
}

@end
