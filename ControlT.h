//
//  ControlT.h
//  ControlT
//
//  Created by Matt Rubin on 1/14/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

@import Cocoa;


@interface ControlT : NSObject <NSApplicationDelegate>

@property NSStatusItem *statusItem;
@property IBOutlet NSMenu *menu;

- (void)addStatusItem;
- (void)registerHotkey;

@end
