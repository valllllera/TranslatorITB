//
//  SettingsViewController.m
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 05.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "SettingsViewController.h"
#import "IIViewDeckController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController (){
    NSTimer *timer;
    bool blinkStatus;
    int timerCount;
}

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
              // Custom initialization
    }
    return self;
}
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 20 , 20 );
}
-(void)blink{
    
   ++timerCount;
    if(blinkStatus == NO){
      _blinkLabel.textColor = [UIColor redColor];
       blinkStatus = YES;
    }else {
        _blinkLabel.textColor = [UIColor lightGrayColor];
        blinkStatus = NO;
    }
    if(blinkStatus==YES && timerCount==3){
        timerCount=0;
        [self stopTimer];
    }
    else if(timerCount==4){
        timerCount=0;
        [self stopTimer];
    }
   
}
// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 20 , 20 );
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set textField Delegate
    [_emailTExtField setDelegate:self];
    [_fioTextField setDelegate:self];
    [_phoneTextField setDelegate:self];
    UIFont *userFioLabelFont=[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:16];
    //UIFont *userFioLabelFont=[UIFont fontWithName:@"HelveticaNeueCyr-Medium" size:16];
    UIFont *btnFont=[UIFont fontWithName:@"HelveticaNeueCyr-Bold" size:17];
    
    [_userFioLbl setFont:userFioLabelFont];
    [_fioTextField setFont:userFioLabelFont];
    [_emailTExtField setFont:userFioLabelFont];
    [_phoneTextField setFont:userFioLabelFont];
    [_saveBtn setFont:btnFont];

    //Set left padding
    _fioTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _fioTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _emailTExtField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _emailTExtField.leftViewMode = UITextFieldViewModeAlways;
    
    
    //set TextField Baclground Image
    UIImage *buttonImage = [[UIImage imageNamed:@"blackTextFieldBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,1, 0, 1)];
    [_fioTextField setBackground:buttonImage];
    [_emailTExtField setBackground:buttonImage];
    [_phoneTextField setBackground:buttonImage];
    
    //Set title font
    [self setNavigationBarFont:@"Lobster 1.4" andTitle:@"Настройки"];
    [self roundedImage:_userImage];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - scrolling when keyboard shown
-(BOOL)chekFields{
   
    if([_emailTExtField.text isEqual:@""]){
        
        if(timer !=nil)
           [self stopTimer];
        else
            [self startTimer];
        
        return NO;
    }
}
-(void)startTimer{
     timer=[NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0/10.5) target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
    _emailTExtField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Введите ваш email*" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];

}
-(void)stopTimer{
    [timer invalidate];
    timer=nil;
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.view.frame;
    frame.origin.y = -150;
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

- (void) keyboardWillHide: (NSNotification *) notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
}


-(void)roundedImage:(UIImageView*)imageView{
    CALayer *layer = [imageView layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = 41;
    layer.borderWidth = 0;
    layer.borderColor = nil;
}
-(void)pressedMenuBtn{
    
    [_emailTExtField resignFirstResponder];
    [_fioTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [self.viewDeckController toggleLeftView];
}
-(void)pressedBasketBtn{
    [_emailTExtField resignFirstResponder];
    [_fioTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [self.viewDeckController toggleRightView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchSaveBtn:(id)sender {
    if([self chekFields]==YES){
        //save user info
        
    }
}

//Navigation bar custom title font

-(void)setNavigationBarFont:(NSString*)font andTitle:(NSString*)title{
    UIFont *titleFont=[UIFont fontWithName:font size:25];
    UILabel *titleLbl=[[UILabel alloc]init];
    [titleLbl setFont:titleFont];
    [titleLbl setBackgroundColor:[UIColor clearColor]];
    [titleLbl setTextColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [titleLbl setShadowColor:[UIColor blackColor]];
    [titleLbl setShadowOffset:CGSizeMake(1, 1)];
    titleLbl.text=title;
    titleLbl.frame=CGRectMake(10, 10, 20, 50);
    [self.navigationItem setTitleView:titleLbl];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textView {
    [textView resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if([_phoneTextField isFirstResponder] && [touch view] != _phoneTextField){
        [_phoneTextField resignFirstResponder];
    }
    else if([_emailTExtField isFirstResponder] && [touch view] != _emailTExtField){
        [_emailTExtField resignFirstResponder];
    }
    else if ([_fioTextField isFirstResponder] && [touch view]!=_fioTextField){
        [_fioTextField   resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
