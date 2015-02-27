//
//  DateHelper.m
//  TrafficAlarm
//
//  Created by Nikolas Burk on 16/03/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+ (NSString *)formattedHourAndMinuteStringFromMinutes:(NSInteger)minutes
{
    NSInteger hours = minutes/(NSInteger)MINUTES_PER_HOUR;
    NSInteger min = minutes%(NSInteger)MINUTES_PER_HOUR;
    
    NSString *formattedHourAndMinuteString;
    
    if (hours > 0 && min == 0)
    {
        formattedHourAndMinuteString = [NSString stringWithFormat:@"%li h", (long)hours];
    }
    else if(hours > 0 && min > 0)
    {
        formattedHourAndMinuteString = [NSString stringWithFormat:@"%li h %li min", (long)hours, (long)min];
    }
    else
    {
        formattedHourAndMinuteString = [NSString stringWithFormat:@"%li min", (long)min];
    }
    return formattedHourAndMinuteString;
}

+ (NSDate *)roundDateToLastFullMinute:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:date];
    NSInteger seconds = [components second];
    
    NSDate *returnDate = date;
    returnDate = [NSDate dateWithTimeInterval:0-seconds sinceDate:date];
    
//    DLog(@"Rounded to full last minute: %@ --> %@", date, returnDate);
    
    return returnDate;
}

+ (BOOL)firstDate:(NSDate *)firstDate isEarlierThanSecondDate:(NSDate *)secondDate
{
    BOOL firstDateIsEarlierThanSecondDate;
    
    NSComparisonResult comparisonResult = [firstDate compare:secondDate];
    firstDateIsEarlierThanSecondDate = comparisonResult == NSOrderedAscending; // receiver (firstDate) is earlier in time than argument (secondDate) --> NSOrderedAscending
    
//    DLog(@"%@ is%@earlier than %@", firstDate, firstDateIsEarlierThanSecondDate ? @" " : @" NOT ", secondDate);
    
    return firstDateIsEarlierThanSecondDate;
}

+ (BOOL)date:(NSDate *)date isBetweenFirstDate:(NSDate *)firstDate andSecondsDate:(NSDate *)secondDate
{
    BOOL dateIsBetweenFirstDateAndSecondsDate = NO;
    
    if (![DateHelper firstDate:date isEarlierThanSecondDate:firstDate] && [DateHelper firstDate:date isEarlierThanSecondDate:secondDate]) {
        dateIsBetweenFirstDateAndSecondsDate = YES;
    }
    
    return dateIsBetweenFirstDateAndSecondsDate;
}

+ (BOOL)timeOfFirstDate:(NSDate *)firstDate isEarlierThanTimeOfSecondDate:(NSDate *)secondDate
{
    BOOL timeOfFirstDateIsEarlierThanTimeOfSecondDate = NO;

    NSDateComponents *firstDateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:firstDate];
    NSDateComponents *secondDateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:secondDate];
    
    if ([firstDateComponents hour] < [secondDateComponents hour] || ( [firstDateComponents hour] == [secondDateComponents hour] && [firstDateComponents minute] < [secondDateComponents minute] ))
    {
        timeOfFirstDateIsEarlierThanTimeOfSecondDate = YES;
    }

    return timeOfFirstDateIsEarlierThanTimeOfSecondDate;
}

+ (BOOL)dayOfFirstDate:(NSDate *)firstDate isEarlierThanDayOfSecondDate:(NSDate *)secondDate
{
    BOOL dayOfFirstDateIsEarlierThanDayOfSecondDate = NO;
    
    NSDateComponents *firstDateComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:firstDate];
    NSDateComponents *secondDateComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:secondDate];
    
    if ([firstDateComponents day] < [secondDateComponents day])
    {
        dayOfFirstDateIsEarlierThanDayOfSecondDate = YES;
    }
    
    return dayOfFirstDateIsEarlierThanDayOfSecondDate;
}

+ (NSDate *)dateWithDayOfDate:(NSDate *)dayDate andTimeOfDate:(NSDate *)timeDate
{
    NSDateComponents *dayComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:dayDate];
    NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:timeDate];

    NSDateComponents *targetDateComponents = [[NSDateComponents alloc] init];
    [targetDateComponents setYear:[dayComponents year]];
    [targetDateComponents setMonth:[dayComponents month]];
    [targetDateComponents setDay:[dayComponents day]];
    [targetDateComponents setHour:[timeComponents hour]];
    [targetDateComponents setMinute:[timeComponents minute]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:targetDateComponents];
}

+ (NSDate *)dateWithDayOfDate:(NSDate *)dayDate hours:(NSInteger)hours minutes:(NSInteger)minutes
{
    NSDateComponents *dayComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:dayDate];
    
    NSDateComponents *targetDateComponents = [[NSDateComponents alloc] init];
    [targetDateComponents setYear:[dayComponents year]];
    [targetDateComponents setMonth:[dayComponents month]];
    [targetDateComponents setDay:[dayComponents day]];
    [targetDateComponents setHour:hours];
    [targetDateComponents setMinute:minutes];
    
    return [[NSCalendar currentCalendar] dateFromComponents:targetDateComponents];
}

+ (NSDate *)nextDaySameTime:(NSDate *)date
{
    date = [date dateByAddingTimeInterval:SECONDS_PER_HOUR * HOURS_PER_DAY];
    return date;
}


@end
