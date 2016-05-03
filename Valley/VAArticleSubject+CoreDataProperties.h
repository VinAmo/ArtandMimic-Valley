//
//  VAArticleSubject+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAArticleSubject.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAArticleSubject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *articleID;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *createIP;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *isBlock;
@property (nullable, nonatomic, retain) NSString *isDel;
@property (nullable, nonatomic, retain) NSNumber *isLiked;
@property (nullable, nonatomic, retain) NSNumber *isOwner;
@property (nullable, nonatomic, retain) NSString *isShowFeed;
@property (nullable, nonatomic, retain) NSString *isShowHome;
@property (nullable, nonatomic, retain) NSString *mtime;
@property (nullable, nonatomic, retain) NSString *numComment;
@property (nullable, nonatomic, retain) NSString *numLiked;
@property (nullable, nonatomic, retain) NSString *numView;
@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *rowType;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *subtitle;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSString *version;
@property (nullable, nonatomic, retain) NSSet<VAUser *> *liked;
@property (nullable, nonatomic, retain) NSSet<VATag *> *tags;
@property (nullable, nonatomic, retain) VAUser *user;

@end

@interface VAArticleSubject (CoreDataGeneratedAccessors)

- (void)addLikedObject:(VAUser *)value;
- (void)removeLikedObject:(VAUser *)value;
- (void)addLiked:(NSSet<VAUser *> *)values;
- (void)removeLiked:(NSSet<VAUser *> *)values;

- (void)addTagsObject:(VATag *)value;
- (void)removeTagsObject:(VATag *)value;
- (void)addTags:(NSSet<VATag *> *)values;
- (void)removeTags:(NSSet<VATag *> *)values;

@end

NS_ASSUME_NONNULL_END
