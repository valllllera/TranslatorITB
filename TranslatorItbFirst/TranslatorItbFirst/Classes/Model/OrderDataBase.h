//
//  Order.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 03.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Order : NSManagedObject

@property (nonatomic, retain) NSNumber * order_id;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * finishDate;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * infoType;
@property (nonatomic, retain) NSNumber * orderType;
@property (nonatomic, retain) NSString * langTo;
@property (nonatomic, retain) NSString * langFrom;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * pricePerPage;

@end
