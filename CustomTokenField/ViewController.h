//
//  ViewController.h
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TKTokenField.h"

@interface ViewController : NSViewController<TKTokenFieldDelegate, NSTableViewDataSource>

@property (strong, readwrite) NSArray * allCountries;
@property (strong, readwrite) NSMutableArray * tableCountries;

@property (weak, readwrite) IBOutlet TKTokenField * tkf;
@property (weak, readwrite) IBOutlet NSTableView * tableView;

@end

