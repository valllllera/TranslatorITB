//
//  YourOrder.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 29.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "YourOrder.h"
#import "IIViewDeckController.h"
#import "EmailManager.h"
#import "AppConsts.h"
#import "User.h"
#import "OrderDataBase.h"
#import "NSDate+VDExtensions.h"
#import "MBProgressHUD.h"
#define IS_WIDESCREEN (fabs ((double) [[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)


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
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *orders;
    orders = [context executeFetchRequest:fetchRequest error:&error];
    
    Order * currentOrder = [orders objectAtIndex:_currentOrderIndex];
    
    if([currentOrder.status intValue] == 1) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-is-done.png"]];
        
        UIImage *getTranslateButtonBg = [[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
        UIButton *getTranslateButton;
        if(IS_WIDESCREEN == false)
            getTranslateButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 360, 280, 41)];
        else
            getTranslateButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 448, 280, 41)];
        [getTranslateButton setBackgroundImage:getTranslateButtonBg forState:UIControlStateNormal];
        [getTranslateButton setTitle:@"Скачать перевод" forState:UIControlStateNormal];
        [getTranslateButton setImage:[UIImage imageNamed:@"send-image.png"] forState:UIControlStateNormal];
        [getTranslateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getTranslateButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16.0f];
        [getTranslateButton setImageEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
        [getTranslateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        getTranslateButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        getTranslateButton.titleLabel.shadowColor = [UIColor grayColor];
        //[getTranslateButton addTarget:self action:@selector(goToPayment:) forControlEvents:UIControlEventTouchUpInside];
        _orderPriceAndTerm = [[UILabel alloc] initWithFrame: CGRectMake(20, 300, 280, 50)];
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / Заказ выполнен %@ в %@", [currentOrder.cost intValue], [currentOrder.finishDate dateTitleFull], [currentOrder.finishDate dateTitleHourMinute]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        _orderPriceAndTerm.numberOfLines = 0;
        [self.view addSubview:_orderPriceAndTerm];
        
        [self.view addSubview:getTranslateButton];
    }
    else if([currentOrder.status intValue] == 2) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-in-work.png"]];
        
        _orderPriceAndTerm = [[UILabel alloc] initWithFrame: CGRectMake(20, 300, 280, 50)];
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / Заказ будет выполнен %@ в %@", [currentOrder.cost intValue], [currentOrder.finishDate dateTitleFull], [currentOrder.finishDate dateTitleHourMinute]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        _orderPriceAndTerm.numberOfLines = 0;
        [self.view addSubview:_orderPriceAndTerm];
    }
    else if([currentOrder.status intValue] == 3) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-not-payed.png"]];
        
        UIImage *ButtonBg = [[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
        if(IS_WIDESCREEN == false)
            _payButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 360, 280, 41)];
        else
            _payButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 448, 280, 41)];
        [_payButton setBackgroundImage:ButtonBg forState:UIControlStateNormal];
        [_payButton setTitle:@"Оплатить" forState:UIControlStateNormal];
        [_payButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16.0f];
        [_payButton setImageEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 0)];
        [_payButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        _payButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        _payButton.titleLabel.shadowColor = [UIColor grayColor];
        [_payButton addTarget:self action:@selector(goToPayment:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_payButton];
        
        _orderPriceAndTerm = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 280, 50)];
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / %d мин.", [currentOrder.cost intValue], [currentOrder.duration intValue]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        [_orderPriceAndTerm setNumberOfLines:0];
        [self.view addSubview:_orderPriceAndTerm];
    }
    
    //if([currentOrder.infoType intValue]== 1) {
        UILabel *orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 25)];
        [orderNumber setText: [[NSString alloc] initWithFormat: @"Заказ № %d", [currentOrder.order_id intValue]]];
        [orderNumber setTextAlignment: NSTextAlignmentCenter];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setTextColor:[UIColor grayColor]];
        [self.view addSubview:orderNumber];
    //}
    
    if([currentOrder.infoType intValue] == 2) {
        UIImageView *photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(139, 255, 42, 42)];
        [photoIcon setImage:[UIImage imageNamed:@"order-images.png"]];
        [self.view addSubview:photoIcon];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goToPayment:(id)sender {
    
    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *orders;
    orders = [context executeFetchRequest:fetchRequest error:&error];
    
    Order * currentOrder = [orders objectAtIndex:_currentOrderIndex];
    
    NSDate *termDate = [NSDate alloc];
    termDate = [termDate getTheStartOfTranslation];
    termDate = [termDate getDeadLineOfTranslationFromStartAt:termDate andDuration: [currentOrder.duration intValue]];
    
    NSTimeInterval offsetTime = 15*60;
    NSDate *deadLine = [[NSDate alloc] initWithTimeInterval:offsetTime sinceDate:termDate];
    
    currentOrder.startDate = termDate;
    currentOrder.finishDate = deadLine;
    
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    User *user = [context executeFetchRequest:fetchRequest error:&error][0];
    
    NSString *orderTypeString;
    if([currentOrder.orderType integerValue] == 0)
    {
        orderTypeString = @"Basic";
    }
    else if([currentOrder.orderType integerValue] == 1)
    {
        orderTypeString = @"Middle";
    }
    else if([currentOrder.orderType integerValue] == 2)
    {
        orderTypeString = @"Best";
    }
    
    NSArray *photos = [NSKeyedUnarchiver unarchiveObjectWithData:currentOrder.images];
    
    NSString *orderCost = [currentOrder.cost stringValue];
    NSString *orderDuration = [currentOrder.duration stringValue];
    
    NSString *orderDate = [currentOrder.finishDate dateTitleFull];
    
    NSString *orderFrom = currentOrder.langFrom;
    NSString *orderTo = currentOrder.langTo;
    
    NSString *subject = [NSString stringWithFormat:@""];
    
    NSMutableArray *filedatas = [NSMutableArray array];
    for(UIImage *photo in photos)
    {
        [filedatas addObject:UIImageJPEGRepresentation(photo, 5.0f)];
    }
    
    NSString *message = [NSString stringWithFormat:@"<strong>%@, %@, %@<br>%@ - %@ руб. - %@ мин. (до %@)<br>%@ -> %@</strong><br><br>%@", user.username, user.email, user.phone, orderTypeString, orderCost, orderDuration, orderDate, orderFrom, orderTo, [photos count] > 0 ? @"" : currentOrder.text];
    
    [[EmailManager sharedInstance] sendMessageWithFromEmail:[AppConsts serverEmail] withToEmail:@"evgeniytka4enko@gmail.com" withSMTPHost:[AppConsts smtpHost] withSMTPLogin:[AppConsts serverEmail] withSMTPPass:[AppConsts serverEmailPass] withSubject:subject withBody:message withAttachFiledatas:filedatas withFileType:@"jpg" withSuccess:^{
        
        currentOrder.status = [NSNumber numberWithInt:2];
        
        [context save:nil];
        [_orderPriceAndTerm removeFromSuperview];
        [_payButton removeFromSuperview];
        
        [self viewWillAppear:YES];
        
        [progressHud hide:YES];
        
    } withFailture:^{
        
        [progressHud hide:YES];
        
    }];
}

@end
