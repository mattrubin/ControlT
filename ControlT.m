//
//  ControlT.m
//  ControlT
//
//  Created by Matt Rubin on 1/14/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ControlT.h"
@import Carbon.HIToolbox;


@implementation ControlT

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self addStatusItem];
	[self registerHotkey];
	[NSApp hide:self];
}

- (void)addStatusItem {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setHighlightMode:YES];
	[self.statusItem setTitle:@"⌃T"];
    [self.statusItem setMenu:self.menu];
	[self.statusItem setTarget:self];
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
