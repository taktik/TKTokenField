//
//  TKTokenFieldAttachment.h
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TKTokenFieldAttachment : NSTextAttachment <NSPasteboardWriting, NSPasteboardReading>
@property(readwrite, strong) id content;
@end
