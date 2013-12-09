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
#import "ETWebViewController.h"
#import "ETRobokassa.h"
#import "ServerManager.h"
#define IS_WIDESCREEN (fabs ((double) [[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)


@interface YourOrder ()

@property (strong, nonatomic) NSNumber *robokassaIdx;
@property (assign, nonatomic) BOOL isFirstViewAppear;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) Order *currentOrder;

@property (strong, nonatomic) ETWebViewController *webViewController;

@property (strong, nonatomic) UIButton *getTranslateButton;

@end

@implementation YourOrder

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Ваш заказ"];
        _isFirstViewAppear = YES;
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
    
    DataManager *dataMngr = [[DataManager alloc] init];
    self.context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *orders;
    orders = [_context executeFetchRequest:fetchRequest error:&error];
    
    self.currentOrder = [orders objectAtIndex:_currentOrderIndex];
    
    self.robokassaIdx = _currentOrder.robokassaIdx;
    
    
    //-----end of initialization of tab bar
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{    
    if(_isFirstViewAppear && [_currentOrder.status intValue] == 3)
    {
        [self checkPaid];
        _isFirstViewAppear = NO;
    }
    
    [super viewDidAppear:animated];
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self configureView];
    
    [super viewWillAppear:animated];
}

- (void)configureView
{
    if([_currentOrder.status intValue] == 1) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-is-done.png"]];
        
        UIImage *getTranslateButtonBg = [[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
        if(IS_WIDESCREEN == false)
            _getTranslateButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 360, 280, 41)];
        else
            _getTranslateButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 448, 280, 41)];
        [_getTranslateButton setBackgroundImage:getTranslateButtonBg forState:UIControlStateNormal];
        [_getTranslateButton setTitle:@"Скачать перевод" forState:UIControlStateNormal];
        [_getTranslateButton setImage:[UIImage imageNamed:@"send-image.png"] forState:UIControlStateNormal];
        [_getTranslateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getTranslateButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16.0f];
        [_getTranslateButton setImageEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
        [_getTranslateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        _getTranslateButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        _getTranslateButton.titleLabel.shadowColor = [UIColor grayColor];
        [_getTranslateButton addTarget:self action:@selector(getTranslateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _orderPriceAndTerm = [[UILabel alloc] initWithFrame: CGRectMake(20, 300, 280, 50)];
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / Заказ выполнен %@ в %@", [_currentOrder.cost intValue], [_currentOrder.finishDate dateTitleFull], [_currentOrder.finishDate dateTitleHourMinute]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        _orderPriceAndTerm.numberOfLines = 0;
        [self.view addSubview:_orderPriceAndTerm];
        
        [self.view addSubview:_getTranslateButton];
    }
    else if([_currentOrder.status intValue] == 2) {
        [_orderStatusImage setImage:[UIImage imageNamed:@"order-in-work.png"]];
        
        _orderPriceAndTerm = [[UILabel alloc] initWithFrame: CGRectMake(20, 300, 280, 50)];
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / Заказ будет выполнен %@ в %@", [_currentOrder.cost intValue], [_currentOrder.finishDate dateTitleFull], [_currentOrder.finishDate dateTitleHourMinute]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        _orderPriceAndTerm.numberOfLines = 0;
        [self.view addSubview:_orderPriceAndTerm];
    }
    else if([_currentOrder.status intValue] == 3) {
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
        [_orderPriceAndTerm setText: [[NSString alloc] initWithFormat: @"%d руб. / %d мин.", [_currentOrder.cost intValue], [_currentOrder.duration intValue]]];
        [_orderPriceAndTerm setTextAlignment: NSTextAlignmentCenter];
        [_orderPriceAndTerm setBackgroundColor:[UIColor clearColor]];
        [_orderPriceAndTerm setTextColor:[UIColor orangeColor]];
        [_orderPriceAndTerm setNumberOfLines:0];
        [self.view addSubview:_orderPriceAndTerm];
    }
    
    //if([currentOrder.infoType intValue]== 1) {
    UILabel *orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 25)];
    [orderNumber setText: [[NSString alloc] initWithFormat: @"Заказ № %d", [_currentOrder.order_id intValue]]];
    [orderNumber setTextAlignment: NSTextAlignmentCenter];
    [orderNumber setBackgroundColor:[UIColor clearColor]];
    [orderNumber setTextColor:[UIColor grayColor]];
    [self.view addSubview:orderNumber];
    //}
    
    if([_currentOrder.infoType intValue] == 2) {
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
    
    if([_currentOrder.robokassaIdx integerValue] == 0)
    {
        _currentOrder.robokassaIdx = @(ABS(arc4random()));
        [_context save:nil];
    }
    
    self.robokassaIdx = _currentOrder.robokassaIdx;
    
    NSString *url = [ETRobokassa robokassaUrlWithLogin:[AppConsts robokassaLogin] password:[AppConsts robokassaPass] sum:_currentOrder.cost email:nil idx:_robokassaIdx description:nil];
    
    self.webViewController = [[ETWebViewController alloc] initWithUrl:url];
    
    __weak YourOrder *selfWeak = self;
    
    [_webViewController setCloseButtonPressedBlock:^{
      
        [selfWeak dismissViewControllerAnimated:YES completion:^{
            
            [selfWeak checkPaid];
            
        }];
        
    }];
    
    [self presentViewController:_webViewController animated:YES completion:nil];
}

- (void)checkPaid
{
    if([_currentOrder.robokassaIdx integerValue] != 0)
    {
        MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHud.labelText = @"Проверка оплаты...";
        
        [[ServerManager sharedInstance] checkOrderWithIdx:_robokassaIdx withSuccess:^(BOOL isPaid) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if(isPaid)
            {
                [self finish];
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }];
    }
}

- (void)finish
{
    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDate *termDate = [NSDate alloc];
    termDate = [termDate getTheStartOfTranslation];
    termDate = [termDate getDeadLineOfTranslationFromStartAt:termDate andDuration: [_currentOrder.duration intValue]];
    
    NSTimeInterval offsetTime = 15*60;
    NSDate *deadLine = [[NSDate alloc] initWithTimeInterval:offsetTime sinceDate:termDate];
    
    _currentOrder.startDate = termDate;
    _currentOrder.finishDate = deadLine;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    User *user = [_context executeFetchRequest:fetchRequest error:nil][0];
    
    NSString *orderTypeString;
    if([_currentOrder.orderType integerValue] == 0)
    {
        orderTypeString = @"Basic";
    }
    else if([_currentOrder.orderType integerValue] == 1)
    {
        orderTypeString = @"Middle";
    }
    else if([_currentOrder.orderType integerValue] == 2)
    {
        orderTypeString = @"Best";
    }
    
    NSArray *photos = [NSKeyedUnarchiver unarchiveObjectWithData:_currentOrder.images];
    
    NSString *orderCost = [_currentOrder.cost stringValue];
    NSString *orderDuration = [_currentOrder.duration stringValue];
    
    NSString *orderDate = [_currentOrder.finishDate dateTitleFull];
    
    NSString *orderFrom = _currentOrder.langFrom;
    NSString *orderTo = _currentOrder.langTo;
    
    NSString *subject = [NSString stringWithFormat:@"Перевод #%@", _currentOrder.robokassaIdx];
    
    NSMutableArray *filedatas = [NSMutableArray array];
    for(UIImage *photo in photos)
    {
        [filedatas addObject:UIImageJPEGRepresentation(photo, 5.0f)];
    }
    
    NSString *message = [NSString stringWithFormat:@"<strong>#%@<br>%@, %@, %@<br>%@ - %@ руб. - %@ мин. (до %@)<br>%@ -> %@</strong><br><br>%@", _currentOrder.robokassaIdx, user.username, user.email, user.phone, orderTypeString, orderCost, orderDuration, orderDate, orderFrom, orderTo, [photos count] > 0 ? @"" : _currentOrder.text];
    
    [_context save:nil];
    
    [[EmailManager sharedInstance] sendMessageWithFromEmail:[AppConsts serverEmail] withToEmail:[AppConsts serverEmailToTranslate] withSMTPHost:[AppConsts smtpHost] withSMTPLogin:[AppConsts serverEmail] withSMTPPass:[AppConsts serverEmailPass] withSubject:subject withBody:message withAttachFiledatas:filedatas withFileType:@"jpg" withSuccess:^{
        
        _currentOrder.status = [NSNumber numberWithInt:2];
        
        [_context save:nil];
        for(UIView *view in self.view.subviews)
        {
            if(view != _orderStatusImage)
            {
                [view removeFromSuperview];
            }
        }
        
        [self configureView];
        
        [progressHud hide:YES];
        
    } withFailture:^{
        
        [progressHud hide:YES];
        
    }];
}

-(void)getTranslateButtonPressed:(id)sender
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    User *user = [_context executeFetchRequest:fetchRequest error:nil][0];
    
    MBProgressHUD *progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *orderTypeString;
    if([_currentOrder.orderType integerValue] == 0)
    {
        orderTypeString = @"Basic";
    }
    else if([_currentOrder.orderType integerValue] == 1)
    {
        orderTypeString = @"Middle";
    }
    else if([_currentOrder.orderType integerValue] == 2)
    {
        orderTypeString = @"Best";
    }
    
    NSString *orderCost = [_currentOrder.cost stringValue];
    NSString *orderDuration = [_currentOrder.duration stringValue];
    
    NSString *orderDate = [_currentOrder.finishDate dateTitleFull];
    
    NSString *orderFrom = _currentOrder.langFrom;
    NSString *orderTo = _currentOrder.langTo;
    
    NSString *subject = [NSString stringWithFormat:@"Запрос на повторную отправку перевода #%@", _currentOrder.robokassaIdx];
    
    NSString *message = [NSString stringWithFormat:@"<strong>Запрос на повторную отправку перевода #%@<br>%@, %@, %@<br>%@ - %@ руб. - %@ мин. (до %@)<br>%@ -> %@</strong>", _currentOrder.robokassaIdx, user.username, user.email, user.phone, orderTypeString, orderCost, orderDuration, orderDate, orderFrom, orderTo];
    
    [[EmailManager sharedInstance] sendMessageWithFromEmail:[AppConsts serverEmail] withToEmail:[AppConsts serverEmailToTranslate] withSMTPHost:[AppConsts smtpHost] withSMTPLogin:[AppConsts serverEmail] withSMTPPass:[AppConsts serverEmailPass] withSubject:subject withBody:message withAttachFiledatas:nil withFileType:nil withSuccess:^{
        
        _getTranslateButton.hidden = YES;
        
        _orderPriceAndTerm.text = @"Перевод повторно отправлен на ваш email!";
        
        [progressHud hide:YES];
        
    } withFailture:^{
        
        [progressHud hide:YES];
        
    }];
}

@end
