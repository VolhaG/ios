#import "DoomsdayMachine.h"

@interface AssimilationInfo : NSObject<AssimilationInfo>

-(instancetype)initDateComponents:(NSDateComponents*)dateComponents;

@property (nonatomic, readwrite) NSInteger years;
@property (nonatomic, readwrite) NSInteger months;
@property (nonatomic, readwrite) NSInteger weeks;
@property (nonatomic, readwrite) NSInteger days;
@property (nonatomic, readwrite) NSInteger hours;
@property (nonatomic, readwrite) NSInteger minutes;
@property (nonatomic, readwrite) NSInteger seconds;

@end

@implementation AssimilationInfo

-(instancetype)initDateComponents:(NSDateComponents*)dateComponents {
    self = [super init];
    if (self != nil) {
        self.years = dateComponents.year;
        self.months = dateComponents.month;
        self.weeks = dateComponents.weekOfYear;
        self.days = dateComponents.day;
        self.hours = dateComponents.hour;
        self.minutes = dateComponents.minute;
        self.seconds = dateComponents.second;
    }
    return self;
}

@end

//Input: 2200:01:01@15\30/00

@implementation DoomsdayMachine

-(NSDate*)assimilationDate {
//    14 August 2208 03:13:37
    NSDateComponents* dateComponents = [NSDateComponents new];
    dateComponents.year = 2208;
    dateComponents.month = 8;
    dateComponents.day = 14;
    dateComponents.hour = 3;
    dateComponents.minute = 12;
    dateComponents.second = 37;
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorianCalendar dateFromComponents:dateComponents];
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    gregorianCalendar.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy:MM:dd@ss\\mm/HH";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate* date = [dateFormatter dateFromString:dateString];
    
    NSDateComponents* assimilationDateComponents = [NSDateComponents new];
    assimilationDateComponents.year = 2208;
    assimilationDateComponents.month = 8;
    assimilationDateComponents.day = 14;
    assimilationDateComponents.hour = 3;
    assimilationDateComponents.minute = 13;
    assimilationDateComponents.second = 37;
    NSDate* assimilationDate = [gregorianCalendar dateFromComponents:assimilationDateComponents];
    

    NSDateComponents* dateComponents = [gregorianCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth
                                        |NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                            fromDate:date
                                                              toDate:assimilationDate
                                                             options:0];

    return [[AssimilationInfo alloc] initDateComponents:dateComponents];
    
}

- (NSString *)doomsdayString {
    return @"Sunday, August 14, 2208";
}

@end
