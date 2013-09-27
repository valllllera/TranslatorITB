//
//  VDSendMailViewController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 27.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>

@interface VDSendMailViewController : MFMailComposeViewController <MFMailComposeViewControllerDelegate>

-(void)EmailAction;

@end
