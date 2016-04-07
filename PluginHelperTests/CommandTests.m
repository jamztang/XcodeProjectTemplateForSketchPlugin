//
//  CommandTests.m
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Command.h"

@interface CommandTests : XCTestCase

@property (nonatomic, strong) Command *command;
@property (nonatomic, strong) Command *command2;

@end

@implementation CommandTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    _command = [Command commandWithName:@"name"
                             identifier:@"id"
                               shortcut:@"shortcut"
                                 script:@"script"
                                handler:@"handler"];

    _command2 = [Command commandWithJSON:@{
                                           @"name":@"name",
                                           @"identifier":@"id",
                                           @"shortcut":@"shortcut",
                                           @"script":@"script",
                                           @"handler":@"handler",
                                           }];
}

- (void)testCompare {
    XCTAssertEqualObjects(_command.name, _command2.name);
    XCTAssertEqualObjects(_command.identifier, _command2.identifier);
    XCTAssertEqualObjects(_command.shortcut, _command2.shortcut);
    XCTAssertEqualObjects(_command.script, _command2.script);
    XCTAssertEqualObjects(_command.handler, _command2.handler);
    XCTAssertEqualObjects(_command, _command2);
}

@end
