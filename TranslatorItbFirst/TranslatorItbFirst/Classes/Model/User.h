//
//  User.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 10.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * username;

@end
