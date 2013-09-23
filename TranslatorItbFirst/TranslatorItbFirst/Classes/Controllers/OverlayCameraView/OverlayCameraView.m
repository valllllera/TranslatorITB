//
//  OverlayCameraView.m
//  TranslatorItbFirst
//
//  Created by Андрей on 23.09.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "OverlayCameraView.h"

@implementation OverlayCameraView

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

- (IBAction)backButtonPressed:(id)sender
{
    if(_backButtonPressedBlock)
    {
        _backButtonPressedBlock();
    }
}

@end
