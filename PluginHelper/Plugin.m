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
//@property (nonatomic, copy) NSString *pluginPath;
//@property (nonatomic, copy) NSString *manifestPath;
//@property (nonatomic, copy) NSString *sketchPath;
//@property (nonatomic, copy) NSString *contentsPath;

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
}

//
//- (NSString *)description {
//    NSBundle *bundle = _bundle;
//    NSDictionary *info = @{
//                           @"exec": [bundle executablePath],
//                           @"resource": [bundle resourcePath],
//                           @"private": [bundle privateFrameworksURL],
//                           @"current": _pluginPath,
//                           @"sketch": _sketchPath,
//                           @"contents": _contentsPath,
//                           @"manifest": _manifestPath,
//                           };
//    return [info description];
//}
//
//- (void)removeManifestJSON {
//    [[NSFileManager defaultManager] removeItemAtPath:_manifestPath error:nil];
//}
//
//- (void)installManifestJSON {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:self.manifest.json
//                                                   options:NSJSONWritingPrettyPrinted
//                                                     error:nil];
//    BOOL createdDirectory = [[NSFileManager defaultManager] createDirectoryAtPath:_sketchPath withIntermediateDirectories:NO attributes:nil error:nil];
//
//    NSLog(@"createdDirectory %d", createdDirectory);
//    BOOL success = [[NSFileManager defaultManager] createFileAtPath:_manifestPath contents:data attributes:nil];
//    if (success) {
//        NSLog(@"generated manifest.json at %@", _manifestPath);
//    } else {
//        NSLog(@"failed to generated manifest.json at %@", self.manifestPath );
//        NSLog(@"shoud be %@", [_pluginPath stringByAppendingString:@"Contents"]);
//    }
//}
//
//- (void)updateManifest:(PluginUpdateManifestHandler)handler {
//    Manifest *manifest = self.manifest;
//    if (handler) {
//        handler(&manifest);
//    }
//    [self installManifestJSON];
//}
//
@end
