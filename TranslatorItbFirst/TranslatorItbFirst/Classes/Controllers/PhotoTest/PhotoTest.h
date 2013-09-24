//
//  PhotoTest.h
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoThumb.h"


@interface PhotoTest : UIViewController

@property (strong, nonatomic) NSMutableArray * photoIcons;
- (void) showPhotoThumbs;
- (IBAction)addPhoto:(id)sender;
- (void) removeImage: (int) index;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewOutlet;
@end
