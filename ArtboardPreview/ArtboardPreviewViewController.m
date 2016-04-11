//
//  ArtboardPreviewViewController.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "ArtboardPreviewViewController.h"

@implementation ArtboardPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setImage:(NSImage *)image {
    _image = image;
    [self reloadData];
}

- (void)reloadData {
    self.imageView.image = _image;

}

@end
