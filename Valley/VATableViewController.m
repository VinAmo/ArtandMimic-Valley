//
//  VATableViewController.m
//
//
//  Created by V on 15/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VATableViewController.h"

@interface VATableViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@end

@implementation VATableViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, VESSEL_VIEW_HEIGHT);
	self.tableView = [[UITableView alloc] initWithFrame:frame];
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.tableView.allowsSelection = NO;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self.view addSubview:self.tableView];
	
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLE_CELL];
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		[self loadData];
	}];
	 
	
//	[self loadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
	
	//self.view = nil;
	
    NSLog(@"%lu", (unsigned long)[[SDImageCache sharedImageCache] getSize]);
	
	[[[SDWebImageManager sharedManager] imageCache] clearMemory];
	[[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

#pragma mark - fountain methods

- (void)loadData {
	
    VAAssert;
}

- (void)acquireDataWithURLString:(NSString *)urlString
					  parameters:(NSDictionary *)parameters
						 success:(void (^)(NSDictionary *responseObject))success
						 failure:(void (^)(NSError *error))failure {
	
	[[VAWell well] reachabilityStatusIsReachable:^{
		
		[[VAWell well] POST:urlString parameters:parameters success:^(id responseObject) {
			
			if ([responseObject isKindOfClass:[NSDictionary class]]) {
				
				success(responseObject);
				
				[self.tableView reloadData];
				[self.tableView.mj_header endRefreshing];
			}
			
			
		} failure:^(NSError *error) {
			
			[[VAVictim victim] alertWithTitle:@"Request error"
									  message:[error localizedDescription]
								 cancelAction:@"OK"
									  handler:^(UIAlertAction * _Nullable action) {
										  
										  VALogSelector;
										  
									  } completion:^{
										  
										  [self.tableView.mj_header endRefreshing];
										  failure(error);
										  
									  } via:self];
			
		}];
		
	} notReachable:^{
		
		[[VAVictim victim] alertWithTitle:@"Connection error"
								  message:@"Network is not reachable."
							 cancelAction:@"OK"
								  handler:^(UIAlertAction * _Nullable action) {
									  
									  VALogSelector;
									  
								  } completion:^{
									  
									  [self.tableView.mj_header endRefreshing];
									  
								  } via:self];
		
	}];
}

- (NSFetchRequest *)fetchRequest {
	
    VAAssert;
	return nil;
}

#pragma mark - properties

- (NSFetchedResultsController *)fetchedResultsController {
	
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}
	
	_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest] managedObjectContext:[NSManagedObjectContext MR_defaultContext] sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
	
	NSError *error = nil;
	if (![_fetchedResultsController performFetch:&error]) {
        VALogError(error);
	}
	
	return _fetchedResultsController;
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [[self.fetchedResultsController sections][section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	VAAssert;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return DEFAULT_ROW_HEIGHT_VIA_PERCENTAGE_OF_(CGRectGetHeight(tableView.bounds));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
}

#pragma mark - fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type {
	
	switch (type) {
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		default:
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
}

@end
