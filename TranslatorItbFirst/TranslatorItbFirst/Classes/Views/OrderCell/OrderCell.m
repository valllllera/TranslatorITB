//
//  OrderCell.m
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)awakeFromNib
{
    UIImageView* background=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"orderCellBackground" ]];
    [self setBackgroundView:background];
}

- (IBAction)openOrder:(id)sender {
    
}

/*-(void)initSelfFromOrder:(Order*)order{
   
    [_costLbl setText:[NSString stringWithFormat:@"%d",order.cost ]];
    [_orderIdLbl setText:[NSString stringWithFormat:@"%d",order.id]];
    
    if(order.status==1)
        [_statusImg setImage:[UIImage imageNamed:@"check"]];
    
    else if(order.status==2)
        [_statusImg setImage:[UIImage imageNamed:@"clock"]];
    
    else 
        [_statusImg setImage:[UIImage imageNamed:@"bag"]];
    
}*/

@end
