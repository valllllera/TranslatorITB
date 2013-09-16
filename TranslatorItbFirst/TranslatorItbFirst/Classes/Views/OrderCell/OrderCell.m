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

-(void)initSelfFromOrder:(int)orderIndex{
    
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *orders;
    orders = [context executeFetchRequest:fetchRequest error:&error];
    Order *order = [orders objectAtIndex:orderIndex];
   
    [_costLbl setText:[NSString stringWithFormat:@"%.2f",[order.cost floatValue]]];
    [_orderIdLbl setText:[NSString stringWithFormat:@"%d",[order.order_id intValue]]];
    [_dateLbl setText:[NSString stringWithFormat:@"%d мин.", [order.duration intValue]]];
    
    if([order.status intValue]==1)
        [_statusImg setImage:[UIImage imageNamed:@"check"]];
    
    else if([order.status intValue]==2)
        [_statusImg setImage:[UIImage imageNamed:@"clock"]];
    
    else 
        [_statusImg setImage:[UIImage imageNamed:@"bag"]];
    
}

@end
