//
//  AppConsts.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 07.05.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AppConsts.h"

@implementation AppConsts

+ (NSString *)serverEmail
{
    return @"noreply@itbfirst.ru";
}

+ (NSString *)serverEmailPass
{
    return @"gjkbvth001";
}

+ (NSString *)smtpHost
{
    return @"smtp.gmail.com";
}

+ (NSString *)serverEmailToTranslate
{
    return @"robot@itbfirst.ru";
}

+ (NSString *)robokassaLogin
{
    return @"vitalych";
}

+ (NSString *)robokassaPass
{
    return @"Omen10Mustdie";
}

+ (NSString *)chatUrl
{
    return @"https://siteheart.com/webconsultation/636954";
}

+ (NSString *)serverApiBaseUrl
{
    return @"http://www.itbfirst.ru/";
}

+ (NSString *)checkPaidPath
{
    return @"/appitb/check_order.php";
}

@end
