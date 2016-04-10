//
//  ArtboardPreviewController.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtboardPreviewController : NSObject

- (instancetype)initWithContext:(id)context;
- (NSString *)string;
- (void)launch;

@end
