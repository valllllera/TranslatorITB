//
//  PhotoTest.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PhotoTest.h"

@interface PhotoTest ()

@end

@implementation PhotoTest

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PhotoThumb * photoIcon = [[PhotoThumb alloc] initWithFrame: CGRectMake(100, 100, 100, 100)];
    UIView * rtVIew = [[UIView alloc] initWithFrame: CGRectMake(100,100,100,100)];
    [rtVIew setBackgroundColor:[UIColor redColor]];
    NSLog(@"%@", photoIcon);
    [self.view addSubview:rtVIew];
    [self.view addSubview:photoIcon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
