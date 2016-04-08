//
//  AppDelegate.m
//  PluginController
//
//  Created by James Tang on 7/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "AppDelegate.h"
@import PluginHelper;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

}

- (IBAction)logToConsoleButtonDidPress:(id)sender {
    [COScript execute:@"logToConsole.js"];
}

- (IBAction)showMessageButtonDidPress:(id)sender {
    [COScript execute:@"showMessage.js"];
}

@end
