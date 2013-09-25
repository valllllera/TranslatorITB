//
//  PhotoThumbController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PhotoThumb.h"
#import "OrderDetailsController.h"

@implementation PhotoThumb

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)viewFullPhoto:(id)sender {
    UIButton * bigPhoto = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [bigPhoto setBackgroundImage:_image forState:UIControlStateNormal];
    [bigPhoto addTarget:_photoView action:@selector(closePhoto) forControlEvents:UIControlEventTouchUpInside];
    _photoView.fullScreenPhoto = bigPhoto;
    [_photoView.view addSubview: _photoView.fullScreenPhoto];
}

- (IBAction)removePhoto:(id)sender {
    [_photoView removeImage: _index];
}
@end
