//
//  ETWebViewController.h
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 19.10.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) id<UIWebViewDelegate> delegate;
@property (weak, nonatomic) UIButton *closeButton;

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) void (^closeButtonPressedBlock)();

- (id)initWithUrl:(NSString *)url;

@end
