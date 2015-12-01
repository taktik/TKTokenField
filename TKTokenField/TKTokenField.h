//
//  TKTokenField.h
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import <Cocoa/Cocoa.h>


//! Project version number for TKTokenField.
FOUNDATION_EXPORT double TKTokenFieldVersionNumber;

//! Project version string for TKTokenField.
FOUNDATION_EXPORT const unsigned char TKTokenFieldVersionString[];

#import "TKTokenFieldCell.h"
#import "TKTokenTextView.h"
#import "TKTokenFieldAttachment.h"
#import "TKTokenFieldAttachmentCell.h"

@class TKTokenField,TKTokenFieldAttachment;

@protocol TKTokenFieldDelegate
@optional
// Each element in the array should be an NSString or an array of NSStrings.
// substring is the partial string that is being completed.  tokenIndex is the index of the token being completed.
// selectedIndex allows you to return by reference an index specifying which of the completions should be selected initially.
// The default behavior is not to have any completions.

//Sync version
- (NSArray *)tokenField:(TKTokenField *)tokenField completionsForSubstring:(NSString *)substring indexOfToken:(NSInteger)tokenIndex indexOfSelectedItem:(NSInteger *)selectedIndex;
//Async version
- (void) tokenField:(TKTokenField*)tokenField completionsForSubstring:(NSString *)subString indexOfToken:(NSUInteger)index completionHandler:(void(^)(NSArray *suggestions, NSInteger preferredItem, NSError *error)) completionBlock;

// If you return nil or don't implement these delegate methods, we will assume
// editing string = display string = represented object
- (NSString *)tokenField:(TKTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject;
- (NSString *)tokenField:(TKTokenField *)tokenField editingStringForRepresentedObject:(id)representedObject;
- (id)tokenField:(TKTokenField *)tokenField representedObjectForEditingString: (NSString *)editingString;

//Or make the attachment yourself
- (TKTokenFieldAttachment *) tokenField:(TKTokenField*)tokenField makeAttachment:(id)representedObject editingString:(NSString *) string inRange:(NSRange) range;
//The rect is in tokenField coordinates
- (void) tokenField:(TKTokenField*)tokenField attachment:(TKTokenFieldAttachment*)attachment willBeInsertedInRange:(NSRange)range inRect:(NSRect) rect;
- (void) tokenField:(TKTokenField*)tokenField attachment:(TKTokenFieldAttachment*)attachment hasBeenInsertedInRange:(NSRange)range inRect:(NSRect) rect;
- (void) tokenField:(TKTokenField*)tokenField attachment:(TKTokenFieldAttachment*)attachment hasBeenSelectedInRange:(NSRange)range inRect:(NSRect) rect;


// We put the string on the pasteboard before calling this delegate method.
// By default, we write the NSStringPboardType as well as an array of NSStrings.
- (BOOL)tokenField:(TKTokenField *)tokenField writeRepresentedObjects:(NSArray *)objects toPasteboard:(NSPasteboard *)pboard;

// Return an array of represented objects to add to the token field.
- (NSArray *)tokenField:(TKTokenField *)tokenField readFromPasteboard:(NSPasteboard *)pboard;

// By default the tokens have no menu.
- (NSMenu *)tokenField:(TKTokenField *)tokenField menuForRepresentedObject:(id)representedObject;
- (BOOL)tokenField:(TKTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject;

// This method allows you to change the style for individual tokens as well as have mixed text and tokens.
- (NSTokenStyle)tokenField:(TKTokenField *)tokenField styleForRepresentedObject:(id)representedObject;

// Changing the nextKeyView
- (NSView*)nextValidKeyViewForTokenField:(TKTokenField *)tokenField;
@end

@interface TKTokenField : NSTextField
@property (assign,readwrite) BOOL isBeingEdited;

- (NSTokenStyle)tokenStyle;
- (void)setTokenStyle:(NSTokenStyle)style;

- (TKTokenFieldAttachment *)makeTokenFieldAttachment:(id)representedObject editingString:(NSString*)tokenString range:(NSRange) range;
// Completion delay...
+ (NSTimeInterval)defaultCompletionDelay;
- (NSTimeInterval)completionDelay;
- (void)setCompletionDelay:(NSTimeInterval)delay;

// Character set...
+ (NSCharacterSet *)defaultTokenizingCharacterSet;
- (void)setTokenizingCharacterSet:(NSCharacterSet *)characterSet;
- (NSCharacterSet *)tokenizingCharacterSet;

- (TKTokenFieldAttachment *) attachmentForRepresentedObject:(id) object;
- (void) refreshAttachment:(TKTokenFieldAttachment *) attachmentToBeRefreshed;

- (void) prepareInsertion:(TKTokenFieldAttachment *) att range:(NSRange) range rect:(NSRect) rect;
- (void) finishInsertion:(TKTokenFieldAttachment *) att range:(NSRange) range rect:(NSRect) rect;
- (void) tokenSelected:(TKTokenFieldAttachment *)att range:(NSRange) range rect:(NSRect) rect;
@end
