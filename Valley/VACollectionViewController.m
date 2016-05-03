//
//  VACollectionViewController.m
//  Valley
//
//  Created by V on 19/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VACollectionViewController.h"

@interface VACollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) NSMutableArray *sectionChanges;
@property (nonatomic, copy) NSMutableArray *itemChanges;

@end

@implementation VACollectionViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, VESSEL_VIEW_HEIGHT);
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
	self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:COLLECTION_CELL];
	
	self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		[self loadData];
	}];
	
	[self loadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
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
				
				[self.collectionView reloadData];
				[self.collectionView.mj_header endRefreshing];
			}
			
			
		} failure:^(NSError *error) {
			
			[[VAVictim victim] alertWithTitle:@"Request error"
									  message:[error localizedDescription]
								 cancelAction:@"OK"
									  handler:^(UIAlertAction * _Nullable action) {
										  
										  VALogSelector;
										  
									  } completion:^{
										  
										  [self.collectionView.mj_header endRefreshing];
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
									  
									  [self.collectionView.mj_header endRefreshing];
									  
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


#pragma mark - collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [[self.fetchedResultsController sections][section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL forIndexPath:indexPath];
	
	[self configureCell:cell atIndexPath:indexPath];
	
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	
}

#pragma mark - fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	
	_sectionChanges = [[NSMutableArray alloc] init];
	_itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type {
	
	NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
	change[@(type)] = @(sectionIndex);
	
	[self.sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
	
	switch (type) {
		case NSFetchedResultsChangeDelete:
			change[@(type)] = indexPath;
			break;
			
		case NSFetchedResultsChangeInsert:
			change[@(type)] = newIndexPath;
			break;
			
		case NSFetchedResultsChangeMove:
			change[@(type)] = @[ indexPath, newIndexPath ];
			break;
			
		case NSFetchedResultsChangeUpdate:
			change[@(type)] = indexPath;
			break;
			
		default:
			break;
	}
	
	[self.itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	
	[self.collectionView performBatchUpdates:^{
		
		for (NSDictionary *change in self.sectionChanges) {
			
			[change enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				
				NSFetchedResultsChangeType type = [key unsignedIntegerValue];
				switch (type) {
					case NSFetchedResultsChangeDelete:
						[self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
						break;
						
					case NSFetchedResultsChangeInsert:
						[self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
					
					default:
						break;
				}
			}];
		}
		
		for (NSDictionary *change in self.itemChanges) {
			
			[change enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				
				NSFetchedResultsChangeType type = [key unsignedIntegerValue];
				switch (type) {
					case NSFetchedResultsChangeDelete:
						[self.collectionView deleteItemsAtIndexPaths:@[ obj ]];
						break;
						
					case NSFetchedResultsChangeInsert:
						[self.collectionView insertItemsAtIndexPaths:@[ obj ]];
						break;
						
					case NSFetchedResultsChangeMove:
						[self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
						break;
					
					case NSFetchedResultsChangeUpdate:
						[self.collectionView reloadItemsAtIndexPaths:@[ obj ]];
						break;
						
					default:
						break;
				}
				
			}];
		}
		
	} completion:^(BOOL finished) {
		
		self.sectionChanges = nil;
		self.itemChanges = nil;
		
	}];
}

@end
