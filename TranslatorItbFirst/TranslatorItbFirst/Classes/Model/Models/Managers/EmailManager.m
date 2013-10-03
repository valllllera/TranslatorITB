//
//  EmailManager.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 07.05.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "EmailManager.h"
#import "NSData+Base64Additions.h"
#import "Reachability.h"

@interface EmailManager ()

@property (strong, nonatomic) void (^success)();
@property (strong, nonatomic) void (^failture)();

@end

@implementation EmailManager

#pragma mark - Singleton

static EmailManager *sharedInstance = nil;

+ (EmailManager *)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[EmailManager alloc] init];
        }
    }
    return sharedInstance;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

#pragma mark - Public

- (void)sendMessageWithFromEmail:(NSString *)fromEmail
                     withToEmail:(NSString *)toEmail
                    withSMTPHost:(NSString *)smtpHost
                   withSMTPLogin:(NSString *)smtpLogin
                    withSMTPPass:(NSString *)smtpPass
                     withSubject:(NSString *)subject
                        withBody:(NSString *)body
             withAttachFiledatas:(NSArray *)filedatas
                    withFileType:(NSString *)type
                     withSuccess:(void (^)())success
                    withFailture:(void (^)())failture
{
    NSAssert(fromEmail, @"Not from email!");
    NSAssert(toEmail, @"Not to email!");
    NSAssert(smtpHost, @"Not smtp host!");
    NSAssert(smtpLogin, @"Not smtp login!");
    NSAssert(smtpPass, @"Not smtp password!");
    
    _success = success;
    _failture = failture;
    
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reachability.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [reach stopNotifier];
            
            SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
            emailMessage.fromEmail = fromEmail;
            emailMessage.toEmail = toEmail;
            emailMessage.relayHost = smtpHost;
            emailMessage.requiresAuth = YES;
            emailMessage.login = smtpLogin;
            emailMessage.pass = smtpPass;
            emailMessage.subject = subject;
            emailMessage.wantsSecure = YES;
            emailMessage.delegate = self;
            NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html", kSKPSMTPPartContentTypeKey, body, kSKPSMTPPartMessageKey, @"8bit",kSKPSMTPPartContentTransferEncodingKey, nil];
            if(filedatas)
            {
                NSMutableArray *parts = [NSMutableArray arrayWithObject:plainMsg];
                for(NSData *filedata in filedatas)
                {
                    NSString *filename = [NSString stringWithFormat:@"file_%d.%@", [filedatas indexOfObject:filedata], type];
                    NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"%@\"", filename], kSKPSMTPPartContentTypeKey, [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"%@\"", filename], kSKPSMTPPartContentDispositionKey, [filedata encodeBase64ForData], kSKPSMTPPartMessageKey, @"base64", kSKPSMTPPartContentTransferEncodingKey,nil];
                    [parts addObject:fileMsg];
                }
                emailMessage.parts = parts;
            }
            else
            {
                emailMessage.parts = [NSArray arrayWithObject:plainMsg];
            }
            
            [emailMessage send];
            
        });
    };
    
    reachability.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [reach stopNotifier];
            
            if(_failture)
            {
                _failture();
            }
            
        });
    };
    
    [reachability startNotifier];
}

#pragma mark - Private

#pragma mark - @protocol(SKPSMTPMessageDelegate)

- (void)messageSent:(SKPSMTPMessage *)message
{
    if(_success)
    {
        _success();
    }
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    if(_failture)
    {
        _failture();
    }    
}

@end
