//
//  AppConsts.h
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 07.05.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RootViewController [[[[UIApplication sharedApplication] delegate] window] rootViewController]

@interface AppConsts : NSObject

+ (NSString *)serverEmail;

+ (NSString *)serverEmailPass;

+ (NSString *)smtpHost;

+ (NSString *)serverEmailToTranslate;

@end
