//
//  NSDate+Util.m
//  TrafficAlarm
//
//  Created by Nikolas Burk on 18/05/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

- (NSString *)dateString
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSString *minuteString = [NSString stringWithFormat:minute < 10 ? @"0%ld" : @"%ld", (long)minute];
    NSString *hourString = [NSString stringWithFormat:hour < 10 ? @"0%ld" : @"%ld", (long)hour];
    
    return [NSString stringWithFormat:@"%d.%d.%d %@:%@", day, month, year, hourString, minuteString];
}

- (NSString *)timeString
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSString *minuteString = [NSString stringWithFormat:minute < 10 ? @"0%ld" : @"%ld", (long)minute];
    NSString *hourString = [NSString stringWithFormat:hour < 10 ? @"0%ld" : @"%ld", (long)hour];

    return [NSString stringWithFormat:@"%@:%@", hourString, minuteString];
//    return [NSString stringWithFormat:minute < 10 ? @"%ld:0%ld" : @"%ld:%ld", (long)hour, (long)minute];
}

- (NSInteger)hours
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit) fromDate:self];
    NSInteger hour = [components hour];
    return hour;
}

- (NSInteger)minutes
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSMinuteCalendarUnit) fromDate:self];
    NSInteger minute = [components minute];
    return minute;
}

@end
