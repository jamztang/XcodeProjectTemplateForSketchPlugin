//
//  Plugin.h
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manifest.h"

@interface Plugin : NSObject

@property (nonatomic, copy, readonly) Manifest *manifest;

+ (instancetype)pluginWithName:(NSString *)name;
- (void)writeToPath:(NSString *)path;

@end
