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


@interface OrderDetailsController (){
    BOOL textViewFlag;
}


@end

@implementation OrderDetailsController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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
    UIImage *langFieldBackground=[UIImage imageNamed:@"langPiker"];
   /* UIImage *textViewBackground=[UIImage imageNamed:@"textView"];
    UIImage *getPriceIcon=[UIImage imageNamed:@"photo"];
    UIImage *getPhotoIcon=[UIImage imageNamed:@"graduationCap"];*/
    
    UIColor * background=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.view setBackgroundColor:background];
    
    
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
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = cartNavigationItem;
    
    

    //end of initialization of tab bar
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
    DataManager *dataMngr = [[DataManager alloc] init];
    
    Order *order = [NSEntityDescription
                               insertNewObjectForEntityForName:@"FailedBankInfo"
                               inManagedObjectContext:[dataMngr getObjectContext]];
    order.order_id = [NSNumber numberWithInt:1];
    order.orderType = [NSNumber numberWithInt:1];
    order.infoType = [NSNumber numberWithInt:1];
    float totalPrice = ([_text.text length]/1800.0 + 0.5*_photoCount) * [self getPricePerPage];
    order.cost = [NSNumber numberWithFloat:totalPrice];
    order.status = [NSNumber numberWithInt:1];
    order.langTo = _to.text;
    order.langFrom = _from.text;
    order.duration = [NSNumber numberWithInteger:([_text.text length]*0.025 + _photoCount*45)];
    
    
    
    
    [self.navigationController pushViewController:payDetailController animated:YES];
}

- (IBAction)touchGetPhoto:(id)sender {
    photoViewController=[[PhotoViewController alloc]init];
    [self.navigationController pushViewController:photoViewController animated:YES];
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
    if(_languagePicker.frame.origin.y >400){
        [self scrollViewToPosition:-30];
    }
    else{
        [self scrollViewToPosition:0];
    }
}

-(IBAction)ShowListTo:(id)sender{
    if(_languagePicker.frame.origin.y >400){
        [self scrollViewToPosition:-30];
    }
    else{
        [self scrollViewToPosition:0];
    }
}

- (void) scrollViewToPosition:(float)position{
    
    [UIView animateWithDuration:0.25f animations:^{
        CGRect pickerFrame = self.languagePicker.frame;
        
        if(position < 0)
            pickerFrame.origin.y = 200-position;
        else
            pickerFrame.origin.y = 416;
        [self.languagePicker setFrame:pickerFrame];
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
    NSLog(@"Chosen item: %@", [_languages objectAtIndex:row]);
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
        _pricePerPage = [[[DataManager languages] valueForKey:NSLocalizedString(@"Etc", nil)] intValue];
    }
    return _pricePerPage;
}


@end
