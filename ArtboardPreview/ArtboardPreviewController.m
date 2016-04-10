//
//  ArtboardPreviewController.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "ArtboardPreviewController.h"
#import <Cocoa/Cocoa.h>

@interface ArtboardPreviewController ()

@property (nonatomic, strong) NSWindowController *controller;
@property (nonatomic, strong) id context;

@end

@implementation ArtboardPreviewController

- (instancetype)initWithContext:(id)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (void)launch {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"ArtboardPreview" bundle:[NSBundle bundleForClass:[self class]]];
    NSWindowController *controller = [storyboard instantiateInitialController];
    [controller showWindow:self];
    _controller = controller;
}

- (NSString *)string {
    return @"dfsafsd";
}

@end
