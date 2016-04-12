//
//  Plugin.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "Plugin.h"

@interface Plugin ()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) Manifest *manifest;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pluginName;
@property (nonatomic, copy) NSString *frameworkName;

@end

@implementation Plugin

+ (instancetype)pluginWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSBundle *bundle = [NSBundle bundleWithPath:path];

    return [self pluginWithBundle:bundle];
}

+ (instancetype)pluginWithBundle:(NSBundle *)bundle {
    Plugin *plugin = [[Plugin alloc] initWithBundle:bundle];
    return plugin;
}

+ (instancetype)pluginWithManifest:(Manifest *)manifest {
    Plugin *plugin = [[Plugin alloc] initWithManifest:manifest];
    return plugin;
}

- (instancetype)initWithBundle:(NSBundle *)bundle {
    NSString *manifestPath = [[bundle bundlePath] stringByAppendingPathComponent:@"Contents/Sketch/manifest.json"];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:manifestPath]
                                                         options:0 error:nil];
    Manifest *manifest = [Manifest manifestForJSON:json];
    if (self = [self initWithManifest:manifest]) {
        _bundle = bundle;
        _name = [[[_bundle bundlePath] lastPathComponent] stringByReplacingOccurrencesOfString:@".sketchplugin" withString:@""];
        _frameworkName = [_name stringByAppendingString:@".framework"];
        _pluginName = [_name stringByAppendingString:@".sketchplugin"];
    }
    return self;
}

- (instancetype)initWithManifest:(Manifest *)manifest {
    if (self = [super init]) {
        _manifest = manifest;
//        _pluginPath = [[[[[[[NSProcessInfo processInfo] arguments][0]
//                         stringByDeletingLastPathComponent]
//                        stringByDeletingLastPathComponent]
//                       stringByDeletingLastPathComponent]
//                      stringByDeletingLastPathComponent]
//                      stringByAppendingPathComponent:[[bundle bundlePath] lastPathComponent]];
//
//        _contentsPath = [_pluginPath stringByAppendingPathComponent:@"Contents"];
//        _sketchPath = [_contentsPath stringByAppendingPathComponent:@"Sketch"];
//        _manifestPath = [_sketchPath stringByAppendingPathComponent:@"manifest.json"];
//        [self installManifestJSON];
    }
    return self;
}

- (void)writeToPath:(NSString *)path {
    [[NSFileManager defaultManager] copyItemAtPath:[_bundle bundlePath]
                                            toPath:path
                                             error:nil];

    NSString *frameworkPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Contents/Frameworks/PluginHelper.framework"];

    [[NSFileManager defaultManager] copyItemAtPath:frameworkPath
                                            toPath:[path stringByAppendingPathComponent:@"Contents/Sketch/PluginHelper.framework"]
                                             error:nil];


    NSString *helper = [[NSBundle mainBundle] pathForResource:@"helper.js" ofType:nil];
    [[NSFileManager defaultManager] copyItemAtPath:helper
                                            toPath:[path stringByAppendingPathComponent:@"Contents/Sketch/helper.js"]
                                             error:nil];

    NSString *library = [[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil];
    [[NSFileManager defaultManager] copyItemAtPath:library
                                            toPath:[path stringByAppendingPathComponent:@"Contents/Sketch/Untitled.js"]
                                             error:nil];


    NSString *codeToRun = [[NSBundle mainBundle] pathForResource:@"codeToRun.js" ofType:nil];
    [[NSFileManager defaultManager] copyItemAtPath:codeToRun
                                            toPath:[path stringByAppendingPathComponent:@"Contents/Sketch/codeToRun.js"]
                                             error:nil];


    NSLog(@"Plugin installed %@", path);
}

- (NSString *)installPath {
    NSString *appSupportPath = [[[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] firstObject] path];
    NSString *pluginFolderPath = [appSupportPath stringByAppendingPathComponent:@"com.bohemiancoding.sketch3/Plugins"];
    return pluginFolderPath;
}

- (void)install {
    [[NSFileManager defaultManager] removeItemAtPath: [[self installPath] stringByAppendingPathComponent:self.pluginName]
                                               error:nil];
    [self writeToPath:[[self installPath] stringByAppendingPathComponent:self.pluginName]];

    NSString *fromPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/Frameworks/%@", _frameworkName]];
    NSString *toPath = [[self installPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/Contents/Sketch/%@", _pluginName, _frameworkName]];

    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:fromPath
                                                           toPath:toPath
                                                            error:&error];

    if (success) {
        NSLog(@"✅ successfullly installe framework %@", @{ @"from": fromPath, @"to": toPath});
    } else {
        BOOL fromExists = [[NSFileManager defaultManager] fileExistsAtPath:fromPath] ;
        BOOL toExists = [[NSFileManager defaultManager] fileExistsAtPath:toPath] ;
        NSLog(@"❌ failed to installe framework %@", @{ @"from" : fromPath , @"to" : toPath});
        NSLog(@"from: %@",  fromExists ? @"✅":@"❌");
        NSLog(@"to: %@",  toExists ? @"✅":@"❌");
        NSLog(@"error: %@", error);

    }
}

@end
