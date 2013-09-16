//
//  RightBasketViewController.m
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "RightBasketViewController.h"
#import "OrderCell.h"
#import <QuartzCore/QuartzCore.h>
@interface RightBasketViewController ()

@end

@implementation RightBasketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    CALayer *layer = [_image layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = 41;
    layer.borderWidth = 0;
    layer.borderColor = nil;
    
    UIColor *background=[UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]];
    [super viewDidLoad];

    [_table setBackgroundColor:[UIColor colorWithWhite:0.146 alpha:1.000]];
    [_table setSeparatorColor:[UIColor colorWithWhite:0.169 alpha:1.000]];
    [_table setBackgroundColor:background];
    [self.view setBackgroundColor:background];
    [[self.navigationController navigationBar] setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)exit:(id)sender {
    
}

- (IBAction)opernProperties:(id)sender {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *cellIdentifier = @"OrderCell";
    Order * order=[orders objectAtIndex:row];
    
    //OrderCell *cell = [[OrderCell alloc]init];
	OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (nil == cell)
	{
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
	}
    
   //[cell initSelfFromOrder: order];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YourOrder *orderView = [[YourOrder alloc] init];
    orderView.currentOrder = [orders objectAtIndex:indexPath.row];
    UINavigationController * menuNavigation = [[UINavigationController alloc] initWithRootViewController:orderView];
    [self.viewDeckController setCenterController:menuNavigation];
    [self.viewDeckController closeRightView];
}

@end
