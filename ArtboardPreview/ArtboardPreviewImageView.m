//
//  ArtboardPreviewImageView.m
//  PluginController
//
//  Created by James Tang on 11/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "ArtboardPreviewImageView.h"

@interface ArtboardPreviewImageView ()

@property (nonatomic, assign) CGSize intrinsicContentSize;

@end

@implementation ArtboardPreviewImageView

- (void)setImage:(NSImage *)image {
    [super setImage:image];
    CGRect mainScreen = [[NSScreen mainScreen] frame];
    CGFloat maxWidth = mainScreen.size.width / 3;
    CGFloat ratio = image.size.height / image.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, maxWidth * ratio);
    self.window.contentAspectRatio = maxSize;
    [self.window setContentSize:CGSizeApplyAffineTransform(maxSize, CGAffineTransformMakeScale(0.5, 0.5))];
}

@end
