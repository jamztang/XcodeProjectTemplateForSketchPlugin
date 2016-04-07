//
//  MenuItem.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "Command.h"

@implementation Command

+ (instancetype)commandWithJSON:(NSDictionary *)info {
    Command *command = [self commandWithName:info[@"name"]
                                  identifier:info[@"identifier"] shortcut:info[@"shortcut"]
                                      script:info[@"script"]
                                     handler:info[@"handler"]];
    return command;
}

+ (instancetype)commandWithName:(NSString *)name identifier:(NSString *)identifier shortcut:(NSString *)shortcut script:(NSString *)script handler:(NSString *)handler {
    Command *command = [[Command alloc] init];
    command.name = name;
    command.identifier = identifier;
    command.shortcut = shortcut;
    command.script = script;
    command.handler = handler;
    return command;
}

- (NSDictionary *)json {
    return @{
             @"name":self.name ?: @"",
             @"identifier":self.identifier ?: @"",
             @"shortcut":self.shortcut ?: @"",
             @"script":self.script ?: @"",
             @"handler":self.handler ?: @"",
             };
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Command *command = object;
        if (
            [command.name isNotEqualTo:self.name]
            || [command.identifier isNotEqualTo:self.identifier]
            || [command.shortcut isNotEqualTo:self.shortcut]
            || [command.script isNotEqualTo:self.script]
            || [command.handler isNotEqualTo:self.handler]
            ) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

@end
