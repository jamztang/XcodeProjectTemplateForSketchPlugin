//
//  COScript.h
//  PluginController
//
//  Created by James Tang on 8/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COScript : NSObject

+ (void)execute:(NSString *)arg;
+ (void)executeWithArgs:(NSArray *)args;

@end
