//
//  ControlT.m
//  ControlT
//
//  Created by Matt Rubin on 1/14/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ControlT.h"
#import <Carbon/Carbon.h>

@implementation ControlT

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self addStatusItem];
	[self registerHotkey];
	[NSApp hide:self];
}

- (void)addStatusItem {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
	[statusItem setTitle:@"⌃T"];
    [statusItem setMenu:menu];
	[statusItem setTarget:self];
}

OSStatus handleHotkey(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData)
{
	[[NSWorkspace sharedWorkspace] launchApplication:@"Terminal.app"];
	return noErr;
}

- (void)registerHotkey {
	EventHotKeyRef hotkeyRef;
	EventHotKeyID hotkeyID;
	EventTypeSpec eventType;
	eventType.eventClass=kEventClassKeyboard;
	eventType.eventKind=kEventHotKeyPressed;
	
	InstallApplicationEventHandler(&handleHotkey, 1, &eventType, NULL, NULL);
	
	hotkeyID.signature='htk1';
	hotkeyID.id=1;
	
	RegisterEventHotKey(0x11, controlKey, hotkeyID, GetApplicationEventTarget(), 0, &hotkeyRef);
}

@end
