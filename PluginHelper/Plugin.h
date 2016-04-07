//
//  Plugin.h
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manifest.h"

typedef void(^PluginUpdateManifestHandler)(Manifest **manifest);

@interface Plugin : NSObject

@property (nonatomic, strong, readonly) NSBundle *bundle;
@property (nonatomic, copy, readonly) NSString *pluginPath;         //  .../Plugin.sketchplugin
@property (nonatomic, copy, readonly) NSString *manifestPath;       //  .../Plugin.sketchplugin/Contents/Sketch/manifest.json
@property (nonatomic, copy, readonly) NSString *sketchPath;         //  .../Plugin.sketchplugin/Contents/Sketch
@property (nonatomic, copy, readonly) NSString *contentsPath;       //  .../Plugin.sketchplugin/Contents/
@property (nonatomic, copy, readonly) Manifest *manifest;

+ (instancetype)pluginWithName:(NSString *)name;
+ (instancetype)pluginWithBundle:(NSBundle *)bundle;

- (void)updateManifest:(PluginUpdateManifestHandler)handler;

@end
