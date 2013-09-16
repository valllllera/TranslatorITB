//
//  UploadFileViewController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 05.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//
#define FtpUrl @"mlb.ftp.ukraine.com.ua/TranslatorTest"
#define FtpLogin @"mlb_ftp"
#define FtpPassword @"v16071997"

#import <UIKit/UIKit.h>

@interface UploadFileViewController : UIViewController

@property (nonatomic, retain) NSMutableData *infoData;
- (IBAction)uploadFileActionButton:(id)sender;

@end
