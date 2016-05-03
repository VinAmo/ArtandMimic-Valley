//
//  VATableViewController.h
//
//
//  Created by V on 15/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VATableViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

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
 *  configure cell
 *
 *  @param tableView the table view you use
 *  @param indexPath the index path of the row
 *
 *  @return the cell you want to set up
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  configure cell with what you want
 *
 *  @param cell      the cell you want
 *  @param indexPath the position of the cell
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 *  set up table view height
 *
 *  @param tableView the table view you use
 *  @param indexPath the index path of the row
 *
 *  @return the height you want to set
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Called after the user changes the selection.
 *
 *  @param tableView the table view you use
 *  @param indexPath the index path of the row you select
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

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
