//
//  PluginControllerTests.m
//  PluginControllerTests
//
//  Created by James Tang on 7/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <XCTest/XCTest.h>
@import PluginHelper;

@interface PluginControllerTests : XCTestCase

@property (nonatomic, strong) COScript *command;
@property (nonatomic, strong) id context;
@property (nonatomic, copy) NSString *identifier;

@end

@implementation PluginControllerTests

- (void)setUp {
    [super setUp];
    _command = [[COScript alloc] init];
    _identifier = [_command execJS:@"putContext.js" forTarget:@"Sketch" output:[@"~/Desktop/Untitled.js" stringByExpandingTildeInPath]];
    _context = [[[NSThread currentThread] threadDictionary] objectForKey:_identifier];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [[[NSThread currentThread] threadDictionary] removeObjectForKey:_identifier];
}

- (void)testContextNotNil {
    XCTAssertNotNil(_identifier);
}

@end
