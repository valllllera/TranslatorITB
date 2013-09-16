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
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.orders = [context executeFetchRequest:fetchRequest error:&error];
    
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *users = [context executeFetchRequest:fetchRequest error:&error];
    User *user = [users objectAtIndex:0];
    _fioLbl.text = user.username;
}

-(void) viewWillAppear:(BOOL)animated {
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];

    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
              entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *users = [context executeFetchRequest:fetchRequest error:&error];
    User *user = [users objectAtIndex:0];
    _fioLbl.text = user.username;

    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)exit:(id)sender {
    
}

- (IBAction)opernProperties:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        //Тема письма
        [picker setSubject:@"Hello from iMaladec!"];
        
        //Получатели
        NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
        NSArray *ccRecipients = [NSArray arrayWithObjects:
                                 @"second@example.com",
                                 @"third@example.com", nil];
        NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
        
        [picker setToRecipients:toRecipients];
        [picker setCcRecipients:ccRecipients];
        [picker setBccRecipients:bccRecipients];
        
        NSString *emailBody = @"Это пример отправки Email с сайта iMaladec";
        [picker setMessageBody:emailBody isHTML:NO];
        
        [self.viewDeckController setCenterController:picker];
    } else {
        NSString *ccRecipients = @"second@example.com,third@example.com";
        NSString *subject = @"Hello from iMaladec!";
        NSString *recipients = [NSString stringWithFormat:
                                @"mailto:first@example.com?cc=%@&subject=%@",
                                ccRecipients, subject];
        NSString *body = @"&body=Это пример отправки Email с сайта iMaladec";
        
        NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    NSString *message = nil;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            message = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: failed";
            break;
        default:
            message = @"Result: not sent";
            break;
    }
    
    NSLog(@"%@", message);
    
    [self.viewDeckController dismissModalViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.orders = [context executeFetchRequest:fetchRequest error:&error];
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

    static NSString *cellIdentifier = @"OrderCell";
    
	OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (nil == cell)
	{
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
	}
    
   [cell initSelfFromOrder:row];
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
    Order *order = [_orders objectAtIndex:row];
    orderView.currentOrderIndex = row;
    NSLog(@"%d %d",[order.cost intValue], row);
    
    UINavigationController * menuNavigation = [[UINavigationController alloc] initWithRootViewController:orderView];
    [self.viewDeckController setCenterController:menuNavigation];
    [self.viewDeckController closeRightView];
}

@end
