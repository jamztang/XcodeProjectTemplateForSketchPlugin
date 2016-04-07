//
//  PluginTests.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Plugin.h"
#import "Command.h"

@interface PluginTests : XCTestCase

@property (nonatomic, strong) Plugin *plugin;

@end

@implementation PluginTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    _plugin = [Plugin pluginWithName:@"Plugin.sketchplugin"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPluginExists {
    XCTAssertNotNil(_plugin);
}

- (void)testReadingManifest {
    XCTAssertNotNil(_plugin.manifest);
    XCTAssertEqualObjects(_plugin.manifest.version, @"1.0");
    XCTAssertEqualObjects(_plugin.manifest.name, @"Plugin");
    XCTAssertEqualObjects(_plugin.manifest.email, @"james@magicmirror.design");
    XCTAssertEqualObjects(_plugin.manifest.author, @"James Tang");
    XCTAssertEqualObjects(_plugin.manifest.homepage, @"http://magicmirror.design");
    XCTAssertEqualObjects(_plugin.manifest.desc, @"Sketch Plugin Template");

    Command *command1 = [_plugin.manifest.commands firstObject];
    XCTAssertEqualObjects(command1, [Command commandWithName:@"Run"
                                                                     identifier:@"run"
                                                                       shortcut:@"cmd shift r"
                                                                         script:@"main.js"
                                                                        handler:@"run"]);
}

- (void)testPluginPathExists {
    BOOL isDirectory;
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[_plugin pluginPath] isDirectory:&isDirectory]);
    XCTAssertTrue(isDirectory);
}

- (void)testIsContentsPathCorrect {
    BOOL isDirectory;
    XCTAssertEqualObjects([[_plugin contentsPath] stringByReplacingOccurrencesOfString:[_plugin pluginPath]
                                                                            withString:@""], @"/Contents");
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[_plugin contentsPath] isDirectory:&isDirectory]);
    XCTAssertTrue(isDirectory);
}

- (void)testIsSketchPathCorrect {
    BOOL isDirectory;
    XCTAssertEqualObjects([[_plugin sketchPath] stringByReplacingOccurrencesOfString:[_plugin pluginPath]
                                                                            withString:@""], @"/Contents/Sketch");
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[_plugin sketchPath] isDirectory:&isDirectory]);
    XCTAssertTrue(isDirectory);
}

- (void)testIsManifestPathCorrect {
    BOOL isDirectory;
    XCTAssertEqualObjects([[_plugin manifestPath] stringByReplacingOccurrencesOfString:[_plugin pluginPath]
                                                                            withString:@""], @"/Contents/Sketch/manifest.json");
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[_plugin manifestPath] isDirectory:&isDirectory]);
    XCTAssertFalse(isDirectory);
}

- (void)testInitial {
    XCTAssertNotNil(_plugin);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:_plugin.manifestPath]);
}

- (void)testUpdatingManifestJSON {
    [_plugin updateManifest:^(Manifest *__autoreleasing *manifest) {
        [*manifest setVersion:@"2.0"];
    }];
    NSData *data = [NSData dataWithContentsOfFile:_plugin.manifestPath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                          options:0
                                                           error:nil];
    XCTAssertEqualObjects(json[@"version"], @"2.0");
}

@end
