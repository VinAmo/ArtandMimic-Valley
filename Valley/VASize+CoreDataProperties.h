//
//  VASize+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VASize.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASize (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *l;
@property (nullable, nonatomic, retain) NSNumber *rl;
@property (nullable, nonatomic, retain) NSNumber *rw;
@property (nullable, nonatomic, retain) NSString *sizeID;
@property (nullable, nonatomic, retain) NSNumber *w;
@property (nullable, nonatomic, retain) VAWork *art;

@end

NS_ASSUME_NONNULL_END
