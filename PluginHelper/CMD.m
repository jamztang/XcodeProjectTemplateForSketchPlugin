//
//  CMD.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "CMD.h"

@interface CMD ()

@property (nonatomic, copy) NSString *exports;

@end

@implementation CMD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exports = @"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        self.cd = [[NSBundle mainBundle] resourcePath];
    }
    return self;
}

- (void)setCd:(NSString *)cd {
    _cd = [cd copy];
}

- (NSString *)exec:(NSString *)command {
    NSArray *tokens = [command componentsSeparatedByString:@" "];
    NSString *binary = [tokens firstObject];

    NSPipe *pipe = [NSPipe pipe];

    NSArray *exports = [_exports componentsSeparatedByString:@":"];
    exports = [exports arrayByAddingObject:self.cd];

    NSTask *task = [[NSTask alloc] init];
    [task setStandardOutput:pipe];
    [task setStandardError:pipe];

    __block NSString *launchPath;
    [exports enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [obj stringByAppendingPathComponent:binary];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            launchPath = path;
            *stop = YES;
        }
    }];
    NSLog(@"CMD: cd %@", self.cd);
    [task setCurrentDirectoryPath:self.cd];

    NSLog(@"CMD: launchPath %@", launchPath);
    
    [task setLaunchPath:launchPath];


    if ([tokens count] >= 2) {
        [task setArguments:[tokens subarrayWithRange:NSMakeRange(1, [tokens count] - 1)]];
    }
    [task launch];
    [task waitUntilExit];

    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

@end
