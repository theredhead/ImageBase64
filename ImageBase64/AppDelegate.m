//
//  AppDelegate.m
//  ImageBase64
//
//  Created by Kris Herlaar on 29/03/2018.
//  Copyright © 2018 Kris Herlaar. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

- (IBAction)imageDropped:(NSImageView *)sender;
	
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *instructionsLabel;
	
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (IBAction)imageDropped:(NSImageView *)sender {
	
	NSBitmapImageRep* rep = 
		[NSBitmapImageRep imageRepWithData:[[sender image] TIFFRepresentation]];
	
	NSData* data = [rep representationUsingType:NSPNGFileType properties: [[NSDictionary alloc] init]];
	
	NSString * encoded = [data base64EncodedStringWithOptions:0];

	NSString * result = [@"data:image/png;base64," stringByAppendingString:encoded];
	
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	[pasteboard clearContents];
	[pasteboard writeObjects:@[result]];
	
	[_instructionsLabel setStringValue:@"Base64 url copied."];
}
	
@end
