//
//  ViewController.m
//  TranslatorItbFirst
//
//  Created by Андрей on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "CustomCameraController.h"
#import "OverlayCameraView.h"

@interface CustomCameraController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CustomCameraController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.overlayView = [[NSBundle mainBundle] loadNibNamed:@"OverlayCameraView" owner:nil options:nil][0];
    self.overlayView.frame = CGRectMake(0, 383, 320, 97);
    
    __weak CustomCameraController *selfWeak = self;
    
    [self.overlayView setBackButtonPressedBlock:^{
      
        if(selfWeak.dissmisBlock)
        {
            selfWeak.dissmisBlock();
        }
        
    }];
    [self.overlayView setGetPhotoButtonPressedBlock:^{
        
        if(selfWeak.dissmisBlock)
        {
            selfWeak.dissmisBlock();
        }
    }];
    [self.overlayView setShowGalleryButtonPressedBlock:^{
        
        if(selfWeak.dissmisBlock)
        {
            selfWeak.dissmisBlock();
        }
        
    }];
    
    NSLog(@"%@", self.view.subviews);
    [self.view addSubview:self.overlayView];
    
   // self.cameraOverlayView=self.view;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


@end
