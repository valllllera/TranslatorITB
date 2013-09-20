//
//  OrderDetailsController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "OrderDetailsController.h"
#import "DataManager.h"
#import "IIViewDeckController.h"
#define IS_WIDESCREEN (fabs ((double) [[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)


@interface OrderDetailsController (){
    BOOL textViewFlag;
}


@end

@implementation OrderDetailsController

bool textViewIsVeginEditin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Ваш заказ"];
        payDetailController= [[PayDetailsController alloc]init];
        _languages = [[NSArray alloc]init];
        _pickFromBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _pickToBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        textViewIsVeginEditin = NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _languagePicker.delegate = self;
    _languagePicker.dataSource = self;
    
    //Navigation bar custom title font
    UIFont *titleFont=[UIFont fontWithName:@"Lobster 1.4" size:25];
    UIFont *light=[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:14];
    UIFont *bold=[UIFont fontWithName:@"HelveticaNeueCyr-Bold" size:18];

    
    UILabel *title=[[UILabel alloc]init];
    [title setFont:titleFont];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [title setShadowColor:[UIColor blackColor]];
    [title setShadowOffset:CGSizeMake(1, 1)];
    title.text=@"Ваш заказ";
    title.frame=CGRectMake(10, 10, 20, 50);
    [self.navigationItem setTitleView:title];

    _text.inputAccessoryView = _toolBar;
    [_text setFont:light];
    [_to setFont:light];
    [_from setFont:light];
    [_getPrice setFont:bold];
    [_getPhoto setFont:bold];
    
    
    UIImage *langFieldBackground = [[UIImage imageNamed:@"textFieldBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,3, 0, 3)];
    UIImage *orangeBtn=[[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,4,0,4)];
    UIImage *blackBtn=[[UIImage imageNamed:@"blackBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,5,0,5)];
    [_getPhoto setBackgroundImage:blackBtn forState:UIControlStateNormal];
    [_getPrice setBackgroundImage:orangeBtn forState:UIControlStateNormal];
    UIImage *b;
    if(IS_WIDESCREEN == false)
        b=[[UIImage imageNamed:@"textView.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,3, 0,3)];
    else
        b=[[UIImage imageNamed:@"textView-4.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,3, 0,3)];
    [_backgr setImage:b];
    
    [_to setBackground:langFieldBackground];
    [_from setBackground:langFieldBackground];
    [_text setDelegate:self];
    [_to setDelegate:self];
    [_from setDelegate:self];

    
    _languages = [DataManager sharedData].languages; 
    UIImage *image = [UIImage imageNamed:@"triangle"];
    
    [_pickFromBtn setImage:image forState:UIControlStateNormal];
    _pickFromBtn.frame = CGRectMake(0, 0,30, 30);
    [_pickFromBtn addTarget:self action:@selector(ShowListFrom:) forControlEvents:UIControlEventTouchUpInside];
  
    [_pickToBtn setImage:image forState:UIControlStateNormal];
    _pickToBtn.frame = CGRectMake(0, 0,30, 30);
    [_pickToBtn addTarget:self action:@selector(ShowListTo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _from.rightView = _pickFromBtn;
    _from.rightViewMode = UITextFieldViewModeAlways;
    _to.rightView = _pickToBtn;
    _to.rightViewMode = UITextFieldViewModeAlways;


    
    //Set background to view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //Initialization of tab bar
    self.navigationItem.hidesBackButton = YES;
    
    //Init basket button
    UIButton *cartButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 38, 28)];
    [cartButton setBackgroundImage: [UIImage imageNamed:@"cart-top-button.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(pressedBasketBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cartNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    //Init left meu button
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 28)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(pressedMenuBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    //end of initialization of tab bar
    
    /*_doneButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 416, 290, 41)];
    [_doneButton setTitle:@"Выбрать" forState:UIControlStateNormal];
    UIImage *doneBtnBg=[[UIImage imageNamed:@"blackBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,5,0,5)];
    [_doneButton setBackgroundImage:doneBtnBg forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(chooseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doneButton];*/
    
    _languages = [_languages sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = cartNavigationItem;
}

-(void)pressedMenuBtn{
    [_text resignFirstResponder];
    [self.viewDeckController toggleLeftView];
}
-(void)pressedBasketBtn{
    [_text resignFirstResponder];
    [self.viewDeckController toggleRightView];
}


-(IBAction)changeLanguage:(id)sender{
    if([_to.text isEqualToString:@""]!=YES &&  [_from.text isEqualToString:@""]!=YES){
    NSString * temp=[NSString stringWithString:_from.text];
    _from.text=_to.text;
    _to.text=temp;
    }
}

- (IBAction)touchGetPriceBtn:(id)sender {
   // if([self chekLanguageFrom:_from.text To:_to.text]!=NO && [_text.text isEqualToString:@""]!=YES)
    if(textViewFlag==NO || [_text.text length] == 0){
        UIAlertView *alert=[[UIAlertView alloc] init];
        alert= [alert initWithTitle:NSLocalizedString(@"AppName", nil)
                            message:@"Вставьте текст или сделайте фото!"
                           delegate:nil cancelButtonTitle:@"OK"
                  otherButtonTitles:nil];
        [alert show];
        return;
    }
    //new order addition
        DataManager *dataMngr = [[DataManager alloc] init];
        NSManagedObjectContext *context = [dataMngr managedObjectContext];
        
        //[dataMngr deleteAllObjects:@"OrderDataBase"];
        
        Order *order = [NSEntityDescription
                        insertNewObjectForEntityForName:@"OrderDataBase"
                        inManagedObjectContext:context];
        NSError *error;
        [context save:&error];
        
        NSArray *orders;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"OrderDataBase" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        orders = [context executeFetchRequest:fetchRequest error:&error];
        _orderIndex = [orders count]-1;
        int lastItem = 0;
        if(_orderIndex != 0) {
            Order * temp = [orders objectAtIndex:_orderIndex-1];
            lastItem = [temp.order_id intValue];
        }
        
        order.order_id = [NSNumber numberWithInt: lastItem+1];
        order.orderType = [NSNumber numberWithInt:1];
            
        order.infoType = [NSNumber numberWithInt:_infoType];
        float totalPrice = ([_text.text length]/1800.0 + 0.5*_photoCount) * [self getPricePerPage];
        order.cost = [NSNumber numberWithInt:((int)roundf(totalPrice) + 1)];
        order.status = [NSNumber numberWithInt:3];
        order.langTo = _to.text;
        order.langFrom = _from.text;
        order.duration = [NSNumber numberWithFloat:(((int)roundf([_text.text length]*0.025) + _photoCount*45) + 1)];
        NSLog(@"%d", (int)roundf([_text.text length]*0.025));
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        payDetailController.orderIndex = _orderIndex;
        
        [self.navigationController pushViewController:payDetailController animated:YES];
    }
- (IBAction)touchGetPhoto:(id)sender {
    PhotoView *photoViewController=[[PhotoView alloc] initWithNibName:@"PhotoView" bundle:nil];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.showsCameraControls = NO;
    picker.navigationBarHidden = NO;
    picker.cameraOverlayView=photoViewController.view;
    [picker setDelegate:photoViewController];
    
    // if([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerSourceTypeCamera]==YES){
    //     picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
    //}
    [self presentModalViewController:picker animated:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if([_from isFirstResponder] && [touch view] != _from){
          [_from resignFirstResponder];
    }
    else if([_text isFirstResponder] && [touch view] != _text){
         [_text resignFirstResponder];
    }
    else if ([_to isFirstResponder] && [touch view]!=_to){
         [_to   resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)done:(id)sender {
    [_text resignFirstResponder];
}

- (BOOL)chekLanguageFrom:(NSString*)from To:(NSString*)to{
    UIAlertView *alert=[[UIAlertView alloc] init];
    
    if([from isEqual:@""] || [to isEqual:@""]){
        alert= [alert initWithTitle:NSLocalizedString(@"AppName", nil)
                            message:NSLocalizedString(@"EmptyLanguage", nil)
                           delegate:nil cancelButtonTitle:@"OK"
                  otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textView {
    [textView resignFirstResponder];
    return YES;
}


#pragma mark - TextView delegate


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(textViewFlag==NO){
        _text.text=@"";
        textViewFlag=YES;
    }
}

#pragma mark - textFieldActions

-(IBAction)ShowListFrom:(id)sender{
    if(_fromToFlag != 2) {
        if(_languagePicker.frame.origin.y >400){
            [self scrollViewToPosition:-30];
        }
        else{
            [self scrollViewToPosition:0];
        }
        if(_fromToFlag == 0)
            _fromToFlag = 1;
        else _fromToFlag = 0;
    }
}

-(IBAction)ShowListTo:(id)sender{
    if(_fromToFlag != 1) {
        if(_languagePicker.frame.origin.y >400){
            [self scrollViewToPosition:-30];
        }
        else{
            [self scrollViewToPosition:0];
        }
        if(_fromToFlag == 0)
            _fromToFlag = 2;
        else _fromToFlag = 0;
    }
}

- (void) scrollViewToPosition:(float)position {
    int show, hide;
    if(IS_WIDESCREEN == FALSE) {
        show = 200;
        hide = 416;
    }
    else {
        show = 288;
        hide = 504;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        CGRect pickerFrame = self.languagePicker.frame;
        //CGRect buttonFrame = _doneButton.frame;
        if(position < 0) {
            pickerFrame.origin.y = show-position;
            //buttonFrame.origin.y = 226;
        }
        else {
            pickerFrame.origin.y = hide;
            //buttonFrame.origin.y = 416;
        }
        [self.languagePicker setFrame:pickerFrame];
        //[_doneButton setFrame:buttonFrame];
        [self.languagePickerOverlayView setFrame:pickerFrame];
    }];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = position;
        [self.view setFrame:frame];
    }];
}

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_languages count];
}

#pragma mark - UIPickerView Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_languages objectAtIndex:row];
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    //_chosenItem = [_languages objectAtIndex:row];
    if(_fromToFlag == 1) {
        _from.text = [_languages objectAtIndex:row];
    }
    if(_fromToFlag == 2) {
        _to.text = [_languages objectAtIndex:row];
    }

}

- (int) getPricePerPage {
    //calculating priecePerPage
    int _pricePerPage;
    if([_to.text isEqualToString:@"Русский"] || [_to.text isEqualToString:@"Russian"]) {
        _pricePerPage = [[[DataManager languages] valueForKey:_to.text] intValue];
    }
    else if([_from.text isEqualToString:@"Русский"] || [_from.text isEqualToString:@"Russian"]) {
        _pricePerPage = [[[DataManager languages] valueForKey:_from.text] intValue];
    }
    else {
        _pricePerPage = [DataManager getEtc];
    }
    return _pricePerPage;
}

/*- (IBAction) chooseLanguage:(id)sender {
    if(_fromToFlag == 1) {
        _from.text = _chosenItem;
        [self scrollViewToPosition:0];
        _fromToFlag = 0;
    }
    if(_fromToFlag == 2) {
        _to.text = _chosenItem;
        [self scrollViewToPosition:0];
        _fromToFlag = 0;
    }
}*/


@end
