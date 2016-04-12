//
//  ArtboardImageView.m
//  PluginController
//
//  Created by James Tang on 11/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

@import Quartz;
@import WebKit;
#import "ArtboardImageView.h"

@interface ArtboardImageView ()

@property (nonatomic, strong) IKImageView *imageView;
@property (nonatomic, strong) NSPanGestureRecognizer *panningRecognizer;

@end

@implementation ArtboardImageView


- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _imageView = [[IKImageView alloc] initWithFrame:self.bounds];
//    _imageView.backgroundColor = [NSColor clearColor];
//    [_imageView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_imageView setAutoresizes:YES];
    [_imageView setDoubleClickOpensImageEditPanel:YES];
    [self addSubview:_imageView];

//    _panningRecognizer = [[NSPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [_imageView addGestureRecognizer:_panningRecognizer];
};

- (NSSize)intrinsicContentSize {
//    CGFloat maxWidth = mainScreen.size.width / 4;
//    CGFloat ratio = _image.size.height / _image.size.width;
//    CGSize maxSize = CGSizeMake(maxWidth, maxWidth * ratio);
//    return maxSize;
    return _image.size;
}

- (void)setImage:(NSImage *)image {
    _image = image;
    NSRect imageRect = NSMakeRect(0, 0, image.size.width, image.size.height);
    CGImageRef cgImage = [image CGImageForProposedRect:&imageRect context:NULL hints:nil];
    [_imageView setImage:cgImage imageProperties:nil];
}

- (void)keyDown:(NSEvent *)theEvent {
    NSLog(@"keyDown: %@", theEvent);
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];

    if ([theEvent keyCode] == 49) {
        [_imageView setCurrentToolMode:IKToolModeMove];
    }
}

- (void)keyUp:(NSEvent *)theEvent {
    NSLog(@"keyDown: %@", theEvent);
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
    if ([theEvent keyCode] == 49) {
        [_imageView setCurrentToolMode:IKToolModeNone];
    }
}

@end
