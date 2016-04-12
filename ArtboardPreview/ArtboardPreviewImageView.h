//
//  ArtboardPreviewImageView.h
//  PluginController
//
//  Created by James Tang on 11/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ArtboardImageView.h"

@interface ArtboardPreviewImageView : NSView <ArtboardImageView>

@property (nonatomic,strong) NSImage *image;

@end
