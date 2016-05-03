//
//  VATag+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VATag.h"

NS_ASSUME_NONNULL_BEGIN

@interface VATag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagID;
@property (nullable, nonatomic, retain) VAArticleSubject *article;

@end

NS_ASSUME_NONNULL_END
