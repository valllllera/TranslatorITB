//
//  Order.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 26.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Order : NSManagedObject

@property (nonatomic, strong) NSNumber * cost;
@property (nonatomic, strong) NSNumber * duration;
@property (nonatomic, strong) NSDate * finishDate;
@property (nonatomic, strong) NSNumber * infoType;
@property (nonatomic, copy) NSString * langFrom;
@property (nonatomic, copy) NSString * langTo;
@property (nonatomic, strong) NSNumber * order_id;
@property (nonatomic, strong) NSNumber * orderType;
@property (nonatomic, strong) NSDate * startDate;
@property (nonatomic, strong) NSNumber * status;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) NSData * images;
@property (nonatomic, strong) NSNumber * robokassaIdx;

@end
