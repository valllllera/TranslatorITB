//
//  AboutCompany.m
//  TranslatorItbFirst
//
//  Created by Андрей on 23.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AboutCompany.h"
#import "IIViewDeckController.h"

@interface AboutCompany (){

}
    
@end

@implementation AboutCompany

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
    
    UIFont *font=[UIFont fontWithName:@"Lobster 1.4" size:25];
    UILabel *title=[[UILabel alloc]init];
    
    [title setFont:font];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [title setShadowColor:[UIColor blackColor]];
    [title setShadowOffset:CGSizeMake(1, 1)];
    title.text=@"О компании";
    title.frame=CGRectMake(10, 10, 20, 50);
    [self.navigationItem setTitleView:title];
    
    [_scroll setContentSize:CGSizeMake(320,830)];
    
    //Creating of cart button
    UIButton *cartButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 38, 28)];
    [cartButton setBackgroundImage: [UIImage imageNamed:@"cart-top-button.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self.viewDeckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cartNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 28)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.leftBarButtonItem = menuNavigationItem;
    self.navigationItem.rightBarButtonItem = cartNavigationItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchVk:(id)sender {
    [AboutCompany openSafari:@"http://vk.com/itbfirst"];
}

- (IBAction)touchFb:(id)sender {
    [AboutCompany openSafari:@"https://www.facebook.com/itbfirst"];
}

- (IBAction)touchTw:(id)sender {
    [AboutCompany openSafari:@"https://twitter.com/itbfirst_ru/"];
}
+(void)openSafari:(NSString*)url{

    [[UIApplication sharedApplication] openURL:[ [ NSURL alloc ] initWithString: url ]];
}
@end
