//
//  testView.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PayDetailsController.h"
#import "DataManager.h"


@interface PayDetailsController () <UIScrollViewDelegate>{
    BOOL userIteraction;
    
}

@end

@implementation PayDetailsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Ваш заказ"];
        userIteraction = YES;
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
    
    [self.payTypeScrollView setDelegate:self];
    yourOrder=[[YourOrder alloc]init];
    
    //Set background to view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //-----Initialization of tab bar
    self.navigationItem.hidesBackButton = NO;
    
    //Creating of cart button
    UIButton *cartButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 38, 28)];
    [cartButton setBackgroundImage: [UIImage imageNamed:@"cart-top-button.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self.viewDeckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cartNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
        
    //Creating of back button
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 28)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-button.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = menuNavigationItem;
    self.navigationItem.rightBarButtonItem = cartNavigationItem;
    
    self.viewDeckController.delegate = self;

    
    //-----end of initialization of tab bar

    //Initialization of arrays with values
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"basic-type.png", @"middle-type.png", @"best-type.png", nil];
    NSArray * labelsArray = [[NSArray alloc] initWithObjects:@"самый простой и дешевый вариант, минимальная цена и сроки", @"средний вариант, с редакторской правкой и версткой документа, средняя цена и сроки", @"самый лучший вариант, перевод носителем \n языка,редакторская правка, корректорская \n вычитка, профессиональная верстка", nil];
    //------
    
    
    //Adding button to the view
    UIImage *doOrderButtonBg = [[UIImage imageNamed:@"orangeBtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];

    UIButton *doOrderButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 360, 280, 41)];
    [doOrderButton setBackgroundImage:doOrderButtonBg forState:UIControlStateNormal];
    [doOrderButton setTitle:@"Перейти к оплате" forState:UIControlStateNormal];
    [doOrderButton setImage:[UIImage imageNamed:@"order-cart"] forState:UIControlStateNormal];
    [doOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doOrderButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16.0f];
    [doOrderButton setImageEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
    [doOrderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    doOrderButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
    doOrderButton.titleLabel.shadowColor = [UIColor grayColor];
    [doOrderButton addTarget:self action:@selector(goToPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doOrderButton];
    //-----
    
    //customize page control
    _pageController = [[DDPageControl alloc] initWithType:DDPageControlTypeOnFullOffFull];
    _pageController.frame = CGRectMake(145, 300, 100, 20);
    _pageController.indicatorDiameter = 10;
    _pageController.indicatorSpace = 20;
    _pageController.numberOfPages = 3;
    _pageController.onColor = [UIColor orangeColor];
    _pageController.offColor = [UIColor whiteColor];
    [_pageController addTarget:self action:@selector(pageControlDidClicked:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:_pageController];
    
    _priceLabels = [[NSMutableArray alloc] init];
    
    // Add prices and terms
    _priceMultiplier = [NSArray arrayWithObjects: [NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:1.6], [NSNumber numberWithFloat:2.0], nil];
    _termMultiplier = [NSArray arrayWithObjects: [NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:1.3], [NSNumber numberWithFloat:2.0], nil];
    
    for (int i = 0; i < 3; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = _payTypeScrollView.frame.size.width * i + 72;
        frame.origin.y = 15;
        frame.size.height = 175;
        frame.size.width = 175;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [_payTypeScrollView addSubview:imageView];
        
        CGRect typeDescriptionLabelFrame;
        typeDescriptionLabelFrame.origin.x = _payTypeScrollView.frame.size.width * i + 20;
        typeDescriptionLabelFrame.origin.y = 200;
        typeDescriptionLabelFrame.size.height = 60;
        typeDescriptionLabelFrame.size.width = 280;
        
        UILabel *typeDescription = [[UILabel alloc] initWithFrame:typeDescriptionLabelFrame];
        typeDescription.text = [labelsArray objectAtIndex:i];
        typeDescription.textAlignment = NSTextAlignmentCenter;
        [typeDescription setTextColor: [UIColor grayColor]];
        [typeDescription setBackgroundColor: [UIColor clearColor]];
        [typeDescription setFont: [UIFont fontWithName:@"arial" size:12.0f]];
        typeDescription.numberOfLines = 0;
        [_payTypeScrollView addSubview:typeDescription];
        
        CGRect termAndPriceLabelFrame;
        termAndPriceLabelFrame.origin.x = _payTypeScrollView.frame.size.width * i + 40;
        termAndPriceLabelFrame.origin.y = 240;
        termAndPriceLabelFrame.size.height = 80;
        termAndPriceLabelFrame.size.width = 240;
        
        UILabel *_termAndPriceLabel = [[UILabel alloc] initWithFrame:termAndPriceLabelFrame];
        _termAndPriceLabel.textAlignment = NSTextAlignmentCenter;
        [_termAndPriceLabel setTextColor: [UIColor orangeColor]];
        [_termAndPriceLabel setBackgroundColor: [UIColor clearColor]];
        [_termAndPriceLabel setFont: [UIFont fontWithName:@"arial" size:16.0f]];
        _termAndPriceLabel.numberOfLines = 0;
        _termAndPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        [_priceLabels addObject:_termAndPriceLabel];
        
        [_payTypeScrollView addSubview:[_priceLabels objectAtIndex: i]];
    }
    //Set the content size of our scrollview according to the total width of our imageView objects.
    _payTypeScrollView.contentSize = CGSizeMake(_payTypeScrollView.frame.size.width * [imageArray count], _payTypeScrollView.frame.size.height);
}

-(void) viewWillAppear:(BOOL)animated {
    for(int i = 0; i<3; i++)
    {             
        DataManager *dataMngr = [[DataManager alloc] init];
        NSManagedObjectContext *context = [dataMngr managedObjectContext];
        
        NSArray *orders;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"OrderDataBase" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSError *error;
        orders = [context executeFetchRequest:fetchRequest error:&error];
        
        Order *order = [orders objectAtIndex:_orderIndex];
        
        NSLog(@"%.2f %d", [order.cost floatValue], [order.duration intValue]);
        
        
        
        [[_priceLabels objectAtIndex:i] setText : [NSString stringWithFormat:@"%.2f руб. / %d мин", ([order.cost floatValue]*[[_priceMultiplier objectAtIndex:i] floatValue]),
            (int)roundf([order.duration intValue]*[[_termMultiplier objectAtIndex:i] floatValue] )]];
        _orderId = [order.order_id intValue];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{	
    _termDate = [_termDate getTheStartOfTranslation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	CGFloat pageWidth = _payTypeScrollView.bounds.size.width ;
    float fractionalPage = _payTypeScrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (_pageController.currentPage != nearestNumber)
	{
		_pageController.currentPage = nearestNumber ;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToPayment:(id)sender {
    DataManager *dataMngr = [[DataManager alloc] init];
    NSManagedObjectContext *context = [dataMngr managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrderDataBase" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *orders;
    orders = [context executeFetchRequest:fetchRequest error:&error];
    Order *order = [orders objectAtIndex:_orderIndex];
    
    order.orderType = [NSNumber numberWithInteger:_pageController.currentPage];
    float price = (int)roundf([order.cost floatValue]*[[_priceMultiplier objectAtIndex:_pageController.currentPage] floatValue]);
    float duration = [order.duration floatValue]*[[_termMultiplier objectAtIndex:_pageController.currentPage] floatValue];
    NSLog(@"%f", [order.duration floatValue]);
                   
    order.cost = [NSNumber numberWithFloat: price];
    order.duration = [NSNumber numberWithFloat: duration];
    
    [context save:&error];
    
    yourOrder.currentOrderIndex = _orderIndex;
    [self.navigationController pushViewController:yourOrder animated:YES];
}

- (IBAction)pageControlDidClicked:(id)sender {
    DDPageControl *thePageControl = (DDPageControl *)sender ;
	
	// we need to scroll to the new index
	[_payTypeScrollView setContentOffset: CGPointMake(_payTypeScrollView.bounds.size.width * thePageControl.currentPage, _payTypeScrollView.contentOffset.y) animated: YES];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDeckController:(IIViewDeckController *)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated
{
    if([self isKindOfClass:[PayDetailsController class]]){
        self.payTypeScrollView.userInteractionEnabled = NO;
    }
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController willCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated{
    if([self isKindOfClass:[PayDetailsController class]]){
        self.payTypeScrollView.userInteractionEnabled = YES;
    }
}

@end
