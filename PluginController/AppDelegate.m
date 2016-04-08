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

@property (weak) IBOutlet NSTextField *codeTextField;
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

- (IBAction)executeButtonDidPress:(id)sender {
    NSString *code = _codeTextField.cell.title;

    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\n"];
    code = [code stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    code = [NSString stringWithFormat:@"%@\n\"%@\"\n%@", @"var codeToRun = ", code, @";\nvar sketchApp = COScript.app(\"Sketch\")\n sketchApp.delegate().runPluginScript_name(codeToRun, \"coscript Demo\")"];

    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    NSString *output = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Untitled.js"];
    [data writeToFile:output
           atomically:YES];

    [COScript execute:@"Untitled.js"];
}

@end
