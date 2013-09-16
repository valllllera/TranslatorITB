//
//  RightBasketViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDataBase.h"
#import "YourOrder.h"
#import "IIViewDeckController.h"
#import "DataManager.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "User.h"

@interface RightBasketViewController : UIViewController <UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *fioLbl;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *propertiesBtn;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (nonatomic, strong) NSArray *orders;

- (IBAction)exit:(id)sender;
- (IBAction)opernProperties:(id)sender;

@end
