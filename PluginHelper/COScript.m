//
//  COScript.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "COScript.h"
#import "CMD.h"

@interface COScript ()

@property (nonatomic, strong) CMD *command;

@end


@implementation COScript

- (instancetype)init
{
    self = [super init];
    if (self) {
        _command = [[CMD alloc] init];
    }
    return self;
}

- (void)exec:(NSString *)code forTarget:(NSString *)target output:(NSString *)output {
    code = [code stringByReplacingOccurrencesOfString:@"./" withString:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/"]];
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\n"];
    code = [code stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];

    NSLog(@"File generated at `%@`", [[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil]);
    NSString *template = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"codeToRun.js" ofType:nil]
                                               usedEncoding:nil
                                                      error:nil];

    NSString *merged = [NSString stringWithFormat:template, code, target];

    NSData *data = [merged dataUsingEncoding:NSUTF8StringEncoding];
    if ([data writeToFile:output
               atomically:YES]) {

    }

    NSLog(@"%@", [_command exec:@"coscript Untitled.js"]);
    [_command exec:code];
    
}

@end
