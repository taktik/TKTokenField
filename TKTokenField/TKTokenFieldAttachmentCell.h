//
//  TKTokenFieldAttachmentCell.h
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, OEXTokenDrawingMode) {
    OEXTokenDrawingModeDefault,
    OEXTokenDrawingModeHighlighted,
    OEXTokenDrawingModeSelected,
};

typedef NS_ENUM(NSUInteger, OEXTokenJoinStyle) {
    OEXTokenJoinStyleNone,
    OEXTokenJoinStyleLeft,
    OEXTokenJoinStyleRight,
    OEXTokenJoinStyleBoth,
};

@interface TKTokenFieldAttachmentCell : NSTextAttachmentCell {
    OEXTokenDrawingMode _drawingMode;
    OEXTokenJoinStyle _joinStyle;
}

@property (readwrite,strong) NSMutableDictionary* extraAttributes;
@property (readwrite,strong) NSColor* textColor;
@property (readwrite,strong) NSColor* alternateTextColor;
@end
