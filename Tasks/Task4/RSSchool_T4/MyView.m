//
//  MyView.m
//  RSSchool_T4
//
//  Created by Оля Голенкевич on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "MyView.h"

@interface CountryPhoneData : NSObject
@property (nonatomic, assign) NSInteger phoneSize;
@property (nonatomic, copy) NSString* countryName;
@end

@interface NSString (Phone)
-(NSString*)safeSubstringWithRange:(NSRange)range prefix:(NSString*)prefix;
@end

@implementation NSString (Phone)

-(NSString*)safeSubstringWithRange:(NSRange)range prefix:(NSString*)prefix {
    if (self.length <= range.location) {
        return @"";
    }
    
    if (range.location + range.length >= self.length) {
        range.length = self.length - range.location;
    }
    
    return [prefix stringByAppendingString:[self substringWithRange:range]];
}

@end

@interface MyView()

@property (nonatomic, retain) UIImageView* flagView;
@property (nonatomic, retain) UITextField* textField;
@property (retain, nonatomic) NSDictionary<NSString*, CountryPhoneData*>* flagsDictionary;
@end

@implementation CountryPhoneData

+(CountryPhoneData*)dataForCountry:(NSString*)countryName size:(NSInteger)phoneSize {
    CountryPhoneData* data = [CountryPhoneData new];
    data.countryName = countryName;
    data.phoneSize = phoneSize;
    return [data autorelease];
}

@end

@implementation MyView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flagsDictionary = @{
                             @"7" : [CountryPhoneData dataForCountry:@"RU" size:10],
                             @"77" : [CountryPhoneData dataForCountry:@"KZ" size:10],
                             @"373" : [CountryPhoneData dataForCountry:@"MD" size:8],
                             @"377" : [CountryPhoneData dataForCountry:@"AM" size:8],
                             @"375" : [CountryPhoneData dataForCountry:@"BY" size:9],
                             @"380" : [CountryPhoneData dataForCountry:@"UA" size:9],
                             @"992" : [CountryPhoneData dataForCountry:@"TJ" size:9],
                             @"993" : [CountryPhoneData dataForCountry:@"TM" size:8],
                             @"994" : [CountryPhoneData dataForCountry:@"AZ" size:9],
                             @"996" : [CountryPhoneData dataForCountry:@"KG" size:9],
                             @"998" : [CountryPhoneData dataForCountry:@"UZ" size:9],
                             };
    
    _flagView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 32, 32)];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 320, 48)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.cornerRadius = 10;
    _textField.placeholder = @"Input phone number";
    _textField.keyboardType = UIKeyboardTypePhonePad;
    _textField.delegate = self;
    _textField.leftView = self.flagView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_textField];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}

// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
    
}
// if implemented, called in place of textFieldDidEndEditing:

-(NSString*)formatPhoneNumber:(NSString*)phoneNumber code:(NSString*)code withData:(CountryPhoneData*)data {
    NSString* res = nil;
    NSInteger codeLen = code.length;
    switch (data.phoneSize) {
        case 8:
            res = [NSString stringWithFormat:@"+%@%@%@%@",
                   code,
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen, 2) prefix:@" ("],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 2, 3) prefix:@") "],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 5, 3) prefix:@"-"]];
            break;
            
        case 9:
            res = [NSString stringWithFormat:@"+%@%@%@%@%@",
                   code,
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen, 2) prefix:@" ("],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 2, 3) prefix:@") "],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 5, 2) prefix:@"-"],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 7, 2) prefix:@"-"]];
            break;
            
        case 10:
            res = [NSString stringWithFormat:@"+%@%@%@%@%@",
                   code,
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen, 3) prefix:@" ("],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 3, 3) prefix:@") "],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 6, 2) prefix:@" "],
                   [phoneNumber safeSubstringWithRange:NSMakeRange(codeLen + 8, 2) prefix:@" "]];
            break;
    }
    return res;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* fullString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *onlyNumbers = [[fullString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                    componentsJoinedByString:@""];
    NSString* countryCode = [onlyNumbers substringToIndex: MIN(3, onlyNumbers.length)];
    CountryPhoneData* data = self.flagsDictionary[countryCode];
    
    while (data == nil && countryCode.length > 0) {
        countryCode = [countryCode substringToIndex:[countryCode length] - 1];
        data = self.flagsDictionary[countryCode];
    }
    
    if (data != nil) {
        NSLog(@"Found country %@ numbers:%@", data.countryName, onlyNumbers);
        if ([data.countryName isEqualToString:@"KZ"]) {
            countryCode = @"7";
        }
        textField.text = [self formatPhoneNumber:onlyNumbers code:countryCode withData:data];
        self.flagView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", data.countryName]];
        return NO;
    }
    self.flagView.image = nil;
    
    return onlyNumbers.length <= 12;
}   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}
// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
// called when 'return' key pressed. return NO to ignore.

@end
