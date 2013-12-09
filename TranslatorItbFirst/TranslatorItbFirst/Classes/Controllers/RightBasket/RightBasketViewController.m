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
    
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *users = [context executeFetchRequest:fetchRequest error:&error];
    if([users count]!=0) {
        User *user = [users objectAtIndex:0];
        _fioLbl.text = user.username;
    }
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self reloadOrders];
    
    [_table reloadData];
    
    [super viewWillAppear:animated];
}

- (void)reloadOrders
{
    DataManager *dataMngr = [[DataManager alloc] init];
    self.context = [dataMngr managedObjectContext];
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    self.orders = [_context executeFetchRequest:fetchRequest error:&error];
    
    for(Order *order in _orders)
    {
        if([order.status intValue] == 2) {
            if([order.finishDate compare:[NSDate date]] == NSOrderedAscending) {
                order.status = [NSNumber numberWithInt:1];
            }
        }
    }
    [_context save:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)exit:(id)sender {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"OrderCell";
    
	OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (nil == cell)
	{
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
	}
    
   [cell initSelfFromOrder:_orders[indexPath.row]];
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
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.orders = [context executeFetchRequest:fetchRequest error:&error];
    
    NSInteger row = indexPath.row;
    YourOrder *orderView = [[YourOrder alloc] init];
    orderView.currentOrderIndex = row;
    
    UINavigationController * menuNavigation = [[UINavigationController alloc] initWithRootViewController:orderView];
    [self.viewDeckController setCenterController:menuNavigation];
    [self.viewDeckController closeRightView];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        //[categoryArray objectAtIndex:indexPath.row];
        DataManager *dataMngr = [[DataManager alloc] init];
        NSManagedObjectContext *context = [dataMngr managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"OrderDataBase" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSError *error;
        self.orders = [context executeFetchRequest:fetchRequest error:&error];
        [context deleteObject:[_orders objectAtIndex:indexPath.row]];
        [context save:&error];
        
        [self reloadOrders];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
@end
