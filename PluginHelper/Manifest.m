//
//  ManifestGenerator.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "Manifest.h"
#import "Command.h"

@interface Manifest ()
@end

@implementation Manifest

+ (instancetype)manifestForJSON:(NSDictionary *)json {
    Manifest *manifest = [[Manifest alloc] initWithJSON:json];
    return manifest;
}

+ (instancetype)manifestForInfo:(NSDictionary *)info {
    Manifest *manifest = [[Manifest alloc] initWithInfo:info];
    return manifest;
}

+ (instancetype)manifestForBundle:(NSBundle *)bundle {
    Manifest *manifest = [[Manifest alloc] initWithBundle:bundle];
    return manifest;
}

- (instancetype)initWithBundle:(NSBundle *)bundle {
    if (self = [self initWithInfo:[bundle infoDictionary]]) {
    }
    return self;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    if (self = [super init]) {
        _name = [json[@"name"] copy];
        _version = [json[@"version"] copy];
        _build = [json[@"build"] copy];
        _identifier = [json[@"identifier"] copy];
        _desc = [json[@"description"] copy];
        _author = [json[@"author"] copy];
        _email = [json[@"email"] copy];
        _homepage = [json[@"homepage"] copy];
        __block NSMutableArray *commands = [NSMutableArray array];
        [json[@"commands"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Command *command = [Command commandWithJSON:obj];
            [commands addObject:command];
        }];
        _commands = [commands copy];
    }
    return self;
}

- (instancetype)initWithInfo:(NSDictionary *)info {
    if (self = [super init]) {
        _name = [info[@"CFBundleName"] copy];
        _version = [info[@"CFBundleShortVersionString"] copy];
        _build = [info[@"CFBundleVersion"] copy];
        _identifier = [info[@"CFBundleIdentifier"] copy];
        _desc = [info[@"SketchPluginDescription"] copy];
        _author = [info[@"SketchPluginAuthor"] copy];
        _email = [info[@"SketchPluginEmail"] copy];
        _homepage = [info[@"SketchPluginHomepage"] copy];
        _commands = [info[@"commands"] copy];
    }
    return self;
}




- (NSDictionary *)json {

    NSMutableDictionary *menu = [NSMutableDictionary dictionary];

    [menu addEntriesFromDictionary:@{ @"isRoot": @NO }];
    if (self.name) {
        [menu addEntriesFromDictionary:@{ @"title" : self.name }];
    }
    if ([self.commands count]) {
        [menu addEntriesFromDictionary:@{ @"items" : [self.commands valueForKey:@"identifier"] }];
    }
    return @{
             @"name": self.name ?: @"",
             @"version": self.version ?: @"",
             @"build": self.build ?: @"",
             @"identifier": self.identifier ?: @"",
             @"description": self.desc ?: @"",
             @"author": self.author ?: @"",
             @"email": self.email ?: @"",
             @"homepage": self.homepage ?: @"",
             @"commands": self.commands ?: @[],
             @"menu": [menu copy]
             };
}

- (void)installCommands:(NSArray<Command *> *)commands {
    self.commands = [commands valueForKey:@"json"];
}

@end
