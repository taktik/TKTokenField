//
//  TKTokenField.m
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import "TKTokenField.h"
#import "TKTokenFieldCell.h"
#import "TKTokenTextView.h"
#import "TKTokenFieldAttachment.h"
#import "TKTokenFieldAttachmentCell.h"

@interface TKTokenField(private)
- (id<TKTokenFieldDelegate>) tkd;
@end


@implementation TKTokenField(private)
- (id<TKTokenFieldDelegate>) tkd {
    return (id<TKTokenFieldDelegate>)[self delegate];
}
@end


@implementation TKTokenField

//
// Class methods
//
+ (void) initialize {
    if (self == [NSTokenField class]) {
        [self setVersion: 1];
        
        [self exposeBinding: NSEditableBinding];
        [self exposeBinding: NSTextColorBinding];
    }
}

- (id) initWithFrame: (NSRect)frame {
    if((self = [super initWithFrame: frame]) == nil) {
        return nil;
    }
    
    // initialize...
    [_cell setTokenStyle: NSDefaultTokenStyle];
    [_cell setCompletionDelay: [_cell defaultCompletionDelay]];
    [_cell setTokenizingCharacterSet: [_cell defaultTokenizingCharacterSet]];
    
    return self;
}

- (TKTokenFieldAttachment *)makeTokenFieldAttachment:(id)representedObject editingString:(NSString*)tokenString range:(NSRange) range {
    TKTokenFieldAttachment * token = nil;
    if (representedObject && [[self delegate] respondsToSelector:@selector(tokenField:makeAttachment:editingString:inRange:)]) {
        if (!tokenString && [[self delegate] respondsToSelector:@selector(tokenField:displayStringForRepresentedObject:)]) {
            tokenString = [self.tkd tokenField:self displayStringForRepresentedObject:representedObject];
        }
        token = [self.tkd tokenField:self makeAttachment:representedObject editingString:tokenString inRange:range];
    }
    if (!token) {
        token = [TKTokenFieldAttachment new];
        
        if (representedObject) {
            [token setContent:representedObject];
        } else if ([[self delegate] respondsToSelector:@selector(tokenField:representedObjectForEditingString:)]) {
            [token setContent:[self.tkd tokenField:(TKTokenField*)self representedObjectForEditingString:tokenString]];
        } else {
            [token setContent:tokenString];
        }
        
        NSString * displayString = ([[self delegate] respondsToSelector:@selector(tokenField:displayStringForRepresentedObject:)]?[self.tkd tokenField:self displayStringForRepresentedObject:token.content]:tokenString);
        
        [token setAttachmentCell:[[TKTokenFieldAttachmentCell alloc] initTextCell:displayString]];
    }
    return token;
}

//Called when the token is created manually or through a setObjectValue
- (void) prepareInsertion:(TKTokenFieldAttachment *) att range:(NSRange) range rect:(NSRect) rect {
    if ([[self delegate] respondsToSelector:@selector(tokenField:attachment:willBeInsertedInRange:inRect:)]) {
        [self.tkd tokenField:self attachment:att willBeInsertedInRange:range inRect:rect];
    }
}

//Called only when the token is created manually
- (void) finishInsertion:(TKTokenFieldAttachment *)att range:(NSRange) range rect:(NSRect) rect {
    if ([[self delegate] respondsToSelector:@selector(tokenField:attachment:hasBeenInsertedInRange:inRect:)]) {
        [self.tkd tokenField:self attachment:att hasBeenInsertedInRange:range inRect:rect];
    }
}

- (void) tokenSelected:(TKTokenFieldAttachment *)att range:(NSRange) range rect:(NSRect) rect {
    if ([[self delegate] respondsToSelector:@selector(tokenField:attachment:hasBeenSelectedInRange:inRect:)]) {
        [self.tkd tokenField:self attachment:att hasBeenSelectedInRange:range inRect:rect];
    }
}

- (void) setObjectValue:(id)objectValue {
    if (![objectValue isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSMutableAttributedString * ms = [NSMutableAttributedString new];
    for (id obj in (NSArray *)objectValue) {
        NSRange effectiveRange = NSMakeRange(ms.length, 0);
        TKTokenFieldAttachment * att = [self makeTokenFieldAttachment:obj editingString:nil range:effectiveRange];
        TKTokenTextView *textView = [(TKTokenFieldCell*)self.cell tokenTextView];
        
        NSRect rect = textView ? [textView firstRectForCharacterRange:effectiveRange actualRange:nil]:NSZeroRect; //screen coordinates
        rect = [self.window convertRectFromScreen:rect];
        rect.origin = [self convertPoint:rect.origin fromView:nil];
        
        [self prepareInsertion:att range:effectiveRange rect:rect];
        [ms appendAttributedString:[NSAttributedString attributedStringWithAttachment:att]];
        //
    }
    
    [super setObjectValue:ms];
    
    [self invalidateIntrinsicContentSize];
    [self setNeedsDisplay:YES];
}

- (id) objectValue {
    NSAttributedString * as = self.attributedStringValue;
    NSUInteger length = as.length;
    NSRange effectiveRange = NSMakeRange(0, 0);
    
    NSMutableArray * result = [NSMutableArray new];
    
    TKTokenFieldAttachment * attachment;
    while (NSMaxRange(effectiveRange) < length) {
        attachment = [as attribute:NSAttachmentAttributeName atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
        if ([attachment isKindOfClass:[TKTokenFieldAttachment class]]) {
            [result addObject:attachment.content];
        }
    }
    return result;
}

- (TKTokenFieldAttachment *) attachmentForRepresentedObject:(id) object {
    NSAttributedString * as = self.attributedStringValue;
    NSUInteger length = as.length;
    NSRange effectiveRange = NSMakeRange(0, 0);

    TKTokenFieldAttachment * attachment;
    while (NSMaxRange(effectiveRange) < length) {
        attachment = [as attribute:NSAttachmentAttributeName atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
        if ([attachment isKindOfClass:[TKTokenFieldAttachment class]] && [attachment.content isEqualTo:object]) {
            return attachment;
        }
    }
    return nil;
}

- (void) refreshAttachment:(TKTokenFieldAttachment *) attachmentToBeRefreshed {
    NSAttributedString * as = self.attributedStringValue;
    NSUInteger length = as.length;
    NSRange effectiveRange = NSMakeRange(0, 0);
    
    TKTokenFieldAttachment * attachment;
    while (NSMaxRange(effectiveRange) < length) {
        attachment = [as attribute:NSAttachmentAttributeName atIndex:NSMaxRange(effectiveRange) effectiveRange:&effectiveRange];
        if (attachmentToBeRefreshed == attachment) {
            TKTokenTextView *textView = [(TKTokenFieldCell*)self.cell tokenTextView];

            NSRect rect = textView ? [textView firstRectForCharacterRange:effectiveRange actualRange:nil]:NSZeroRect; //screen coordinates
            rect = [self.window convertRectFromScreen:rect];
            rect.origin = [self convertPoint:rect.origin fromView:nil];

            [self prepareInsertion:attachment range:effectiveRange rect:rect];
        }
    }
}

/*
 * Setting the Cell class
 */
+ (Class) cellClass {
    return [TKTokenFieldCell class];
}

// Style...
- (NSTokenStyle)tokenStyle {
    return [_cell tokenStyle];
}

- (void)setTokenStyle:(NSTokenStyle)style {
    [_cell setTokenStyle: style];
}

// Completion delay...
+ (NSTimeInterval)defaultCompletionDelay {
    return [[TKTokenFieldCell class] defaultCompletionDelay];
}

- (NSTimeInterval)completionDelay {
    return [_cell completionDelay];
}

- (void)setCompletionDelay:(NSTimeInterval)delay {
    [_cell setCompletionDelay: delay];
}

// Character set...
+ (NSCharacterSet *)defaultTokenizingCharacterSet {
    return [[TKTokenFieldCell class] defaultTokenizingCharacterSet];
}

- (void)setTokenizingCharacterSet:(NSCharacterSet *)characterSet {
    [_cell setTokenizingCharacterSet: characterSet];
}

- (NSCharacterSet *)tokenizingCharacterSet {
    return [_cell tokenizingCharacterSet];
}

-(NSSize)intrinsicContentSize {
    NSSize intrinsicSize = [super intrinsicContentSize];
    
    TKTokenTextView *textView = [(TKTokenFieldCell*)self.cell tokenTextView];
    if (textView) {
        NSRect usedRect = [textView.textContainer.layoutManager usedRectForTextContainer:textView.textContainer];
        
        usedRect.size.height += 5.0; // magic number! (the field editor TextView is offset within the NSTextField. It’s easy to get the space above (it’s origin), but it’s difficult to get the default spacing for the bottom, as we may be changing the height
        
        intrinsicSize.height = usedRect.size.height;
    }
    if (intrinsicSize.height<self.superview.bounds.size.height) {
        intrinsicSize.height=self.superview.bounds.size.height;
    }
    
    if (textView && [self.window firstResponder] == textView) {
        [textView setFrame:NSMakeRect(textView.frame.origin.x, textView.frame.origin.y, textView.superview.frame.size.width, intrinsicSize.height - 5.0)];
        [textView.superview setFrame:NSMakeRect(textView.superview.frame.origin.x, textView.superview.frame.origin.y, textView.superview.frame.size.width, intrinsicSize.height - 2.0)];
    }
    
    return intrinsicSize;
}
@end
