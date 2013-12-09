//
//  NSString+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VDExtensions)

- (BOOL)containsString:(NSString *)string;
- (BOOL)startsWith:(NSString *)string;
- (BOOL)endsWith:(NSString *)string;

- (NSRange)fullRange;

- (NSString *)stringByTrimming;
- (NSString *)stringBySimpleStrippingTags;
- (NSString *)stringByTranslit;

- (NSInteger)indexOfCharacter:(unichar)ch;
- (NSInteger)indexOfCharacter:(unichar)ch fromIndex:(NSInteger)index;

- (NSString *)stringBetweenString:(NSString *)start andString:(NSString *)end;

- (BOOL)isEmail;
- (BOOL)isUrl;

- (NSString *)MD5Hash;
- (NSString *)SHA1Hash;
- (NSString *)HMACUsingSHA1_withSecretKey:(NSString *)secretKey;

- (NSString *)baseURL;
- (NSString *)hostURL;
- (NSString *)pathURL;
- (NSString *)fullURLWithPath:(NSString *)path;

@end
