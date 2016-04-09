//
//  SketchSnippetsApp.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "SketchSnippetsApp.h"
#import <AppKit/AppKit.h>

@interface SketchSnippetsApp ()

@property (nonatomic, strong) NSWindowController *windowController;

@end


@implementation SketchSnippetsApp

- (void)launch {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"SketchSnippets" bundle:[NSBundle bundleForClass:[self class]]];

    NSWindowController *windowController = [storyboard instantiateInitialController];

    [windowController showWindow:self];
    _windowController = windowController;

}
@end
