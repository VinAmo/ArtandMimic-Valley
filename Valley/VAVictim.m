//
//  VAVictim.m
//  Valley
//
//  Created by V on 31/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#import "VAVictim.h"

@implementation VAVictim

+ (instancetype)victim {
	
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

#pragma mark - discipline methods

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper {
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:masochism
																			 message:corporal
																	  preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addAction:[UIAlertAction actionWithTitle:orgasmDenial
														style:UIAlertActionStyleCancel
													  handler:^(UIAlertAction * _Nonnull action) {
														  odSadism(action);
													  }]];
	
	[kidnapper presentViewController:alertController animated:YES completion:^{
		completion();
	}];
}

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
		 defaultAction:(nullable NSString *)orgasmControl
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ocSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper {
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:masochism
																			 message:corporal
																	  preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addAction:[UIAlertAction actionWithTitle:orgasmDenial
														style:UIAlertActionStyleCancel
													  handler:^(UIAlertAction * _Nonnull action) {
														  odSadism(action);
													  }]];
	
	[alertController addAction:[UIAlertAction actionWithTitle:orgasmControl
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction * _Nonnull action) {
														  ocSadism(action);
													  }]];
	
	[kidnapper presentViewController:alertController animated:YES completion:^{
		completion();
	}];
}

- (void)alertWithTitle:(nullable NSString *)masochism
			   message:(nullable NSString *)corporal
		  cancelAction:(nullable NSString *)orgasmDenial
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))odSadism
		 defaultAction:(nullable NSString *)orgasmControl
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ocSadism
	 destructiveAction:(nullable NSString *)ejaculation
			   handler:(void (^ __nullable)(UIAlertAction * __nullable action))ejSadism
			completion:(void (^ __nullable)(void))completion
				   via:(nonnull UIViewController *)kidnapper {
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:masochism
																			 message:corporal
																	  preferredStyle:UIAlertControllerStyleAlert];
	
	[alertController addAction:[UIAlertAction actionWithTitle:orgasmDenial
														style:UIAlertActionStyleCancel
													  handler:^(UIAlertAction * _Nonnull action) {
														  odSadism(action);
													  }]];
	
	[alertController addAction:[UIAlertAction actionWithTitle:orgasmControl
														style:UIAlertActionStyleDefault
													  handler:^(UIAlertAction * _Nonnull action) {
														  ocSadism(action);
													  }]];
	
	[alertController addAction:[UIAlertAction actionWithTitle:ejaculation
														style:UIAlertActionStyleDestructive
													  handler:^(UIAlertAction * _Nonnull action) {
														  ejSadism(action);
													  }]];
	
//	[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//		textField.font = [UIFont fontWithName:@"AvenirNext-Medium" size:textField.font.pointSize];
//	}];
	
	[kidnapper presentViewController:alertController animated:YES completion:^{
		completion();
	}];
}

@end
