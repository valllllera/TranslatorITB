//
//  OrderDetailsController.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+VDExtensions.h"
#import "PayDetailsController.h"
#import "IXPickerOverlayView.h"
#import "OrderDataBase.h"
#import "DataManager.h"
#import "PhotoThumb.h"

@interface OrderDetailsController : UIViewController<UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate> {
    
    PayDetailsController * payDetailController;
}

@property (strong, nonatomic) UIImageView *backgr;

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *orLbl;
@property(nonatomic,strong) UIButton *pickFromBtn;
@property(nonatomic,strong) UIButton *pickToBtn;

@property(nonatomic,strong) IBOutlet UITextView *text;

@property(nonatomic,strong) IBOutlet UITextField *from;
@property (weak, nonatomic) IBOutlet UIButton *fromBigButton;
@property(nonatomic,strong) IBOutlet UITextField *to;
@property (weak, nonatomic) IBOutlet UIButton *toBigButton;

@property (assign, nonatomic) int orderIndex;

//@property (strong, nonatomic) UIButton *doneButton;
@property (assign, nonatomic) int fromToFlag;

@property(nonatomic,strong) IBOutlet UIButton *getPrice;
@property(nonatomic,strong) IBOutlet UIButton *changeLanguage;
@property (weak, nonatomic) IBOutlet UIButton *getPhoto;

@property(strong, nonatomic) NSString *chosenItem;

@property (strong, nonatomic) NSArray * languages;

@property (weak, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (weak, nonatomic) IBOutlet IXPickerOverlayView *languagePickerOverlayView;

@property (assign, nonatomic) int photoCount;

@property (strong, nonatomic) NSMutableArray * photoIcons;
@property (strong, nonatomic) NSMutableArray * photos;

@property (strong, nonatomic) UIScrollView * photoScrollView;

@property (strong, nonatomic) UIButton * fullScreenPhotoButton;
@property (strong, nonatomic) UIImageView * fullScreenPhoto;

- (IBAction)done:(id)sender;

- (BOOL)chekLanguageFrom:(NSString*)from To:(NSString*)to;

-(IBAction)ShowListFrom:(id)sender;
-(IBAction)ShowListTo:(id)sender;
-(IBAction)changeLanguage:(id)sender;
- (IBAction)touchGetPriceBtn:(id)sender;
- (IBAction)touchGetPhoto:(id)sender;
- (IBAction)sendMail:(id)sender;
//- (IBAction)chooseLanguage:(id)sender;

- (int) getPricePerPage;

- (void) showPhotoThumbs;
- (void) removeImage: (int) index;

- (void) closePhoto;

@end
