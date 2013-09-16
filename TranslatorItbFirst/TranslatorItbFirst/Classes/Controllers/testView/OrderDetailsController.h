//
//  OrderDetailsController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+VDExtensions.h"
#import "UploadFileController.h"
#import "PayDetailsController.h"
#import "PhotoViewController.h"
#import "IXPickerOverlayView.h"
#import "OrderDataBase.h"
#import "DataManager.h"

@interface OrderDetailsController : UIViewController<UITextFieldDelegate,UITextViewDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
    UploadFileViewController * uploadFileController;
    PayDetailsController * payDetailController;
    PhotoViewController * photoViewController;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgr;

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *orLbl;
@property(nonatomic,strong) UIButton *pickFromBtn;
@property(nonatomic,strong) UIButton *pickToBtn;

@property(nonatomic,strong) IBOutlet UITextView *text;

@property(nonatomic,strong) IBOutlet UITextField *from;
@property(nonatomic,strong) IBOutlet UITextField *to;

@property (assign, nonatomic) int infoType;
@property (assign, nonatomic) int orderIndex;


@property(nonatomic,strong) IBOutlet UIButton *getPrice;
@property(nonatomic,strong) IBOutlet UIButton *changeLanguage;
@property (weak, nonatomic) IBOutlet UIButton *getPhoto;

@property (strong, nonatomic) NSArray * languages;

@property (weak, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (weak, nonatomic) IBOutlet IXPickerOverlayView *languagePickerOverlayView;

@property (assign, nonatomic) int photoCount;

- (IBAction)done:(id)sender;

- (BOOL)chekLanguageFrom:(NSString*)from To:(NSString*)to;

-(IBAction)ShowListFrom:(id)sender;
-(IBAction)ShowListTo:(id)sender;
-(IBAction)changeLanguage:(id)sender;
- (IBAction)touchGetPriceBtn:(id)sender;
- (IBAction)touchGetPhoto:(id)sender;

- (int) getPricePerPage;


@end
