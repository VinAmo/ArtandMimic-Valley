//
//  VAUserCollectionSubject+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAUserCollectionSubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAUserCollectionSubject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *atime;
@property (nullable, nonatomic, retain) NSString *coverID;
@property (nullable, nonatomic, retain) NSString *isDel;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *numWork;
@property (nullable, nonatomic, retain) NSString *sort;
@property (nullable, nonatomic, retain) NSString *subjectID;

@end

NS_ASSUME_NONNULL_END
