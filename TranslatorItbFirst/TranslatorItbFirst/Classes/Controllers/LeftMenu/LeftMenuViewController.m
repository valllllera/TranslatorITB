//
//  LeftMenuViewController.m
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import "AboutCompany.h"
#import "OrderDetailsController.h"
#import "TechnicalSupportViewController.h"
#import "IIViewDeckController.h"
#import "DataManager.h"
#import "SettingsViewController.h"

@implementation LeftMenuViewController

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
     UIColor *background=[UIColor colorWithPatternImage: [UIImage imageNamed:@"background"]];
    _table.separatorStyle ;
    [self.view setBackgroundColor:background];
    [[self.navigationController navigationBar] setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
    
    UIImageView *background;
    UIImageView* backgroundHighlighted;
    background=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-cell.png"]];
    backgroundHighlighted=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-cell-pressed.png"]];
    [cell setBackgroundView:background];
    [cell setSelectedBackgroundView:backgroundHighlighted];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"support-button.png"];
            cell.textLabel.text = @"Главное окно";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"support-button.png"];
            cell.textLabel.text = @"Сделать заказ";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"support-button.png"];
            cell.textLabel.text = @"Техподдержка";
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"about-company-button.png"];
            cell.textLabel.text = @"О компании";
            break;
    }
   	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController * menuNavigation;
    switch (indexPath.row) {
        case 0:
            menuNavigation = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
            break;
        case 1:
        {
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
                menuNavigation = [[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]];
            }
            else
                menuNavigation = [[UINavigationController alloc] initWithRootViewController:[[OrderDetailsController alloc] init]];
        }
            break;
        case 2:
            menuNavigation = [[UINavigationController alloc] initWithRootViewController:[[TechnicalSupportViewController alloc] init]];
            break;
        case 3:
            menuNavigation = [[UINavigationController alloc] initWithRootViewController:[[AboutCompany alloc] init]];
            break;
    }
    if(menuNavigation)
    {
        [self.viewDeckController setCenterController:menuNavigation];
        [self.viewDeckController closeLeftView];
    }
}

@end
