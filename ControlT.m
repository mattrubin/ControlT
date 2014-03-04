//
//  ControlT.m
//  ControlT
//
//  Copyright (c) 2011 Matt Rubin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
