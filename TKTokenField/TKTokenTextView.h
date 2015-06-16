//
//  TKTokenTextView.h
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TKTokenField;
@interface TKTokenTextView : NSTextView
@property (assign,readwrite) NSTokenStyle tokenStyle;
@property (assign,readwrite) NSTimeInterval completionDelay;

@property (strong,readwrite) NSCharacterSet *tokenizingCharacterSet;
@property (strong,readwrite) NSString * previousCompletionString;

@property (strong,readwrite) NSArray *completions;
@property (assign,readwrite) NSInteger indexOfCompletion;
@property (assign,readwrite) NSRange completionRange;

@property (assign,readwrite) BOOL isCompleting;

- (NSRange) rangeOfAttachment:(NSTextAttachment*) theAttachment indexOfToken:(NSInteger *) index;
- (TKTokenField *) tokenField;
@end
