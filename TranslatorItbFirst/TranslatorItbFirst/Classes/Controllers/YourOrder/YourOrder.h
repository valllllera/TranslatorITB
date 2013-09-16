//
//  YourOrder.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 29.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDataBase.h"

@interface YourOrder : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *orderStatusImage;
@property Order *currentOrder;

@end
