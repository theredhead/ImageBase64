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
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation AppDelegate


#pragma mark Utility
- (void)resetLabelText {
    [_instructionsLabel setStringValue:@"Drop an image onto the well."];
}

- (NSString *)makeDataUrl {
    NSBitmapImageRep* rep = [NSBitmapImageRep imageRepWithData:[[[self imageView] image] TIFFRepresentation]];
    NSData* data = [rep representationUsingType:NSPNGFileType properties: [[NSDictionary alloc] init]];
    
    NSString* encoded = [data base64EncodedStringWithOptions:0];
    NSString* dataUrl = [@"data:image/png;base64," stringByAppendingString:encoded];
    return dataUrl;
}

- (void)copyToPasteBoard:(NSString *) dataUrl {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeObjects:@[dataUrl]];
    
    [_instructionsLabel setStringValue:@"data url copied."];
    [NSTimer scheduledTimerWithTimeInterval:5.00f target:self selector:@selector(resetLabelText) userInfo:NULL repeats:NO];
}

#pragma mark event handling

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self resetLabelText];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (IBAction)imageDropped:(NSImageView *)sender {
	
	NSString * dataUrl = [self makeDataUrl];
    [self copyToPasteBoard: dataUrl];
}

@end
