//
//  VAUserCollectionViewController.m
//  Valley
//
//  Created by V on 21/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAUserCollectionViewController.h"
#import "VAUserCollectionSubject.h"
#import "VAUserCollectionViewCell.h"

@interface VAUserCollectionViewController ()

@property (nonatomic, strong) VAUserCollectionSubject *subject;

@end

@implementation VAUserCollectionViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.title = @"Collection";
	
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
	flowLayout.itemSize = CGSizeMake(USER_COLLECTION_ITEM_WIDTH_VIA_PERCENTAGE_OF_(collectionViewWidth),
									 USER_COLLECTION_ITEM_HEIGHT_VIA_PERCENTAGE_OF_(collectionViewWidth));
	flowLayout.sectionInset = VAEdgeInsetsMake(USER_COLLECTION_ITEM_EDGE_INSET_VIA_PERCENTAGE_OF_(collectionViewWidth));
	
	[self.collectionView setCollectionViewLayout:flowLayout];
	
	[self.collectionView registerNib:[UINib nibWithNibName:USER_COLLECTION_CELL bundle:nil] forCellWithReuseIdentifier:USER_COLLECTION_CELL];

	[VAUserCollectionSubject MR_truncateAll];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:[self.userUrlString stringByAppendingPathComponent:@"collection"] parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VAUserCollectionSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
//			[VAUserCollectionSubject MR_importFromObject:subjectDir];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
	
}

- (NSFetchRequest *)fetchRequest {
	
	NSFetchRequest *fetchRequest = [VAUserCollectionSubject MR_requestAllSortedBy:nil ascending:YES];
	
	return fetchRequest;
}

#pragma mark - collection view delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:USER_COLLECTION_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(VAUserCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	[cell loadCellWithModel:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	VAUserCollectionSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	
}

@end
