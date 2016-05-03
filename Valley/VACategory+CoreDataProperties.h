//
//  VACategory+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VACategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface VACategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *categoryID;
@property (nullable, nonatomic, retain) NSString *isThree;
@property (nullable, nonatomic, retain) VAWork *art;

@end

NS_ASSUME_NONNULL_END
