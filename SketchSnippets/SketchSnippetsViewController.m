//
//  SketchSnippetsViewController.m
//  PluginController
//
//  Created by James Tang on 9/4/2016.
//  Copyright © 2016 Magic Mirror. All rights reserved.
//

#import "SketchSnippetsViewController.h"
@import PluginHelper;

@interface SketchSnippetsViewController () <NSComboBoxDelegate, NSComboBoxDataSource>

@property (weak) IBOutlet NSComboBox *targetComboBox;
@property (weak) IBOutlet NSComboBox *snippetCombobox;
@property (weak) IBOutlet NSTextField *codeTextField;

@property (nonatomic, strong) CMD *command;
@property (nonatomic, strong) COScript *coscript;
@property (nonatomic, strong) NSMutableDictionary *snippets;
@property (nonatomic, strong) NSMutableArray *snippetsName;
@property (nonatomic, copy) NSString *selectedSnippet;

@end

@implementation SketchSnippetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _command = [[CMD alloc] init];
    _coscript = [[COScript alloc] init];

    _selectedSnippet = nil;
    self.snippetCombobox.delegate = self;
    self.snippetCombobox.usesDataSource = YES;
    self.snippetCombobox.dataSource = self;

    NSDictionary *snippets = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"snippets_default.plist" ofType:nil]] options:0 format:nil error:nil];

    NSString *hasSaved =[[NSBundle mainBundle] pathForResource:@"snippets.plist" ofType:nil];
    NSDictionary *defaults = nil;
    if (hasSaved) {
        defaults = [NSPropertyListSerialization propertyListWithData:[NSData dataWithContentsOfFile:hasSaved] options:0 format:nil error:nil];
    }
    self.snippets = [([defaults count] == 0 ? snippets : defaults) mutableCopy];


    [self reloadData];
}


- (IBAction)executeButtonDidPress:(id)sender {
    NSString *code = _codeTextField.cell.title;
    NSString *target = _targetComboBox.cell.title;

    [_coscript exec:code forTarget:target output:[[NSBundle mainBundle] pathForResource:@"Untitled.js" ofType:nil]];

    [self save];
}

- (NSString *)input: (NSString *)prompt defaultValue: (NSString *)defaultValue {
    NSAlert *alert = [NSAlert alertWithMessageText: prompt
                                     defaultButton:@"OK"
                                   alternateButton:@"Cancel"
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input setStringValue:defaultValue];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        [input validateEditing];
        return [input stringValue];
    } else if (button == NSAlertAlternateReturn) {
        return nil;
    } else {
        return nil;
    }
}

- (void)reloadData {
    self.snippetsName = [[[_snippets allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    if ([_snippetsName count]) {
        if (_selectedSnippet == nil) {
            _selectedSnippet = [_snippetsName firstObject];
        }
        [self.snippetCombobox reloadData];
        [self.snippetCombobox setSelectable:YES];
        [self.snippetCombobox selectItemAtIndex:[self.snippetsName indexOfObject:_selectedSnippet]];
        self.codeTextField.cell.title = self.snippets[_selectedSnippet];
    } else {
        [self.snippetCombobox setSelectable:NO];
        [self.snippetCombobox reloadData];
    }
}

- (void)save {
    if (self.selectedSnippet) {
        self.snippets[self.selectedSnippet] = self.codeTextField.cell.title;
    }
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.snippets
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0
                                                               error:nil];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"snippets.plist"];
    if ( ! [data writeToFile:path atomically:YES]) {
        NSLog(@"failed to write to %@", path);
    } else {
        NSLog(@"successfully saved to %@", path);
    }
}

- (IBAction)saveButtonDidPress:(id)sender {
    self.selectedSnippet = self.snippetCombobox.cell.title;
    [self save];
    [self reloadData];
}

- (IBAction)deleteButtonDidPress:(id)sender {
    if (self.snippets[self.selectedSnippet]) {
        NSLog(@"deleting snippet `%@`", self.selectedSnippet);
        [self.snippets removeObjectForKey:self.selectedSnippet];
        [self.snippetsName removeObject:self.selectedSnippet];
    }
    self.selectedSnippet = nil;
    [self save];
    [self reloadData];
}

#pragma mark NSComboboxDelegate

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    return [self.snippetsName count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    return self.snippetsName[index];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    NSInteger index = self.snippetCombobox.indexOfSelectedItem;
    if (index != -1) {
        self.selectedSnippet = self.snippetsName[index];
    } else {
        self.selectedSnippet = nil;
    }
    [self reloadData];
}

@end
