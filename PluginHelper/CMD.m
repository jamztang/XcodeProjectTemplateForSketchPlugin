//
//  CMD.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "CMD.h"

@implementation CMD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cd = [[NSBundle mainBundle] resourcePath];
    }
    return self;
}

- (void)setCd:(NSString *)cd {
    _cd = [cd copy];
}

- (void)exec:(NSString *)command {
    NSArray *tokens = [command componentsSeparatedByString:@" "];
    NSString *binary = [tokens firstObject];

    NSTask *task = [[NSTask alloc] init];
    NSString *filePath = [self.cd stringByAppendingPathComponent:binary];
    [task setLaunchPath:filePath];
    [task setCurrentDirectoryPath:self.cd];
    if ([tokens count] >= 2) {
        [task setArguments:[tokens subarrayWithRange:NSMakeRange(1, [tokens count] - 1)]];
    }
    [task launch];
    [task waitUntilExit];
}

@end
