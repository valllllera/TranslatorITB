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
@property (copy, nonatomic) void (^getPhotoButtonPressedBlock)();
@property (copy, nonatomic) void (^showGalleryButtonPressedBlock)();

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)getPhotoButtonPressed:(id)sender;
- (IBAction)showGalleryButtonPressed:(id)sender;

@end
