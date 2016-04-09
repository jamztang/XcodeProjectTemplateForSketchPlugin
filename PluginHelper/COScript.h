//
//  COScript.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COScript : NSObject

- (void)exec:(NSString *)code forTarget:(NSString *)target output:(NSString *)output;

@end
