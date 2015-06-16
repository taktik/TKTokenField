//
//  TKTokenFieldCell.m
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import "TKTokenFieldCell.h"
#import "TKTokenTextView.h"

@implementation TKTokenFieldCell
+ (NSTimeInterval)defaultCompletionDelay {
    return 0;
}

+ (NSCharacterSet *)defaultTokenizingCharacterSet{
    return [NSCharacterSet newlineCharacterSet];
}

- (NSTextView *) fieldEditorForView:(NSView *) view {
    if (!self.tokenTextView) {
        self.tokenTextView = [[TKTokenTextView alloc] initWithFrame:view.bounds];
        
        self.tokenTextView.tokenizingCharacterSet = self.tokenizingCharacterSet ?: [[self class] defaultTokenizingCharacterSet];
        self.tokenTextView.completionDelay = self.completionDelay ?: [[self class] defaultCompletionDelay];
        self.tokenTextView.tokenStyle = self.tokenStyle;
        
        self.tokenTextView.font = ((NSTextField*)view).font;
    }
    return self.tokenTextView;
}
@end
