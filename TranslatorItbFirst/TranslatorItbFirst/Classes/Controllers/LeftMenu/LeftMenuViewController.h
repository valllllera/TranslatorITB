//
//  LeftMenuViewController.h
//  TranslatorItbFirst
//
//  Created by Alexey Kalentiev on 27.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeftMenuViewController : UIViewController <UITableViewDataSource,  UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *table;

@end
