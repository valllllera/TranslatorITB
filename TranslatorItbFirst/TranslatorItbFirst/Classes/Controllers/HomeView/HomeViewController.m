//
//  InitialViewController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 21.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "HomeViewController.h"
#import "IIViewDeckController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            orderDetailsController = [[OrderDetailsController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set background to view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //Initialization of tab bar
    self.navigationItem.hidesBackButton = YES;
    
    UIImage * orderBtnBackground=[[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,4,0,4)];
    [_orderBtn setBackgroundImage:orderBtnBackground forState:UIControlStateNormal];
    
    UIButton *basketButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 38, 29)];
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 28)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [basketButton setBackgroundImage: [UIImage imageNamed:@"optionsBtn.png"] forState:UIControlStateNormal];
    [basketButton addTarget:self action:@selector(toSettings) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *basketNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:basketButton];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.rightBarButtonItem = basketNavigationItem;
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    // Do any additional setup after loading the view from its nib.
    
    //Navigation bar custom title font
    UIFont *titleFont=[UIFont fontWithName:@"Lobster 1.4" size:25];
    UIFont *light=[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:12];
    UIFont *bold=[UIFont fontWithName:@"HelveticaNeueCyr-Bold" size:18];
    [_orderBtn setFont:bold];
    [_text setFont:light];
    
    
    UILabel *title=[[UILabel alloc]init];
    [title setFont:titleFont];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [title setShadowColor:[UIColor blackColor]];
    [title setShadowOffset:CGSizeMake(1, 1)];
    
    NSString *str = @"itbFirst\nINTERNATIONAL TRANSLATION BUREAU";
    NSMutableAttributedString *attributetTitle = [[NSMutableAttributedString alloc] initWithString:str];
    [attributetTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Lobster 1.4" size:25.0f] range:NSMakeRange(0, 7)];
    [attributetTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:7.0f] range:NSMakeRange(8, str.length-8)];
    title.numberOfLines = 2;
    title.textAlignment = NSTextAlignmentCenter;
    title.attributedText = attributetTitle;
    title.frame=CGRectMake(10, 10, 50, 50);
    [self.navigationItem setTitleView:title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openBasket{
    RightBasketViewController *rightBasketController = [[RightBasketViewController alloc] init];
    [self.navigationController pushViewController:rightBasketController animated:YES];
}

- (IBAction)goToOrder:(id)sender {
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    //[dataMngr deleteAllObjects:@"User"];
    NSError *error;
    NSArray *users;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    users = [context executeFetchRequest:fetchRequest error:&error];
    
    if([users count]==0) {
        settingsViewController = [[SettingsViewController alloc] init];
        [self.navigationController pushViewController: settingsViewController animated:YES];
    }
    else
        [self.navigationController pushViewController: orderDetailsController animated:YES];
}

- (void)toSettings{
    [self.viewDeckController rightViewPushViewControllerOverCenterController:[[SettingsViewController alloc] init]];
   // [self.viewDeckController setCenterController:[[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]]];
}

@end
