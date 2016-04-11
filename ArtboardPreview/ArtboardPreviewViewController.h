//
//  ArtboardPreviewViewController.h
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ArtboardPreviewViewController : NSViewController

@property (weak) IBOutlet NSImageView *imageView;

@property (nonatomic, strong) NSImage *image;

@end
