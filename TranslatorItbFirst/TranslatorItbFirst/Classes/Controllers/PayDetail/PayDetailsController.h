//
//  testView.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 07.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+VDExtensions.h"
#import "YourOrder.h"
#import "DDPageControl.h"
#import "IIViewDeckController.h"

@interface PayDetailsController : UIViewController <UIScrollViewDelegate, IIViewDeckControllerDelegate> {
    YourOrder * yourOrder;
}

@property (assign, nonatomic) int pricePerPage;
@property NSDate * termDate;
@property NSArray *priceMultiplier;
@property NSArray *termMultiplier;

@property (strong, nonatomic) Order *order;

@property NSMutableArray *priceLabels;

- (IBAction)goToPayment:(id)sender;
- (IBAction)goBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *payTypeScrollView;
@property DDPageControl *pageController;
- (IBAction)pageControlDidClicked:(id)sender;

@end
