//
//  NSString+Binary.h
//  PluginController
//
//  Created by James Tang on 7/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Binary)

- (void)execute:(NSString *)binary arguments:(NSArray *)arguments;

@end
