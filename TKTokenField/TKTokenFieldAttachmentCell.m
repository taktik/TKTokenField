//
//  TKTokenFieldAttachmentCell.m
//  CustomTokenField
//  This is a ripoff from https://github.com/octiplex/OEXTokenField/blob/master/OEXTokenAttachmentCell.m
//  Created by Nicolas BACHSCHMIDT on 16/03/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import "TKTokenFieldAttachmentCell.h"
#import "TKTokenTextView.h"
#import "TKTokenField.h"
#import "TKTokenFieldAttachment.h"
static CGFloat const kOEXTokenAttachmentTitleMargin = 11;
static CGFloat const kOEXTokenAttachmentTokenMargin = 3;

@implementation TKTokenFieldAttachmentCell

#pragma mark - Geometry

+ (NSImage*) menuImage {
    static NSImage * image = nil;
    if (image == nil) {
        image = [[NSImage alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAAAoAAAAHCAYAAAAxrNxjAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB1WlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0aWZmOkNvbXByZXNzaW9uPjE8L3RpZmY6Q29tcHJlc3Npb24+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOlBob3RvbWV0cmljSW50ZXJwcmV0YXRpb24+MjwvdGlmZjpQaG90b21ldHJpY0ludGVycHJldGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KAtiABQAAAI1JREFUGBljYAACeXl5SRCNDcDkmOXk5EIYGRldeHl5f3369OkpsmIZGRlzJiamIH5+fnFmAQEBif///y8ECggDFT+AKQYpYmZmLgfKZQMNmskIMgFovBNQYC9QYP3fv387QWJQRYFAMeeHDx/uAytEVwziAzXCFYH4cIUgDsxksATUJBAbKwApBmF0SQCYgzr8eeSH8wAAAABJRU5ErkJggg==" options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    }
    return image;
}

- (NSPoint)cellBaselineOffset {
    return NSMakePoint(0, self.font.descender);
}

- (NSSize)cellSize {
    NSSize titleSize = [self.stringValue sizeWithAttributes:@{NSFontAttributeName:self.font}];
    return [self cellSizeForTitleSize:titleSize];
}

- (NSSize)cellSizeForTitleSize:(NSSize)titleSize {
    NSSize size = titleSize;
    // Add margins + height for the token rounded edges
    size.width += size.height + kOEXTokenAttachmentTitleMargin * 2;
    NSRect rect = {NSZeroPoint, size};
    return NSIntegralRect(rect).size;
}

- (NSRect)titleRectForBounds:(NSRect)bounds {
    bounds.size.width = MAX(bounds.size.width, kOEXTokenAttachmentTitleMargin * 2 + bounds.size.height);
    return NSInsetRect(bounds, kOEXTokenAttachmentTitleMargin + bounds.size.height / 2, 0);
}

#pragma mark - Drawing

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView characterIndex:(NSUInteger)charIndex layoutManager:(NSLayoutManager *)layoutManage {
    _drawingMode = self.isHighlighted && controlView.window.isKeyWindow ? OEXTokenDrawingModeHighlighted : OEXTokenDrawingModeDefault;
    _joinStyle = OEXTokenJoinStyleNone;
    
    if ( [controlView respondsToSelector:@selector(selectedRanges)] ) {
        for ( NSValue *rangeValue in [(id) controlView selectedRanges] ) {
            NSRange range = rangeValue.rangeValue;
            if ( ! NSLocationInRange(charIndex, range) )
                continue;
            
            if ( controlView.window.isKeyWindow )
                _drawingMode = OEXTokenDrawingModeSelected;
            
            // TODO: RTL is not supported yet
            if ( range.location < charIndex )
                _joinStyle |= OEXTokenJoinStyleLeft;
            if ( NSMaxRange(range) > charIndex + 1 )
                _joinStyle |= OEXTokenJoinStyleRight;
        }
    }
    
    [self drawTokenWithFrame:cellFrame inView:controlView];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [self drawWithFrame:cellFrame inView:controlView characterIndex:NSNotFound layoutManager:nil];
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [self drawWithFrame:cellFrame inView:controlView characterIndex:NSNotFound layoutManager:nil];
}

- (void)drawTokenWithFrame:(NSRect)rect inView:(NSView *)controlView {
    [[NSGraphicsContext currentContext] saveGraphicsState];
    
    NSColor *fillColor = [self tokenFillColorForDrawingMode:self.tokenDrawingMode];
    NSColor *strokeColor = [self tokenStrokeColorForDrawingMode:self.tokenDrawingMode];
    
    NSBezierPath *path = [self tokenPathForBounds:rect joinStyle:self.tokenJoinStyle];
    [path addClip];
    
    if (fillColor ) {
        [fillColor setFill];
        [path fill];
    }
    
    if ( strokeColor ) {
        [strokeColor setStroke];
        [path stroke];
    }
    
    [self drawTitleWithFrame:[self titleRectForBounds:rect] inView:controlView];
    
    //Sometimes, the controlView is the tokenField, sometimes it is the textview
    TKTokenField * tokenField = [controlView isKindOfClass:[TKTokenField class]]?controlView:[controlView respondsToSelector:@selector(tokenField)]?[controlView valueForKey:@"tokenField"]:nil;
    if ([tokenField.delegate respondsToSelector:@selector(tokenField:hasMenuForRepresentedObject:)]) {
        if ([(id<TKTokenFieldDelegate>)tokenField.delegate tokenField:tokenField hasMenuForRepresentedObject:((TKTokenFieldAttachment*)self.attachment).content]) {
            NSImage * img = [[self class] menuImage];
            [img drawInRect:NSMakeRect(rect.origin.x + rect.size.width - 18, rect.origin.y + rect.size.height/2 - 3, 10, 7)];
        }
    }
    
    [[NSGraphicsContext currentContext] restoreGraphicsState];
}

- (void)drawTitleWithFrame:(NSRect)rect inView:(NSView *)controlView; {
    NSColor *textColor = [self tokenTitleColorForDrawingMode:self.tokenDrawingMode];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableDictionary * attributes = [@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:style} mutableCopy];
    if (self.extraAttributes) { [attributes addEntriesFromDictionary:self.extraAttributes]; }
    
    [self.stringValue drawInRect:rect withAttributes:attributes];
}


- (void)highlight:(BOOL)flag
        withFrame:(NSRect)cellFrame
           inView:(NSView *)controlView {
    self.highlighted = flag;
    
    [self drawWithFrame:cellFrame inView:controlView];
}

- (NSMenu*)delegateMenuOfView:(NSView *)controlView {
    if ([((TKTokenTextView*)controlView).tokenField.delegate respondsToSelector:@selector(tokenField:hasMenuForRepresentedObject:)]) {
        if ([(id<TKTokenFieldDelegate>)((TKTokenTextView*)controlView).tokenField.delegate tokenField:((TKTokenTextView*)controlView).tokenField hasMenuForRepresentedObject:((TKTokenFieldAttachment*)self.attachment).content]) {
            if ([((TKTokenTextView*)controlView).tokenField.delegate respondsToSelector:@selector(tokenField:menuForRepresentedObject:)]) {
                return [(id<TKTokenFieldDelegate>)((TKTokenTextView*)controlView).tokenField.delegate tokenField:((TKTokenTextView*)controlView).tokenField menuForRepresentedObject:((TKTokenFieldAttachment*)self.attachment).content];
            }
        }
    }
    return nil;
}

- (NSMenu *)menuForEvent:(NSEvent *)anEvent
                  inRect:(NSRect)cellFrame
                  ofView:(NSView *)controlView {
    NSRect hotZone = NSMakeRect(cellFrame.origin.x+cellFrame.size.width-20.0,cellFrame.origin.y,cellFrame.size.height,20.0);
    hotZone = [controlView convertRect:hotZone toView:nil];
    if (NSPointInRect(anEvent.locationInWindow, hotZone) ) {
        return [self delegateMenuOfView:controlView];
    }
    return nil;
}

- (BOOL)wantsToTrackMouse {
    return YES;
}

- (BOOL)wantsToTrackMouseForEvent:(NSEvent *)theEvent
                           inRect:(NSRect)cellFrame
                           ofView:(NSView *)controlView
                 atCharacterIndex:(NSUInteger)charIndex {
    return [theEvent type] == NSLeftMouseDown;
}

- (BOOL)trackMouse:(NSEvent *)theEvent
            inRect:(NSRect)cellFrame
            ofView:(NSView *)controlView
      untilMouseUp:(BOOL)flag {
    if ([theEvent type] == NSLeftMouseDown) {
        NSWindow *window = [controlView window];
        NSEvent *myEvent;
        
        NSMenu * m = [self menuForEvent:theEvent inRect:cellFrame ofView:controlView];
        if (m) {
            [NSMenu popUpContextMenu:m withEvent:theEvent forView:controlView];
            return YES;
        }
        
        while ((myEvent = [window nextEventMatchingMask:(NSLeftMouseDragged|NSLeftMouseUp)])) {
            NSPoint pos = [controlView convertPoint:[theEvent locationInWindow] fromView:nil];
            if ([myEvent type] == NSLeftMouseUp) {
                if (NSPointInRect(pos, cellFrame)) {
                    if (theEvent.clickCount == 2) {
                        NSString * text = ((NSCell*)self.attachment.attachmentCell).stringValue;
                        
                        if ([((TKTokenTextView*)controlView).tokenField.delegate respondsToSelector:@selector(tokenField:editingStringForRepresentedObject:)]) {
                            text = [(id<TKTokenFieldDelegate>)((TKTokenTextView*)controlView).tokenField.delegate tokenField:((TKTokenTextView*)controlView).tokenField editingStringForRepresentedObject:((TKTokenFieldAttachment*)self.attachment).content];
                        }
                        
                        [(TKTokenTextView*)controlView replaceCharactersInRange:[(TKTokenTextView*)controlView rangeOfAttachment:self.attachment indexOfToken:nil] withString:text];
                    } else {
                        [(TKTokenTextView*)controlView setSelectedRange:[(TKTokenTextView*)controlView rangeOfAttachment:self.attachment indexOfToken:nil]];
                    }
                }
                return YES;
            }
        }
    }
    
    return [super trackMouse:theEvent
                      inRect:cellFrame
                      ofView:controlView
                untilMouseUp:flag];
}

#pragma mark - State

- (OEXTokenDrawingMode)tokenDrawingMode {
    return _drawingMode;
}

- (OEXTokenJoinStyle)tokenJoinStyle {
    return _joinStyle;
}

- (NSColor *)tokenFillColorForDrawingMode:(OEXTokenDrawingMode)drawingMode {
    // Those colors are Stolen From Apple
    switch ( drawingMode )
    {
        case OEXTokenDrawingModeDefault:
            return [NSColor colorWithDeviceRed:0.8706 green:0.9059 blue:0.9725 alpha:1];
        case OEXTokenDrawingModeHighlighted:
            return [NSColor colorWithDeviceRed:0.7330 green:0.8078 blue:0.9451 alpha:1];
        case OEXTokenDrawingModeSelected:
            return [NSColor colorWithDeviceRed:0.3490 green:0.5451 blue:0.9255 alpha:1];
    }
}

- (NSColor *)tokenStrokeColorForDrawingMode:(OEXTokenDrawingMode)drawingMode {
    // Those colors are Stolen From Apple
    switch ( drawingMode )
    {
        case OEXTokenDrawingModeDefault:
            return [NSColor colorWithDeviceRed:0.6431 green:0.7412 blue:0.9255 alpha:1];
        case OEXTokenDrawingModeHighlighted:
            return [NSColor colorWithDeviceRed:0.4275 green:0.5843 blue:0.8784 alpha:1];
        case OEXTokenDrawingModeSelected:
            return [NSColor colorWithDeviceRed:0.3490 green:0.5451 blue:0.9255 alpha:1];
    }
}

- (NSColor *)tokenTitleColorForDrawingMode:(OEXTokenDrawingMode)drawingMode {
    switch ( drawingMode )
    {
        case OEXTokenDrawingModeDefault:
        case OEXTokenDrawingModeHighlighted:
            return self.textColor?:[NSColor controlTextColor];
        case OEXTokenDrawingModeSelected:
            return self.alternateTextColor?:[NSColor alternateSelectedControlTextColor];
    }
}

#pragma mark - Geometry

- (NSBezierPath *)tokenPathForBounds:(NSRect)bounds joinStyle:(OEXTokenJoinStyle)jointStyle {
    bounds.size.width = MAX(bounds.size.width, kOEXTokenAttachmentTokenMargin * 2 + bounds.size.height);
    
    CGFloat radius = bounds.size.height / 2;
    CGRect innerRect = NSInsetRect(bounds, kOEXTokenAttachmentTokenMargin + radius, 0);
    CGFloat x0 = NSMinX(bounds);
    CGFloat x1 = NSMinX(innerRect);
    CGFloat x2 = NSMaxX(innerRect);
    CGFloat x3 = NSMaxX(bounds);
    CGFloat minY = NSMinY(bounds);
    CGFloat maxY = NSMaxY(bounds);
    CGFloat midY = NSMidY(bounds);
    
    NSBezierPath *path = [NSBezierPath new];
    [path moveToPoint:NSMakePoint(x1, minY)];
    
    // Left edge
    if ( jointStyle & OEXTokenJoinStyleLeft ) {
        [path lineToPoint:NSMakePoint(x0, minY)];
        [path lineToPoint:NSMakePoint(x0, maxY)];
        [path lineToPoint:NSMakePoint(x1, maxY)];
    }
    else {
        // Degrees?! O_o
        [path appendBezierPathWithArcWithCenter:NSMakePoint(x1, midY) radius:radius startAngle:-90 endAngle:90 clockwise:YES];
    }
    
    // Top edge
    [path lineToPoint:NSMakePoint(x2, maxY)];
    
    // Right edge
    if ( jointStyle & OEXTokenJoinStyleRight ) {
        [path lineToPoint:NSMakePoint(x3, maxY)];
        [path lineToPoint:NSMakePoint(x3, minY)];
        [path lineToPoint:NSMakePoint(x2, minY)];
    }
    else {
        [path appendBezierPathWithArcWithCenter:NSMakePoint(x2, midY) radius:radius startAngle:90 endAngle:-90 clockwise:YES];
    }
    
    // Bottom edge
    [path lineToPoint:NSMakePoint(x1, minY)];
    [path closePath];
    
    // As we'll clip to the path, let's double the desired line width (1)
    [path setLineWidth:2];
    
    return path;
}
@end
