//
//  ArtboardImageView.h
//  PluginController
//
//  Created by James Tang on 11/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

@protocol ArtboardImageView <NSObject>

@property (nonatomic, strong) NSImage *image;
@property CGRect bounds;

@end

@interface ArtboardImageView : NSView <ArtboardImageView>

@property (nonatomic, strong) NSImage *image;
@property CGRect bounds;

@end
