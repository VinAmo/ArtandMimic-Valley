//
//  VASaleViewController.m
//  Valley
//
//  Created by V on 17/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VASaleViewController.h"
#import "VASaleSubject.h"

#import "VAArtViewController.h"

@interface VASaleViewController ()

@end

@implementation VASaleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	self.title = @"Sale";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
    flowLayout.itemSize = VASizeMake(SALE_ITEM_HEIGHT_VIA_PERCENTAGE_OF_(collectionViewWidth));
    flowLayout.minimumInteritemSpacing = SALE_ITEM_SPACING_VIA_PERCENTAGE_OF_(collectionViewWidth);
    flowLayout.minimumLineSpacing = SALE_ITEM_SPACING_VIA_PERCENTAGE_OF_(collectionViewWidth);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SALE_CELL];
}

#pragma mark - Fountain methods

#pragma mark - basic methods

- (void)loadData {
	
	[self acquireDataWithURLString:SALE_URL_STRING parameters:nil success:^(NSDictionary *responseObject) {
		
		for (NSDictionary *subjectDir in responseObject[@"list"]) {
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				[VASaleSubject MR_importFromObject:subjectDir inContext:localContext];
				
			}];
		}
		
	} failure:^(NSError *error) {
		
		
		
	}];
	
}

- (NSFetchRequest *)fetchRequest {
    
    NSFetchRequest *fetchRequest = [VASaleSubject MR_requestAllSortedBy:@"mtime" ascending:YES];
    
    return fetchRequest;
}

#pragma mark - collection view delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SALE_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	VASaleSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
//	ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] initWithWebImage];
//	imageNode.frame = VASquareMake(0, 0, CGRectGetWidth(cell.bounds));
//	imageNode.contentMode = UIViewContentModeScaleAspectFill;
//	imageNode.clipsToBounds = YES;
//	imageNode.URL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:subject.pid]];
//	[cell.contentView addSubnode:imageNode];
	
	UIImageView *artRahmen = [[UIImageView alloc] initWithFrame:VASquareMake(0, 0, CGRectGetWidth(cell.bounds))];
	NSURL *workURL = [NSURL URLWithString:[WORK_URL_STRING stringByAppendingPathComponent:subject.pid]];
	[artRahmen sd_setImageWithURL:workURL placeholderImage:nil options:SDWebImageDownloaderLowPriority];
	[cell.contentView addSubview:artRahmen];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	VASaleSubject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	VAArtViewController *artViewController = [[VAArtViewController alloc] init];
	artViewController.artID = subject.workID;
	
	[self.navigationController pushViewController:artViewController animated:YES];
}

@end
