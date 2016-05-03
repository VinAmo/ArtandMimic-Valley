//
//  VAWell.m
//
//
//  Created by V on 09/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAWell.h"

@implementation VAWell

+ (instancetype)well {
	
	static id shared = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		shared = [[super alloc] initUniqueInstance];
	});
	return shared;
}

- (instancetype)initUniqueInstance {
	
	return [super init];
}

#pragma mark - fetch methods

- (void)reachabilityStatusIsReachable:(void (^)())reachable
						 notReachable:(void (^)())notReachable {
	
	[self reachabilityStatusIsUnknown:^{
        notReachable();
	} notReachable:^{
        notReachable();
	} reachableViaWWAN:^{
        reachable();
	} reachableviaWiFi:^{
        reachable();
	}];
}

- (void)reachabilityStatusIsUnknown:(void (^)())unknown
					   notReachable:(void (^)())notReachable
				   reachableViaWWAN:(void (^)())reachableViaWWAN
				   reachableviaWiFi:(void (^)())reachableViaWiFi {
	
	AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
	[manager startMonitoring];
	
	[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		
		switch (status) {
			case AFNetworkReachabilityStatusNotReachable:
				notReachable();
                break;
			
			case AFNetworkReachabilityStatusReachableViaWWAN:
				reachableViaWWAN();
			    break;
			
			case AFNetworkReachabilityStatusReachableViaWiFi:
				reachableViaWiFi();
			    break;
				
			default:
				unknown();
			    break;
		}
		
	}];
	
}

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
	success:(void (^)(id responseObject))success
	failure:(void (^)(NSError *error))failure {
	
	[self GET:URLString
   parameters:parameters
	 progress:nil
	  success:success
	  failure:failure];
}

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
		
		if (progress) {
			progress(downloadProgress);
		}
		
	} success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
		
		if (success) {
			success(responseObject);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		if (failure) {
			failure(error);
		}
		
	}];
}

- (void)HEAD:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)())success
     failure:(void (^)(NSError *error))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
		
		if (success) {
			success();
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		if (failure) {
			failure(error);
		}
		
	}];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
	
	[self POST:URLString
	parameters:parameters
	  progress:nil
	   success:success
	   failure:failure];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))uploadProgress
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *))failure {
	
	[self POST:URLString
    parameters:parameters
constructingBodyWithBlock:nil
	  progress:uploadProgress
	   success:success
	   failure:failure];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id))block
    progress:(void (^)(NSProgress *))progress
	 success:(void (^)(id responseObject))success
	 failure:(void (^)(NSError *))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager POST:URLString
	   parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		   
		   if (block) {
			   block(formData);
		   }
		   
	   } progress:^(NSProgress * _Nonnull uploadProgress) {
		   
		   if (progress) {
			   progress(uploadProgress);
		   }
		   
	   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		   
		   if (success) {
			   success(responseObject);
		   }
		   
	   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		   
		   if (failure) {
			   failure(error);
		   }
	   }];
}

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager PUT:URLString
	  parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		  
		  if (success) {
			  success(responseObject);
		  }
		  
	  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		  
		  if (failure) {
			  failure(error);
		  }
		  
	  }];
}

- (void)PATCH:(NSString *)URLString
   parameters:(id)parameters
	  success:(void (^)(id responseObject))success
	  failure:(void (^)(NSError *error))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			success(responseObject);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		if (failure) {
			failure(error);
		}
		
	}];
}

- (void)DELETE:(NSString *)URLString
    parameters:(id)parameters
	   success:(void (^)(id responseObject))success
	   failure:(void (^)(NSError *error))failure {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		
		if (success) {
			success(responseObject);
		}
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
		if (failure) {
			failure(error);
		}
		
	}];
}

@end
