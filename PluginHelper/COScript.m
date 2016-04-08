//
//  COScript.m
//  PluginController
//
//  Created by James Tang on 8/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "COScript.h"
#import "NSString+Binary.h"

@implementation COScript

+ (void)execute:(NSString *)arg {
    [[[NSBundle mainBundle] resourcePath] execute:@"coscript"
                                        arguments:@[arg]];
}

+ (void)executeWithArgs:(NSArray *)args {
    [[[NSBundle mainBundle] resourcePath] execute:@"coscript"
                                        arguments:args];
}

@end
