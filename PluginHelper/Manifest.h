//
//  ManifestGenerator.h
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Command;

@interface Manifest : NSObject

@property (nonatomic, copy) NSString *name; // CFBundleName
@property (nonatomic, copy) NSString *version; //CFBundleShortVersionString
@property (nonatomic, copy) NSString *build; // CFBundleVersion
@property (nonatomic, copy) NSString *identifier; // CFBundleIdentifier

@property (nonatomic, copy) NSString *desc; // SketchPluginDescription
@property (nonatomic, copy) NSString *author; // SketchPluginAuthor
@property (nonatomic, copy) NSString *email; // SketchPluginEmail
@property (nonatomic, copy) NSString *homepage; //SketchPluginHomepage
@property (nonatomic, copy) NSArray <Command *> *commands;

+ (instancetype)manifestForJSON:(NSDictionary *)json;
+ (instancetype)manifestForInfo:(NSDictionary *)info;
+ (instancetype)manifestForBundle:(NSBundle *)bundle;

- (NSDictionary *)json;
- (void)installCommands:(NSArray <Command *> *)commands;

@end
