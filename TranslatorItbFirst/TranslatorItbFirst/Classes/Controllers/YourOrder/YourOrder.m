//
//  YourOrder.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 29.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "YourOrder.h"
#import "IIViewDeckController.h"

@interface YourOrder ()

@end

@implementation YourOrder

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Ваш заказ"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    //Set background to view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //-----Initialization of tab bar
    self.navigationItem.hidesBackButton = YES;
    
    //Creating of cart button
    UIButton *cartButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 38, 28)];
    [cartButton setBackgroundImage: [UIImage imageNamed:@"cart-top-button.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self.viewDeckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cartNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    //Creating of menu button
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 28)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.leftBarButtonItem = menuNavigationItem;
    self.navigationItem.rightBarButtonItem = cartNavigationItem;
    
    
    //-----end of initialization of tab bar
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated {
    /*if(_currentOrder.status == 1)
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-is-done.png"]];
    else if(_currentOrder.status == 2) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-in-work.png"]];
        UIImage *getTranslateButtonBg = [[UIImage imageNamed:@"do-order-button.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 3, 0, 3)];
        
        UIButton *getTranslateButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 360, 280, 38)];
        [getTranslateButton setBackgroundImage:getTranslateButtonBg forState:UIControlStateNormal];
        [getTranslateButton setTitle:@"Скачать перевод" forState:UIControlStateNormal];
        [getTranslateButton setImage:[UIImage imageNamed:@"send-image.png"] forState:UIControlStateNormal];
        [getTranslateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getTranslateButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16.0f];
        [getTranslateButton setImageEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
        [getTranslateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        getTranslateButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        getTranslateButton.titleLabel.shadowColor = [UIColor grayColor];
        [getTranslateButton addTarget:self action:@selector(goToPayment:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:getTranslateButton];*/
        
    }
    
    /*if(_currentOrder.status == 1 || (_currentOrder.status == 2 && _currentOrder.infoType == 1)) {
        UILabel *orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 25)];
        [orderNumber setText: [[NSString alloc] initWithFormat: @"Заказ № %d", _currentOrder.id]];
        [orderNumber setTextAlignment: NSTextAlignmentCenter];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setTextColor:[UIColor grayColor]];
        [self.view addSubview:orderNumber];
    }
    
    if(_currentOrder.status == 2 && _currentOrder.infoType == 2) {
        UIImageView *photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(139, 215, 42, 42)];
        [photoIcon setImage:[UIImage imageNamed:@"order-images.png"]];
        [self.view addSubview:photoIcon];
    }
    
    UILabel *orderPriceAndTerm = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 280, 25)];
    [orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / %d мин.", _currentOrder.cost, 300]];
    [orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
    [orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
    [orderPriceAndTerm setTextColor:[UIColor orangeColor]];
    [self.view addSubview:orderPriceAndTerm];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
