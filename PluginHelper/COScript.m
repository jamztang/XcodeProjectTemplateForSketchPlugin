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

- (NSString *)execJS:(NSString *)jsFile forTarget:(NSString *)target output:(NSString *)output {

    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:jsFile ofType:nil]
                                          options:0 error:nil];
    NSString *code = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return [self exec:code forTarget:target output:output];
}

- (NSString *)exec:(NSString *)code forTarget:(NSString *)target output:(NSString *)output {
    code = [code stringByReplacingOccurrencesOfString:@"./" withString:[[output stringByDeletingLastPathComponent] stringByAppendingString:@"/"]];
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\n"];
    code = [code stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];

//    NSLog(@"File generated at `%@`", [[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil]);
    NSString *template = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"codeToRun.js" ofType:nil]
                                               usedEncoding:nil
                                                      error:nil];

    NSString *merged = [NSString stringWithFormat:template, code, target];

    NSData *data = [merged dataUsingEncoding:NSUTF8StringEncoding];
    if ([data writeToFile:output
               atomically:YES]) {
//        NSLog(@"✅ wrote file to output %@", output);
    } else {
        NSLog(@"❌ failed to write file to output %@", output);
    }

    NSString *response = [_command exec:[NSString stringWithFormat:@"coscript %@", output]];

    return [response substringToIndex:[response length] - 2];

}

@end
