//
//  VAVictim.h
//  Valley
//
//  Created by V on 31/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAVictim : NSObject

+ (instancetype)victim;

// clue for improper use (produces compile time error)
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance instead")));

#pragma mark - discipline methods

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper;

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
		 defaultAction:(nullable NSString *)orgasmControl
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ocSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper;

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
		 defaultAction:(nullable NSString *)orgasmControl
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ocSadism
	 destructiveAction:(nullable NSString *)ejaculation
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ejSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper;

@end
