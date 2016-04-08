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
    code = [code stringByReplacingOccurrencesOfString:@"./" withString:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/"]];
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\n"];
    code = [code stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];

    NSLog(@"File generated at `%@`", [[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil]);
    NSString *template = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"codeToRun.js" ofType:nil]
                                               usedEncoding:nil
                                                      error:nil];

    NSString *merged = [NSString stringWithFormat:template, code];

    NSData *data = [merged dataUsingEncoding:NSUTF8StringEncoding];
    NSString *output = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Untitled.js"];
    [data writeToFile:output
           atomically:YES];

    [COScript execute:@"Untitled.js"];
}


- (IBAction)commandButtonDidPress:(id)sender {
    {
        NSString *code = _codeTextField.cell.title;
        code = [code stringByReplacingOccurrencesOfString:@"./" withString:[[NSBundle mainBundle] resourcePath]];
        NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
        NSString *output = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Untitled.js"];
        [data writeToFile:output
               atomically:YES];
        NSLog(@"File generated at `%@`", [[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil]);
    }

    {
        NSString *template = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"runAsCommandTemplate.js" ofType:nil]
                                                   usedEncoding:nil
                                                          error:nil];
        NSString *toExecute = [NSString stringWithFormat:template, [[NSBundle mainBundle] pathForResource:@"Plugin.sketchplugin" ofType:nil]];
        NSString *output = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"runAsCommand.js"];
        NSData *data = [toExecute dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:output
               atomically:YES];
        NSLog(@"File generated at `%@`", [[NSBundle mainBundle] pathForResource:@"runAsCommand.js" ofType:nil]);
    }

    [COScript execute:@"runAsCommand.js"];
}

@end
