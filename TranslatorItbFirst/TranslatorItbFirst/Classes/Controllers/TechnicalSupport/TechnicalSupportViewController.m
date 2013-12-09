//
//  TechnicalSupportViewController.m
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 03.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "TechnicalSupportViewController.h"
#import "IIViewDeckController.h"
#import "ETWebViewController.h"
#import "AppConsts.h"

@interface TechnicalSupportViewController ()

@end

@implementation TechnicalSupportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    title.text=@"Тех. поддержка";
    title.frame=CGRectMake(10, 10, 20, 50);
    [self.navigationItem setTitleView:title];

    //Set background to view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //Initialization of tab bar
    self.navigationItem.hidesBackButton = YES;

    
    // Do any additional setup after loading the view from its nib.
    
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pressedMenuBtn
{
    [self.viewDeckController toggleLeftView];
}

-(void)pressedBasketBtn
{
    [self.viewDeckController toggleRightView];
}


- (IBAction)startChatButtonPressed:(id)sender
{
    ETWebViewController *webViewController = [[ETWebViewController alloc] initWithUrl:[AppConsts chatUrl]];
    
    webViewController.delegate = self;
    
    [webViewController setCloseButtonPressedBlock:^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.host rangeOfString:@"siteheart.com"].location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

@end
