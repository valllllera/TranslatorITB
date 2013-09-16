//
//  YourOrder.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 29.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDataBase.h"
#import "DataManager.h"
#import "NSDate+VDExtensions.h"

@interface YourOrder : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *orderStatusImage;
@property (assign, nonatomic) int currentOrderIndex;
-(IBAction)goToPayment:(id)sender;
@property (strong, nonatomic) UILabel *orderPriceAndTerm;
@property (strong, nonatomic) UIButton *payButton;

@end
