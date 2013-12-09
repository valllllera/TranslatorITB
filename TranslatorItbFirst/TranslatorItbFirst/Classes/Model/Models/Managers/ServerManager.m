//
//  ServerManager.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 10.11.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "AppConsts.h"

@implementation ServerManager

#pragma mark - Singleton

static ServerManager *sharedInstance = nil;

+ (ServerManager *)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[ServerManager alloc] init];
        }
    }
    return sharedInstance;
}

- (void)checkOrderWithIdx:(NSNumber *)idx withSuccess:(void (^)(BOOL isPaid))success failure:(void (^)(NSError *error))failure
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:[AppConsts serverApiBaseUrl]]];
    
    NSDictionary *params = @{@"inv_id": idx};
    
    NSURLRequest *request = [client requestWithMethod:@"GET" path:[AppConsts checkPaidPath] parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *jsonDict = JSON;
        NSNumber *result = jsonDict[@"result"];
        if(success)
        {
            success([result boolValue]);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        if(failure)
        {
            failure(error);
        }
        
    }];
    [operation start];
}

@end
