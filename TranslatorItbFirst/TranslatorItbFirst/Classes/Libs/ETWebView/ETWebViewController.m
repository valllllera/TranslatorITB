//
//  ETWebViewController.m
//  TranslatorItbFirst
//
//  Created by Evgeniy Tka4enko on 19.10.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ETWebViewController.h"

@interface ETWebViewController ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation ETWebViewController

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if(self)
    {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView.delegate = self;
    
    [_webView addObserver:self forKeyPath:@"delegate" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew context:nil];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_closeButton setTitle:NSLocalizedString(@"Close", nil) forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _closeButton.frame = CGRectMake(0, 0, 70, 28);
    
    [_closeButton setBackgroundImage:[[UIImage imageNamed:@"button-item.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_closeButton];
    _navItem.leftBarButtonItem = item;
    
    UIFont *titleFont=[UIFont fontWithName:@"Lobster 1.4" size:25];
    self.titleLabel=[[UILabel alloc]init];
    [_titleLabel setFont:titleFont];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [_titleLabel setShadowColor:[UIColor blackColor]];
    [_titleLabel setShadowOffset:CGSizeMake(1, 1)];
    _titleLabel.frame=CGRectMake(0, 0, 100, 50);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navItem setTitleView:_titleLabel];
    
    _navItem.title = @"";
    
    if(_url)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

- (IBAction)closeButtonPressed:(id)sender
{
    if(_closeButtonPressedBlock)
    {
        _closeButtonPressedBlock();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"delegate"];
    [self removeObserver:self forKeyPath:@"url"];
}

- (void) observeValueForKeyPath:(NSString*) keyPath ofObject:(id) object change:(NSDictionary*) change context:(void*) context
{
    if ([keyPath isEqualToString:@"delegate"] && object == _webView)
    {
        _webView.delegate = self;
    }
    else if([keyPath isEqualToString:@"url"] && object == self)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

#pragma mark - @protocol(UIWebViewDelegate)

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [_delegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        return [_delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _titleLabel.text = [NSLocalizedString(@"Loading", nil) stringByAppendingString:@"..."];
    
    if([_delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [_delegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];;
    
    if([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [_delegate webViewDidFinishLoad:webView];
    }
}

@end
