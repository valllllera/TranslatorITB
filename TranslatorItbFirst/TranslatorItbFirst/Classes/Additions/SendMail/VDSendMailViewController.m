//
//  VDSendMailViewController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 27.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDSendMailViewController.h"

@interface VDSendMailViewController ()

@end

@implementation VDSendMailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)EmailAction{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"My Subject"];
        [controller setMessageBody:@"Hello there." isHTML:NO];
        [controller setToRecipients:[NSArray arrayWithObjects: @"zhr0n4x@mail.ru", nil]];
        if (controller) [self presentModalViewController:controller animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end