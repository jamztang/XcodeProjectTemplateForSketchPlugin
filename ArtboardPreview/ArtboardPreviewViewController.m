//
//  ArtboardPreviewViewController.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "ArtboardPreviewViewController.h"
#import "ArtboardImageView.h"

@implementation ArtboardPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view mouseDownCanMoveWindow]
//    [self.view.window setMovableByWindowBackground:YES];
}

- (void)setImage:(NSImage *)image {
    _image = image;
    [self reloadData];
}

- (void)reloadData {
    NSImage *image = _image;
    _imageView.image = image;

    CGRect mainScreen = [[NSScreen mainScreen] frame];
    CGFloat maxWidth = mainScreen.size.width / 4;
    CGFloat ratio = _image.size.height / _image.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, maxWidth * ratio);

    CGRect frame = self.view.window.frame;
    [self.view.window setFrame:NSMakeRect(frame.origin.x, frame.origin.y, maxSize.width, maxSize.height) display:YES animate:YES];

}

@end
