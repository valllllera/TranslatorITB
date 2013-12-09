//
//  ETRobokassa.h
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 19.10.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETRobokassa : NSObject

+ (NSString *)robokassaUrlWithLogin:(NSString *)login
                           password:(NSString *)password
                                sum:(NSNumber *)sum
                              email:(NSString *)email
                                idx:(NSNumber *)idx
                        description:(NSString *)description;

@end
