//
//  PhotoThumbController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PhotoThumb.h"
#import "OrderDetailsController.h"
#define IS_WIDESCREEN (fabs ((double) [[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)

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
    UIImageView * bigPhoto;
    UIButton * bigPhotoButton;
    if(IS_WIDESCREEN == NO) {
        bigPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
        bigPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
    }
    else {
        bigPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 503)];
        bigPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 503)];
    }
    
    [bigPhoto setImage:_image];
    
    [bigPhotoButton addTarget:_photoView action:@selector(closePhoto) forControlEvents:UIControlEventTouchUpInside];
    _photoView.fullScreenPhotoButton = bigPhotoButton;
    _photoView.fullScreenPhoto = bigPhoto;
    [_photoView.view addSubview: _photoView.fullScreenPhoto];
    [_photoView.view addSubview: _photoView.fullScreenPhotoButton];
}

- (IBAction)removePhoto:(id)sender {
    [_photoView removeImage: _index];
}
@end
