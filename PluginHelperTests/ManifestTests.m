//
//  ManifestGeneratorTests.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Manifest.h"
#import "Command.h"
@interface ManifestTests : XCTestCase

@property (strong, nonatomic) Manifest *manifest;
@property (copy, nonatomic) NSDictionary *info;
@property (copy, nonatomic) NSArray *commands;

@end

@implementation ManifestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    _commands = @[
                      @{
                          @"name":@"Command 1",
                          @"shortcut": @"cmd shift c",
                          @"identifier": @"command1",
                          @"script": @"main.js",
                          @"handler": @"command1",
                          },
                      ];
    _info = @{
              @"CFBundleName":@"Sketch Plugin",
              @"CFBundleVersion":@"1.0",
              @"CFBundleShortVersionString":@"1",
              @"CFBundleIdentifier":@"design.magicmirror.plugin",
              @"SketchPluginDescription":@"desc",
              @"SketchPluginAuthor":@"James Tang",
              @"SketchPluginEmail":@"james@magicmirror.design",
              @"SketchPluginHomepage":@"http://magicmirror.design",
              @"commands": _commands,
              };
    _manifest = [Manifest manifestForInfo:_info];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitial {
    XCTAssertEqualObjects(_manifest.name, _info[@"CFBundleName"]);
    XCTAssertEqualObjects(_manifest.version, _info[@"CFBundleShortVersionString"]);
    XCTAssertEqualObjects(_manifest.build, _info[@"CFBundleVersion"]);
    XCTAssertEqualObjects(_manifest.identifier, _info[@"CFBundleIdentifier"]);
}

- (void)testCustom {
    XCTAssertEqualObjects(_manifest.desc, _info[@"SketchPluginDescription"]);
    XCTAssertEqualObjects(_manifest.author, _info[@"SketchPluginAuthor"]);
    XCTAssertEqualObjects(_manifest.email, _info[@"SketchPluginEmail"]);
    XCTAssertEqualObjects(_manifest.homepage, _info[@"SketchPluginHomepage"]);
}

- (void)testJSON {
    NSDictionary *json = [_manifest json];
    XCTAssertEqualObjects(json[@"name"], _manifest.name);
    XCTAssertEqualObjects(json[@"version"], _manifest.version);
    XCTAssertEqualObjects(json[@"build"], _manifest.build);
    XCTAssertEqualObjects(json[@"identifier"], _manifest.identifier);
    XCTAssertEqualObjects(json[@"description"], _manifest.desc);
    XCTAssertEqualObjects(json[@"author"], _manifest.author);
    XCTAssertEqualObjects(json[@"email"], _manifest.email);
    XCTAssertEqualObjects(json[@"homepage"], _manifest.homepage);
}

- (void)testJSONCommands {
    NSDictionary *json = [_manifest json];
    XCTAssertEqual([json[@"commands"] count], 1);
    XCTAssertEqualObjects(json[@"commands"], _commands);
}

- (void)testRemoveCommands {
    [_manifest installCommands:nil];
    NSArray *commands = _manifest.json[@"commands"];
    XCTAssertEqual([commands count], 0);
}

- (void)testInstallNewCommands {
    Command *command = [Command commandWithName:@"Command 2"
                                     identifier:@"command2"
                                       shortcut:@"cmd shift 2"
                                         script:@"main.js"
                                        handler:@"command2"];
    [_manifest installCommands:@[command]];
    NSArray *commands = _manifest.json[@"commands"];
    XCTAssertEqual([commands count], 1);
}

- (void)testInstallCommands {
    Command *command = [Command commandWithName:@"Command 1"
                                     identifier:@"command1"
                                       shortcut:@"cmd shift c"
                                         script:@"main.js"
                                        handler:@"command1"];

    [_manifest installCommands:@[ command ]];

    NSArray *commands = _manifest.json[@"commands"];
    Command *serializedCommand = [Command commandWithJSON:[commands firstObject]];
    XCTAssertEqualObjects(serializedCommand, command);
}

- (void)testMenuTitle {
    NSDictionary *menu = _manifest.json[@"menu"];
    XCTAssertEqualObjects(menu[@"title"], _manifest.name);
}

- (void)testMenuCommand {
    Command *command1 = [Command commandWithName:@"Command 1"
                                     identifier:@"command1"
                                       shortcut:@"cmd shift c"
                                         script:@"main.js"
                                        handler:@"command1"];

    Command *command2 = [Command commandWithName:@"Command 2"
                                     identifier:@"command2"
                                       shortcut:@"cmd shift d"
                                         script:@"main.js"
                                        handler:@"command2"];

    [_manifest installCommands:@[ command1, command2 ]];

    NSDictionary *menu = _manifest.json[@"menu"];
    NSArray *expected = @[ @"command1", @"command2" ];
    NSArray *items = menu[@"items"];
    XCTAssertEqualObjects(items, expected);
}

- (void)testIsRoot {
    NSDictionary *menu = _manifest.json[@"menu"];
    NSArray *expected = @[ @"command1", @"command2" ];
    NSNumber *root = menu[@"isRoot"];
    XCTAssertEqualObjects(root, @NO);
}

@end
