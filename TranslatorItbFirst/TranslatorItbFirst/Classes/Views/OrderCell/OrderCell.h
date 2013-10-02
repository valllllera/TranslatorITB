//
//  OrderCell.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDataBase.h"
#import "DataManager.h"

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UIImageView *openOrderIamge;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

-(IBAction)openOrder:(id)sender;
-(void)initSelfFromOrder:(Order *)order;

@end
