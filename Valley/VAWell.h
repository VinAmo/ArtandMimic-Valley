//
//  VAWell.h
//
//
//  Created by V on 09/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAWell : NSObject

+ (instancetype)well;

// clue for improper use (produces compile time error)
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance instead")));

#pragma mark - fetch methods

- (void)reachabilityStatusIsReachable:(void (^)())reachable
						 notReachable:(void (^)())notReachable;

- (void)reachabilityStatusIsUnknown:(void (^)())unknown
					   notReachable:(void (^)())notReachable
				   reachableViaWWAN:(void (^)())reachableViaWWAN
				   reachableviaWiFi:(void (^)())reachableViaWiFi;

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
	success:(void (^)(id responseObject))success
	failure:(void (^)(NSError *error))failure;

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
	success:(void (^)(id responseObject))success
	failure:(void (^)(NSError *))failure;

- (void)HEAD:(NSString *)URLString
  parameters:(id)parameters
	 success:(void (^)())success
	 failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
	 success:(void (^)(id responseObject))success
	 failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
	progress:(void (^)(NSProgress *))progress
	 success:(void (^)(id responseObject))success
	 failure:(void (^)(NSError *))failure;

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id))block
	progress:(void (^)(NSProgress *))progress
	 success:(void (^)(id responseObject))success
	 failure:(void (^)(NSError *))failure;

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
	success:(void (^)(id responseObject))success
	failure:(void (^)(NSError *error))failure;

- (void)PATCH:(NSString *)URLString
   parameters:(id)parameters
	  success:(void (^)(id responseObject))success
	  failure:(void (^)(NSError *error))failure;

- (void)DELETE:(NSString *)URLString
	parameters:(id)parameters
	   success:(void (^)(id responseObject))success
	   failure:(void (^)(NSError *error))failure;

@end
