//
//  CMD.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMD : NSObject

@property (nonatomic, copy) NSString *cd;  // default to [[NSBundle mainBundle] resourcePath]

- (void)exec:(NSString *)command;

@end
