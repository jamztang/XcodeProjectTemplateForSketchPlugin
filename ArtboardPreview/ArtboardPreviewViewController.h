//
//  ArtboardPreviewViewController.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArtboardImageView.h"

@interface ArtboardPreviewViewController : NSViewController

@property (weak) IBOutlet NSView <ArtboardImageView> *imageView;

@property (nonatomic, strong) NSImage *image;

@end
