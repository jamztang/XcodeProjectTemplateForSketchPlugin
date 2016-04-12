//
//  ArtboardPreviewImageView.m
//  PluginController
//
//  Created by James Tang on 11/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "ArtboardPreviewImageView.h"

@interface ArtboardPreviewImageView ()

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, strong) NSClickGestureRecognizer *clickRecognizer;
//@property (nonatomic) CGSize intrinsicContentSize;

@end

@implementation ArtboardPreviewImageView


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
    _scrollView = [[NSScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [NSColor lightGrayColor];
    _imageView = [[NSImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    [_imageView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [_scrollView addSubview:_imageView];

    [_scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];

    [_scrollView setHasVerticalScroller:YES];
    [_scrollView setHasHorizontalScroller:YES];
    [_scrollView setDocumentView:_imageView];
    [_scrollView setAllowsMagnification:YES];
    [_scrollView setMinMagnification:1.0];


    _clickRecognizer = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick:)];
    [_clickRecognizer setNumberOfClicksRequired:2];
    [_imageView addGestureRecognizer:_clickRecognizer];
};

- (void)setImage:(NSImage *)image {
    _image = image;
    self.imageView.image = image;
//    self.imageView.frame = CGRectMake(0, 0, _image.size.width, _image.size.height);

}

- (void)handleClick:(NSClickGestureRecognizer *)click {
    if (_scrollView.magnification != 1) {
        [_scrollView animator].magnification = 1;
        [[_scrollView animator] magnifyToFitRect:self.imageView.bounds];
    } else if (_scrollView.magnification == 1) {
        [_scrollView animator].magnification = 3;
//        [_scrollView magnifyToFitRect:self.imageView.bounds];
    }
}



@end
