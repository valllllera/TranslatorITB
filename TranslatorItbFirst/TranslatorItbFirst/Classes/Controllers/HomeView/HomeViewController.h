//
//  InitialViewController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 21.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsController.h"

@interface HomeViewController : UIViewController
{
    OrderDetailsController * orderDetailsController;
}
- (IBAction)goToOrder:(id)sender;

@end
