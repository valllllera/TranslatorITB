//
//  OverlayCameraView.h
//  TranslatorItbFirst
//
//  Created by Андрей on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverlayCameraView : UIView

@property (copy, nonatomic) void (^backButtonPressedBlock)();

- (IBAction)backButtonPressed:(id)sender;

@end
