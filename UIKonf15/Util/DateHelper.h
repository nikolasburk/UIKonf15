//
//  DateHelper.h
//  TrafficAlarm
//
//  Created by Nikolas Burk on 16/03/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Util.h"

#define SECONDS_PER_HOUR 3600.0
#define MINUTES_PER_HOUR 60.0
#define SECONDS_PER_MINUTE 60.0
#define HOURS_PER_DAY 24.0
//#define DAYS_PER_WEEK 7.0

@interface DateHelper : NSObject

+ (NSString *)formattedHourAndMinuteStringFromMinutes:(NSInteger)minutes;
+ (NSDate *)roundDateToLastFullMinute:(NSDate *)date;
+ (BOOL)firstDate:(NSDate *)firstDate isEarlierThanSecondDate:(NSDate *)secondDate;
+ (BOOL)date:(NSDate *)date isBetweenFirstDate:(NSDate *)firstDate andSecondsDate:(NSDate *)secondDate;
+ (BOOL)timeOfFirstDate:(NSDate *)firstDate isEarlierThanTimeOfSecondDate:(NSDate *)secondDate;
+ (BOOL)dayOfFirstDate:(NSDate *)firstDate isEarlierThanDayOfSecondDate:(NSDate *)secondDate;
+ (NSDate *)dateWithDayOfDate:(NSDate *)dayDate andTimeOfDate:(NSDate *)timeDate;
+ (NSDate *)dateWithDayOfDate:(NSDate *)dayDate hours:(NSInteger)hours minutes:(NSInteger)minutes;

+ (NSDate *)nextDaySameTime:(NSDate *)date;

+ (NSDate *)closestDateForWeekdays:(NSArray *)weekdays;
+ (NSArray *)closestDatesForWeekdays:(NSArray *)weekdays;
+ (BOOL)weekdays:(NSArray *)weekdays containWeekday:(NSInteger)weekdayIndex;

@end
