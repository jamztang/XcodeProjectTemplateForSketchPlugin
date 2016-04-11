//
//  COScript.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COScript : NSObject

- (NSString *)execJS:(NSString *)jsFile forTarget:(NSString *)target output:(NSString *)output;

- (NSString *)exec:(NSString *)code forTarget:(NSString *)target output:(NSString *)output;

@end
