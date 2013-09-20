//
//  PhotoViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"

@interface PhotoView : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)back:(id)sender;




@end
