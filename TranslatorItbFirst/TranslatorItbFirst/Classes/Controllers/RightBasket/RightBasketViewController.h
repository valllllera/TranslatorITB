//
//  RightBasketViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "YourOrder.h"
#import "IIViewDeckController.h"

@interface RightBasketViewController : UIViewController <UITableViewDelegate>{
    NSMutableArray * orders;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *fioLbl;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *propertiesBtn;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

- (IBAction)exit:(id)sender;
- (IBAction)opernProperties:(id)sender;

@end
