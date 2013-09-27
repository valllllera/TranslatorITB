//
//  InitialViewController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 21.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsController.h"
#import "RightBasketViewController.h"
#import "SettingsViewController.h"
#import "PhotoTest.h"

@class SettingsViewController;
@interface HomeViewController : UIViewController
{
    OrderDetailsController * orderDetailsController;
    SettingsViewController * settingsViewController;
}
- (IBAction)goToOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *text;

@end
