//
//  ServerManager.h
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 10.11.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (ServerManager *)sharedInstance;

- (void)checkOrderWithIdx:(NSNumber *)idx withSuccess:(void (^)(BOOL isPaid))success failure:(void (^)(NSError *error))failure;

@end
