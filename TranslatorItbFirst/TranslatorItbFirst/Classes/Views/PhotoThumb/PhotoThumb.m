//
//  PhotoThumbController.m
//  TranslatorItbFirst
//
//  Created by Konstantin Paschenko on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PhotoThumb.h"
#import "PhotoTest.h"

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
}

- (IBAction)removePhoto:(id)sender {
    [_photoTest removeImage: _index];
}
@end
