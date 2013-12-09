//
//  ETRobokassa.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 19.10.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ETRobokassa.h"
#import "NSString+VDExtensions.h"

static NSString *robokassaBaseUrl = @"https://merchant.roboxchange.com/Index.aspx";

@implementation ETRobokassa

+ (NSString *)robokassaUrlWithLogin:(NSString *)login
                           password:(NSString *)password
                                sum:(NSNumber *)sum
                              email:(NSString *)email
                                idx:(NSNumber *)idx
                        description:(NSString *)description
{
    NSAssert([login length], @"Robokassa: need current login!");
    NSAssert([password length], @"Robokassa: need current password!");
    NSAssert([sum floatValue] >= 0, @"Robokassa: need current sum!");
    
    if(!idx || [idx integerValue] < 0)
    {
        idx = @(0);
    }
    
    NSString *sumString = [[[NSString stringWithFormat:@"%.2f", [sum floatValue]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    
    NSString *hash = [[NSString stringWithFormat:@"%@:%@:%@:%@", login, sumString, idx, password] MD5Hash];
    
    NSMutableString *url = [NSMutableString string];
    
    [url appendFormat:@"%@?MrchLogin=%@&OutSum=%@&InvId=%@&SignatureValue=%@", robokassaBaseUrl, login, sumString, idx, hash];
    if([email length] > 0)
    {
        [url appendFormat:@"&Email=%@", email];
    }
    
    if([description length] > 0)
    {
        [url appendFormat:@"&Desc=%@", description];
    }
    
    return url;
}

@end
