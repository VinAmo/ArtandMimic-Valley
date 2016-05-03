//
//  VAArtistSubject+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAArtistSubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAArtistSubject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *subjectID;
@property (nullable, nonatomic, retain) VAUser *user;
@property (nullable, nonatomic, retain) NSSet<VAWork *> *works;

@end

@interface VAArtistSubject (CoreDataGeneratedAccessors)

- (void)addWorksObject:(VAWork *)value;
- (void)removeWorksObject:(VAWork *)value;
- (void)addWorks:(NSSet<VAWork *> *)values;
- (void)removeWorks:(NSSet<VAWork *> *)values;

@end

NS_ASSUME_NONNULL_END
