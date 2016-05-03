//
//  VACollectionViewController.h
//  Valley
//
//  Created by V on 19/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VACollectionViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


/**
 *  load data from service
 */
- (void)loadData;

/**
 *  lazy create fetch request
 *
 *  @return fetchRequest
 */
- (NSFetchRequest *)fetchRequest;

/**
 *  configure collection view cell
 *
 *  @param collectionView the collection view you use
 *  @param indexPath      the index path of the item
 *
 *  @return the cell you want to set up
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  configure cell with what you want
 *
 *  @param cell      the cell you want
 *  @param indexPath the position of the cell
 */
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Called after the user changes the selection.
 *
 *  @param collectionView the collection view you use
 *  @param indexPath      the index paht of the item
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  acquire data from service
 *
 *  @param urlString  the destination
 *  @param parameters the request parameters
 *  @param success    use the data after succeeding
 *  @param failure    handle the error after failing
 */
- (void)acquireDataWithURLString:(NSString *)urlString
					  parameters:(NSDictionary *)parameters
						 success:(void (^)(NSDictionary *responseObject))success
						 failure:(void (^)(NSError *error))failure;

@end
