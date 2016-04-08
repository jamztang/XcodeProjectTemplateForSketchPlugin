//
//  NSString+Binary.m
//  PluginController
//
//  Created by James Tang on 7/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "NSString+Binary.h"

@implementation NSString (Binary)

- (void)execute:(NSString *)binary arguments:(NSArray *)arguments {
    NSTask *task = [[NSTask alloc] init];
    NSString *filePath = [self stringByAppendingPathComponent:binary];
    [task setLaunchPath:filePath];
    [task setCurrentDirectoryPath:self];
    [task setArguments:arguments];

//    NSLog(@"filePath %@", filePath);
    [task launch];
    [task waitUntilExit];
}

@end
