//
//  AboutCompany.h
//  TranslatorItbFirst
//
//  Created by Андрей on 23.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutCompany : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UILabel *clientsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *socnetLbl;
@property (weak, nonatomic) IBOutlet UIButton *vkBtn;
@property (weak, nonatomic) IBOutlet UIButton *fbBtn;
@property (weak, nonatomic) IBOutlet UIButton *twBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

+(void)openSafari:(NSString*)url;

- (IBAction)touchVk:(id)sender;
- (IBAction)touchFb:(id)sender;
- (IBAction)touchTw:(id)sender;




@end
