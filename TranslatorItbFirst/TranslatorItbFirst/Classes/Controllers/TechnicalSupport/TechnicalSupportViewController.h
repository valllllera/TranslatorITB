//
//  TechnicalSupportViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 03.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TechnicalSupportViewController : UIViewController <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *textViewBackgroundImage;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)resignFirst:(id)sender;

@end
