//
//  AppDelegate.m
//  PluginController
//
//  Created by James Tang on 7/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "AppDelegate.h"
@import SketchSnippets;

@interface AppDelegate () <NSComboBoxDelegate, NSComboBoxDataSource>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) SketchSnippetsApp *sketchSnippetsApp;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

}
- (IBAction)snippetsButtonDidPress:(id)sender {
    _sketchSnippetsApp = [[SketchSnippetsApp alloc] init];
    [_sketchSnippetsApp launch];
}

@end
