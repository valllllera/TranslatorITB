//
//  ViewController.h
//  TranslatorItbFirst
//
//  Created by Андрей on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverlayCameraView;

@interface CustomCameraController : UIImagePickerController

@property (copy, nonatomic) void (^dissmisBlock)();

@property (strong, nonatomic) OverlayCameraView *overlayView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;


@end
