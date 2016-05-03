//
//  VAUserArticleViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserArticleViewController.h"
#import "VAUserArticleTableViewCell.h"
#import "VAUserArticleSubject.h"

@interface VAUserArticleViewController ()

@end

@implementation VAUserArticleViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.title = @"Article";
	
	[self.tableView registerNib:[UINib nibWithNibName:USER_ARTICLE_CELL bundle:nil] forCellReuseIdentifier:USER_ARTICLE_CELL];

	[VAUserArticleSubject MR_truncateAll];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	VALog([self.userUrlString stringByAppendingPathComponent:@"article"]);
	[self acquireDataWithURLString:[self.userUrlString stringByAppendingPathComponent:@"article"] parameters:nil success:^(NSDictionary *responseObject) {
		
		if (![responseObject[@"list"] count]) {
			VALog(@"Nothing here.");
			
		}
		else {
			
			for (NSDictionary *subjectDir in responseObject[@"list"]) {
				
				[VAUserArticleSubject MR_importFromObject:subjectDir];
			}
			
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAUserArticleSubject MR_requestAllSortedBy:nil ascending:YES];
	
	return fetchRequest;
}

#pragma mark - table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_ARTICLE_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(VAUserArticleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	[cell loadCellWithModel:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return USER_ARTICLE_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

@end
