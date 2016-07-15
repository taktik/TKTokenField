//
//  TKTokenFieldAttachment.m
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import "TKTokenFieldAttachment.h"
#import "TKTokenFieldAttachmentCell.h"

@implementation TKTokenFieldAttachment

- (BOOL) isEqualTo:(id)object {
    return object == self;
}

- (NSArray<NSString *> *)writableTypesForPasteboard:(NSPasteboard *)pasteboard {
    return @[@"org.taktik.TKToken"];
}

- (nullable id)pasteboardPropertyListForType:(NSString *)type {
    return [NSArchiver archivedDataWithRootObject:@{@"displayString":((NSCell*)self.attachmentCell).stringValue?:@"",@"contentData":self.content}];
}

+ (NSArray<NSString *> *)readableTypesForPasteboard:(NSPasteboard *)pasteboard {
    return @[@"org.taktik.TKToken"];
}

- (nullable id)initWithPasteboardPropertyList:(id)propertyList ofType:(NSString *)type {
    if ([type isEqualToString:@"org.taktik.TKToken"]) {
        TKTokenFieldAttachment * token = [TKTokenFieldAttachment new];
        NSDictionary * dict = [NSUnarchiver unarchiveObjectWithData:propertyList];
        [token setContent:[dict objectForKey:@"contentData"]];
        [token setAttachmentCell:[[TKTokenFieldAttachmentCell alloc] initTextCell:[dict objectForKey:@"displayString"]]];
        return token;
    }
    return nil;
}

@end
