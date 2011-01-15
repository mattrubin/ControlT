//
//  ControlT.h
//  ControlT
//
//  Created by Matt Rubin on 1/14/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ControlT : NSObject <NSApplicationDelegate> {
	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;
}

- (void)addStatusItem;
- (void)registerHotkey;

@end
