//
//  MenuItem.h
//  PluginHelper
//
//  Created by James Tang on 6/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *shortcut;
@property (nonatomic, copy) NSString *script;
@property (nonatomic, copy) NSString *handler;

+ (instancetype)commandWithName:(NSString *)name
                     identifier:(NSString *)identifier
                       shortcut:(NSString *)shortcut
                         script:(NSString *)script
                        handler:(NSString *)handler;

+ (instancetype)commandWithJSON:(NSDictionary *)info;
- (NSDictionary *)json;

@end
