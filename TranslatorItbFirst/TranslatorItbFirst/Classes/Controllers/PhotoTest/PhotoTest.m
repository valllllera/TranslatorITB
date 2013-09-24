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
    _photoIcons = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showPhotoThumbs {
    NSArray *viewsToRemove = [_scrollViewOutlet subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];
    for (int i = 0; i < [_photoIcons count] ; i++) {
        [[_photoIcons objectAtIndex:i] setFrame: CGRectMake(20 + 70*(i%4), 60*(i/4), 70, 60)];
        [[_photoIcons objectAtIndex:i] setIndex: i];
        [self.scrollViewOutlet addSubview:[_photoIcons objectAtIndex:i]];
    }
}

- (IBAction)addPhoto:(id)sender {
    PhotoThumb * photoThumb = [[NSBundle mainBundle] loadNibNamed:@"PhotoThumb" owner:nil options:nil][0];
    photoThumb.frame = CGRectMake(20 + 70*([_photoIcons count]%4), 60*([_photoIcons count]/4), 70, 60);
    [photoThumb setIndex:[_photoIcons count]];
    NSLog(@"%d", photoThumb.index);
    photoThumb.photoTest = self;
    NSLog(@"%@", self);
    [_photoIcons addObject: photoThumb];
    [self.scrollViewOutlet addSubview:[_photoIcons objectAtIndex:[_photoIcons count]-1]];
}

- (void) removeImage: (int)index {
    [_photoIcons removeObjectAtIndex:index];
    [self showPhotoThumbs];
}

@end
