//
//  VAWork+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAWork.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAWork (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bj;
@property (nullable, nonatomic, retain) NSString *collectionID;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *goodsNum;
@property (nullable, nonatomic, retain) NSString *h;
@property (nullable, nonatomic, retain) NSString *height;
@property (nullable, nonatomic, retain) NSString *isBlock;
@property (nullable, nonatomic, retain) NSString *isBuyable;
@property (nullable, nonatomic, retain) NSString *isDel;
@property (nullable, nonatomic, retain) NSNumber *isLiked;
@property (nullable, nonatomic, retain) NSString *isOwner;
@property (nullable, nonatomic, retain) NSString *isSale;
@property (nullable, nonatomic, retain) NSString *isSecret;
@property (nullable, nonatomic, retain) NSString *isWaterMark;
@property (nullable, nonatomic, retain) NSString *level;
@property (nullable, nonatomic, retain) NSString *mailFee;
@property (nullable, nonatomic, retain) NSString *mark;
@property (nullable, nonatomic, retain) NSString *mtime;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *numComment;
@property (nullable, nonatomic, retain) NSString *numLiked;
@property (nullable, nonatomic, retain) NSString *numView;
@property (nullable, nonatomic, retain) NSString *ownerID;
@property (nullable, nonatomic, retain) NSString *pid;
@property (nullable, nonatomic, retain) NSString *preview;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *quality;
@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSString *rowType;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *tags;
@property (nullable, nonatomic, retain) NSString *times;
@property (nullable, nonatomic, retain) NSString *unit;
@property (nullable, nonatomic, retain) NSString *w;
@property (nullable, nonatomic, retain) NSString *width;
@property (nullable, nonatomic, retain) NSString *workID;
@property (nullable, nonatomic, retain) NSString *workType;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) VAArtistSubject *artistSubject;
@property (nullable, nonatomic, retain) VACategory *cate;
@property (nullable, nonatomic, retain) NSSet<VAUser *> *liked;
@property (nullable, nonatomic, retain) NSSet<VAPicture *> *pics;
@property (nullable, nonatomic, retain) VASize *size;
@property (nullable, nonatomic, retain) VAUser *user;

@end

@interface VAWork (CoreDataGeneratedAccessors)

- (void)addLikedObject:(VAUser *)value;
- (void)removeLikedObject:(VAUser *)value;
- (void)addLiked:(NSSet<VAUser *> *)values;
- (void)removeLiked:(NSSet<VAUser *> *)values;

- (void)addPicsObject:(VAPicture *)value;
- (void)removePicsObject:(VAPicture *)value;
- (void)addPics:(NSSet<VAPicture *> *)values;
- (void)removePics:(NSSet<VAPicture *> *)values;

@end

NS_ASSUME_NONNULL_END
