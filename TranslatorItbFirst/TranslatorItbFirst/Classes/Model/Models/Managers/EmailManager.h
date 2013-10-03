//
//  EmailManager.h
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 07.05.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKPSMTPMessage.h"

@interface EmailManager : NSObject <SKPSMTPMessageDelegate, UIAlertViewDelegate>

+ (EmailManager *)sharedInstance;

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
                    withFailture:(void (^)())failture;

@end
