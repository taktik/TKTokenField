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

    self.allCountries = @[@{@"key":@"Afghanistan"},@{@"key":@"Albania"},@{@"key":@"Algeria"},@{@"key":@"Andorra"},@{@"key":@"Angola"},@{@"key":@"Antigua & Deps"},@{@"key":@"Argentina"},@{@"key":@"Armenia"},
  @{@"key":@"Australia"},@{@"key":@"Austria"},@{@"key":@"Azerbaijan"},@{@"key":@"Bahamas"},@{@"key":@"Bahrain"},@{@"key":@"Bangladesh"},@{@"key":@"Barbados"},@{@"key":@"Belarus"},
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
    // Do any additional setup after loading the view.
    [self.tkf setObjectValue:@[
                          @{@"key":@"Belgium",@"points":@2},
                          @{@"key":@"France",@"points":@2},
                          @{@"key":@"Italy",@"points":@2},
                          @{@"key":@"Greece",@"points":@2},
                          @{@"key":@"The Netherlands",@"points":@2},
                          @{@"key":@"USA",@"points":@2},
                          @{@"key":@"Germany",@"points":@6},
                          @{@"key":@"United Kingdom",@"points":@2},
                          @{@"key":@"Spain",@"points":@2},
                          @{@"key":@"Portugal",@"points":@2},
                          @{@"key":@"Austria",@"points":@2},
                          @{@"key":@"Hungaria",@"points":@2},
                          @{@"key":@"Bulgary",@"points":@2}
                          ]];
    //[self.tkf setAttributedStringValue:[[NSAttributedString alloc] initWithString:@"aaa"]];
    [self.tf setAttributedStringValue:[[NSAttributedString alloc] initWithString:@"aaa"]];

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (TKTokenFieldAttachment *) tokenField:(TKTokenField *)tokenField makeAttachmentForString:(NSString *)string inRange:(NSRange)range {
    TKTokenFieldAttachment * att = [TKTokenFieldAttachment new];
    [att setAttachmentCell:[[TKTokenFieldAttachmentCell alloc] initTextCell:string]];
    att.content = @{};
    
    return att;
}

- (void) tokenField:(TKTokenField *)tokenField completionsForSubstring:(NSString *)subString indexOfToken:(NSUInteger)index completionHandler:(void (^)(NSArray *, NSInteger, NSError *))completionBlock {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completionBlock([[self.allCountries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key beginswith[cd] %@",subString]] valueForKey:@"key"],-1,nil);
    });
}

- (NSString*) tokenField:(NSTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject {
    return [representedObject valueForKey:@"key"];
}

- (NSString*) tokenField:(NSTokenField *)tokenField editingStringForRepresentedObject:(id)representedObject {
    return [[representedObject valueForKey:@"key"] stringByAppendingString:@":"];
}

- (BOOL) tokenField:(TKTokenField *)tokenField hasMenuForRepresentedObject:(id)representedObject {
    return YES;
}

- (void) tokenField:(TKTokenField *)tokenField attachment:(TKTokenFieldAttachment *)attachment hasBeenInsertedInRange:(NSRange)range inRect:(NSRect)rect {
    if (!NSEqualRects(NSZeroRect, rect)) {
        NSBeep();
    }
}

- (void) tokenField:(TKTokenField *)tokenField attachment:(TKTokenFieldAttachment *)attachment willBeInsertedInRange:(NSRange)range inRect:(NSRect)rect {
    [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setTextColor:[NSColor redColor]];
    [(TKTokenFieldAttachmentCell*)attachment.attachmentCell setAlternateTextColor:[NSColor colorWithCalibratedRed:1.0 green:0.5 blue:0.5 alpha:1.0]];
}


- (NSMenu*) tokenField:(TKTokenField *)tokenField menuForRepresentedObject:(id)representedObject {
    NSMenu * menu = [[NSMenu alloc] initWithTitle:@"Details"];
    
    [menu addItemWithTitle:@"Give one point" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Take one pont" action:NULL keyEquivalent:@""];
    
    return menu;
}
@end
