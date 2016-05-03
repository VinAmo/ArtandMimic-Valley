//
//  VAUser+CoreDataProperties.h
//  Valley
//
//  Created by V on 25/12/2015.
//  Copyright © 2015 V. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VAUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *cover;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *domain;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *isArtist;
@property (nullable, nonatomic, retain) NSString *isCollect;
@property (nullable, nonatomic, retain) NSString *isDel;
@property (nullable, nonatomic, retain) NSString *isFollow;
@property (nullable, nonatomic, retain) NSString *isKill;
@property (nullable, nonatomic, retain) NSString *isOpenLiked;
@property (nullable, nonatomic, retain) NSString *isVerify;
@property (nullable, nonatomic, retain) NSNumber *numAbout;
@property (nullable, nonatomic, retain) NSNumber *numFollowed;
@property (nullable, nonatomic, retain) NSNumber *numLiked;
@property (nullable, nonatomic, retain) NSNumber *numWork;
@property (nullable, nonatomic, retain) NSString *resume;
@property (nullable, nonatomic, retain) NSString *role;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *uname;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSString *version;
@property (nullable, nonatomic, retain) VAWork *art;
@property (nullable, nonatomic, retain) VAArticleSubject *article;
@property (nullable, nonatomic, retain) VAArtistSubject *artistSubject;
@property (nullable, nonatomic, retain) VAWork *likedArt;
@property (nullable, nonatomic, retain) VAArticleSubject *likedArticle;

@end

NS_ASSUME_NONNULL_END
