//
//  PhotoThumbController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoTest.h"

@class PhotoTest;

@interface PhotoThumb : UIView
- (IBAction)viewFullPhoto:(id)sender;
- (IBAction)removePhoto:(id)sender;

@property (assign, nonatomic) int index;
@property (retain, nonatomic) PhotoTest *photoTest;

@end
