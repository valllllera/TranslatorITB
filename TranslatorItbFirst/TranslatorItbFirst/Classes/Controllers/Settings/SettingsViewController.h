//
//  SettingsViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 05.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SettingsViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userFioLbl;
@property (weak, nonatomic) IBOutlet UITextField *fioTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTExtField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *blinkLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
- (IBAction)touchSaveBtn:(id)sender;


@end
