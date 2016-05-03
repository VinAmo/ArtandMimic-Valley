//
//  VAPicture+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAPicture.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAPicture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bj;
@property (nullable, nonatomic, retain) NSNumber *h;
@property (nullable, nonatomic, retain) NSString *pictureID;
@property (nullable, nonatomic, retain) NSNumber *w;
@property (nullable, nonatomic, retain) VAWork *art;

@end

NS_ASSUME_NONNULL_END
