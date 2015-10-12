//
//  ViewController.m
//  CustomTokenField
//
//  Created by Antoine Duchateau on 14/06/15.
//  Copyright (c) 2015 Taktik SA. All rights reserved.
//

#import "ViewController.h"
#import "TKTokenFieldAttachment.h"
#import "TKTokenFieldAttachmentCell.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.allCountries = @[@{@"key":@"Afghanistan"},@{@"key":@"Albania"},@{@"key":@"Algeria"},@{@"key":@"Andorra"},@{@"key":@"Angola"},@{@"key":@"Antigua & Deps"},
  @{@"key":@"Argentina"},@{@"key":@"Armenia"},@{@"key":@"Australia"},@{@"key":@"Austria"},@{@"key":@"Azerbaijan"},@{@"key":@"Bahamas"},
  @{@"key":@"Bahrain"},@{@"key":@"Bangladesh"},@{@"key":@"Barbados"},@{@"key":@"Belarus"},
  @{@"key":@"Belgium"},@{@"key":@"Belize"},@{@"key":@"Benin"},@{@"key":@"Bhutan"},@{@"key":@"Bolivia"},@{@"key":@"Bosnia Herzegovina"},@{@"key":@"Botswana"},@{@"key":@"Brazil"},
  @{@"key":@"Brunei"},@{@"key":@"Bulgaria"},@{@"key":@"Burkina"},@{@"key":@"Burundi"},@{@"key":@"Cambodia"},@{@"key":@"Cameroon"},@{@"key":@"Canada"},@{@"key":@"Cape Verde"},
  @{@"key":@"Central African Rep"},@{@"key":@"Chad"},@{@"key":@"Chile"},@{@"key":@"China"},@{@"key":@"Colombia"},@{@"key":@"Comoros"},@{@"key":@"Congo"},@{@"key":@"Congo {Democratic Rep}"},
  @{@"key":@"Costa Rica"},@{@"key":@"Croatia"},@{@"key":@"Cuba"},@{@"key":@"Cyprus"},@{@"key":@"Czech Republic"},@{@"key":@"Denmark"},@{@"key":@"Djibouti"},@{@"key":@"Dominica"},
  @{@"key":@"Dominican Republic"},@{@"key":@"East Timor"},@{@"key":@"Ecuador"},@{@"key":@"Egypt"},@{@"key":@"El Salvador"},@{@"key":@"Equatorial Guinea"},@{@"key":@"Eritrea"},@{@"key":@"Estonia"},
  @{@"key":@"Ethiopia"},@{@"key":@"Fiji"},@{@"key":@"Finland"},@{@"key":@"France"},@{@"key":@"Gabon"},@{@"key":@"Gambia"},@{@"key":@"Georgia"},@{@"key":@"Germany"},
  @{@"key":@"Ghana"},@{@"key":@"Greece"},@{@"key":@"Grenada"},@{@"key":@"Guatemala"},@{@"key":@"Guinea"},@{@"key":@"Guinea-Bissau"},@{@"key":@"Guyana"},@{@"key":@"Haiti"},
  @{@"key":@"Honduras"},@{@"key":@"Hungary"},@{@"key":@"Iceland"},@{@"key":@"India"},@{@"key":@"Indonesia"},@{@"key":@"Iran"},@{@"key":@"Iraq"},@{@"key":@"Ireland {Republic}"},
  @{@"key":@"Israel"},@{@"key":@"Italy"},@{@"key":@"Ivory Coast"},@{@"key":@"Jamaica"},@{@"key":@"Japan"},@{@"key":@"Jordan"},@{@"key":@"Kazakhstan"},@{@"key":@"Kenya"},
  @{@"key":@"Kiribati"},@{@"key":@"Korea North"},@{@"key":@"Korea South"},@{@"key":@"Kosovo"},@{@"key":@"Kuwait"},@{@"key":@"Kyrgyzstan"},@{@"key":@"Laos"},@{@"key":@"Latvia"},
  @{@"key":@"Lebanon"},@{@"key":@"Lesotho"},@{@"key":@"Liberia"},@{@"key":@"Libya"},@{@"key":@"Liechtenstein"},@{@"key":@"Lithuania"},@{@"key":@"Luxembourg"},@{@"key":@"Macedonia"},
  @{@"key":@"Madagascar"},@{@"key":@"Malawi"},@{@"key":@"Malaysia"},@{@"key":@"Maldives"},@{@"key":@"Mali"},@{@"key":@"Malta"},@{@"key":@"Marshall Islands"},@{@"key":@"Mauritania"},
  @{@"key":@"Mauritius"},@{@"key":@"Mexico"},@{@"key":@"Micronesia"},@{@"key":@"Moldova"},@{@"key":@"Monaco"},@{@"key":@"Mongolia"},@{@"key":@"Montenegro"},@{@"key":@"Morocco"},
  @{@"key":@"Mozambique"},@{@"key":@"Myanmar, {Burma}"},@{@"key":@"Namibia"},@{@"key":@"Nauru"},@{@"key":@"Nepal"},@{@"key":@"Netherlands"},@{@"key":@"New Zealand"},@{@"key":@"Nicaragua"},
  @{@"key":@"Niger"},@{@"key":@"Nigeria"},@{@"key":@"Norway"},@{@"key":@"Oman"},@{@"key":@"Pakistan"},@{@"key":@"Palau"},@{@"key":@"Panama"},@{@"key":@"Papua New Guinea"},
  @{@"key":@"Paraguay"},@{@"key":@"Peru"},@{@"key":@"Philippines"},@{@"key":@"Poland"},@{@"key":@"Portugal"},@{@"key":@"Qatar"},@{@"key":@"Romania"},@{@"key":@"Russian Federation"},
  @{@"key":@"Rwanda"},@{@"key":@"St Kitts & Nevis"},@{@"key":@"St Lucia"},@{@"key":@"Saint Vincent & the Grenadines"},@{@"key":@"Samoa"},
  @{@"key":@"San Marino"},@{@"key":@"Sao Tome & Principe"},@{@"key":@"Saudi Arabia"},@{@"key":@"Senegal"},@{@"key":@"Serbia"},@{@"key":@"Seychelles"},
  @{@"key":@"Sierra Leone"},@{@"key":@"Singapore"},@{@"key":@"Slovakia"},@{@"key":@"Slovenia"},@{@"key":@"Solomon Islands"},
  @{@"key":@"Somalia"},@{@"key":@"South Africa"},@{@"key":@"South Sudan"},@{@"key":@"Spain"},@{@"key":@"Sri Lanka"},@{@"key":@"Sudan"},@{@"key":@"Suriname"},@{@"key":@"Swaziland"},
  @{@"key":@"Sweden"},@{@"key":@"Switzerland"},@{@"key":@"Syria"},@{@"key":@"Taiwan"},@{@"key":@"Tajikistan"},@{@"key":@"Tanzania"},@{@"key":@"Thailand"},@{@"key":@"Togo"},
  @{@"key":@"Tonga"},@{@"key":@"Trinidad & Tobago"},@{@"key":@"Tunisia"},@{@"key":@"Turkey"},@{@"key":@"Turkmenistan"},@{@"key":@"Tuvalu"},@{@"key":@"Uganda"},@{@"key":@"Ukraine"},
  @{@"key":@"United Arab Emirates"},@{@"key":@"United Kingdom"},@{@"key":@"United States"},@{@"key":@"Uruguay"},
  @{@"key":@"Uzbekistan"},@{@"key":@"Vanuatu"},@{@"key":@"Vatican City"},@{@"key":@"Venezuela"},@{@"key":@"Vietnam"},@{@"key":@"Yemen"},@{@"key":@"Zambia"},@{@"key":@"Zimbabwe"}];
    
    [self.tkf setObjectValue:@[
                          [@{@"key":@"Belgium",@"points":@2} mutableCopy],
                          [@{@"key":@"France",@"points":@0} mutableCopy],
                          [@{@"key":@"Italy",@"points":@1} mutableCopy],
                          [@{@"key":@"Greece",@"points":@2} mutableCopy],
                          [@{@"key":@"The Netherlands",@"points":@2} mutableCopy],
                          [@{@"key":@"USA",@"points":@2} mutableCopy],
                          [@{@"key":@"Germany",@"points":@6} mutableCopy],
                          [@{@"key":@"United Kingdom",@"points":@3} mutableCopy],
                          [@{@"key":@"Spain",@"points":@2} mutableCopy],
                          [@{@"key":@"Portugal",@"points":@2} mutableCopy],
                          [@{@"key":@"Austria",@"points":@2} mutableCopy],
                          [@{@"key":@"Hungaria",@"points":@2} mutableCopy],
                          [@{@"key":@"Bulgary",@"points":@2} mutableCopy]
                          ]];
    
    self.tableCountries = [@[@[[@{@"key":@"Belgium",@"points":@2} mutableCopy],[@{@"key":@"USA",@"points":@2} mutableCopy]],@[[@{@"key":@"Austria",@"points":@2} mutableCopy]],@[[@{@"key":@"France",@"points":@2} mutableCopy],[@{@"key":@"Spain",@"points":@2} mutableCopy]]] mutableCopy];
}

/*
 Low level attachment creation
 
- (TKTokenFieldAttachment *) tokenField:(TKTokenField *)tokenField makeAttachment:(id)representedObject editingString:(NSString *)string inRange:(NSRange)range {
    TKTokenFieldAttachment * att = [TKTokenFieldAttachment new];
    [att setAttachmentCell:[[TKTokenFieldAttachmentCell alloc] initTextCell:string?:[representedObject valueForKey:@"key"]?:@""]];
    att.content = representedObject;
    
    return att;
}*/

- (id)tokenField:(TKTokenField *)tokenField representedObjectForEditingString:(NSString *)editingString {
    return [@{@"key":editingString?:@"",@"points":@0} mutableCopy];
}

- (NSString*) tokenField:(TKTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject {
    return [representedObject valueForKey:@"key"];
}

- (NSString*) tokenField:(TKTokenField *)tokenField editingStringForRepresentedObject:(id)representedObject {
    return [[representedObject valueForKey:@"key"] stringByAppendingString:@":"];
}

#pragma mark Tokenfield asynchronous completion delegate method

- (void) tokenField:(TKTokenField *)tokenField completionsForSubstring:(NSString *)subString indexOfToken:(NSUInteger)index completionHandler:(void (^)(NSArray *, NSInteger, NSError *))completionBlock {

    //Simulate an asynchronous request
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Looking for completions for %@",subString);
        completionBlock([[self.allCountries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key beginswith[cd] %@",subString]] valueForKey:@"key"],-1,nil);
    });
}

#pragma mark Tokenfield post token insertion

- (void) tokenField:(TKTokenField *)tokenField attachment:(TKTokenFieldAttachment *)attachment hasBeenInsertedInRange:(NSRange)range inRect:(NSRect)rect {
}

#pragma mark Token cell styling

- (void) tokenField:(TKTokenField *)tokenField attachment:(TKTokenFieldAttachment *)attachment willBeInsertedInRange:(NSRange)range inRect:(NSRect)rect {
    if ([[attachment.content valueForKey:@"points"] intValue]) {
        [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setTextColor:[NSColor blackColor]];
        [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setAlternateTextColor:[NSColor whiteColor]];
    } else {
        [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setTextColor:[NSColor redColor]];
        [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setAlternateTextColor:[NSColor colorWithCalibratedRed:1.0 green:0.7 blue:0.7 alpha:1.0]];
    }
}

#pragma mark Token menu

- (IBAction) givePoint:(id)sender {
    TKTokenField* tf = (TKTokenField *)[((NSMenuItem*)sender).representedObject valueForKey:@"tf"];
    id obj = [((NSMenuItem*)sender).representedObject valueForKey:@"o"];
    TKTokenFieldAttachment * att = [tf attachmentForRepresentedObject:obj];

    [obj setValue:@([[obj valueForKeyPath:@"points"] integerValue]+1) forKey:@"points"];
    [tf refreshAttachment:att];
}

- (IBAction) takePoint:(id)sender {
    TKTokenField* tf = (TKTokenField *)[((NSMenuItem*)sender).representedObject valueForKey:@"tf"];
    id obj = [((NSMenuItem*)sender).representedObject valueForKey:@"o"];
    TKTokenFieldAttachment * att = [tf attachmentForRepresentedObject:obj];

    [obj setValue:@(MAX(0,[[obj valueForKeyPath:@"points"] integerValue]-1)) forKey:@"points"];
    [tf refreshAttachment:att];
}

- (BOOL) tokenField:(TKTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject {
    return YES;
}

- (NSMenu*) tokenField:(TKTokenField *)tokenField menuForRepresentedObject:(id)representedObject {
    NSMenu * menu = [[NSMenu alloc] initWithTitle:@"Details"];
    
    [menu addItemWithTitle:@"Give one point" action:@selector(givePoint:) keyEquivalent:@""];
    [[menu itemWithTitle:@"Give one point"] setTarget:self];
    [[menu itemWithTitle:@"Give one point"] setRepresentedObject:@{@"tf":tokenField,@"o":representedObject}];

    [menu addItemWithTitle:@"Take one pont" action:@selector(takePoint:) keyEquivalent:@""];
    [[menu itemWithTitle:@"Take one pont"] setTarget:self];
    [[menu itemWithTitle:@"Take one pont"] setRepresentedObject:@{@"tf":tokenField,@"o":representedObject}];
   
    return menu;
}

#pragma mark Table view delegate

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
    return self.tableCountries.count;
}

- (NSView*) tableView:(NSTableView*) tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView* cellView = [tableView makeViewWithIdentifier:@"TokenCell" owner:self];
    [(TKTokenField*)cellView.textField setObjectValue:self.tableCountries[row]];
    
    return cellView;
}

- (IBAction)onTokenInTableEdited:(TKTokenField*)sender {
    NSUInteger selectedRowNumber = _tableView.selectedRow;
    if (selectedRowNumber != -1 ) {
        self.tableCountries[selectedRowNumber] = sender.objectValue;
    }
}
@end
