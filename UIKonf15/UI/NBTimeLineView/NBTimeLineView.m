//
//  NBTimeLineView.m
//  UIKonf15
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "NBTimeLineView.h"
#import "MonthHelper.h"
#import "Colors.h"

@interface NBTimeLineView ()

@property (nonatomic, assign) CGFloat monthIntervalSize; // width for each (month) step

@end

@implementation NBTimeLineView

- (id)initWithStartYear:(NSInteger)startYear startMonth:(NSInteger)startMonth endYear:(NSInteger)endYear endMonth:(NSInteger)endMonth skip:(NSRange)skip width:(CGFloat)width type:(TLV_Type)type
{
    self = [super init];
    if (self) {
        _type = type;
        _startYear = startYear;
        _startMonth = startMonth;
        _endYear = endYear;
        _endMonth = endMonth;
        _skip = skip;
        self.frame  = CGRectMake(0.0, 0.0, width, TIME_LINE_HEIGHT);
        [self initIntervalSize];
        if (_type == TLV_YearsOnly) {
            [self buildTimeLineWithYearsOnly];
        }
        else if (_type == TLV_YearsAndMonth) {
            [self buildTimeLineWithYearsAndMonth];
        }    }
    return self;
}

- (id)initWithStartYear:(NSInteger)startYear endYear:(NSInteger)endYear skip:(NSRange)skip width:(CGFloat)width type:(TLV_Type)type
{
    self = [super init];
    if (self)
    {
        _type = type;
        _startYear = startYear;
        _startMonth = 0;
        _endYear = endYear;
        _endMonth = 0;
        _skip = skip;
        self.frame  = CGRectMake(0.0, 0.0, width, TIME_LINE_HEIGHT);
        [self initIntervalSize];
        if (_type == TLV_YearsOnly) {
            [self buildTimeLineWithYearsOnly];
        }
        else if (_type == TLV_YearsAndMonth) {
            [self buildTimeLineWithYearsAndMonth];
        }
    }
    return self;
}


- (void)initIntervalSize
{
    NSInteger normalizedNumberOfYears = self.endYear - self.startYear - self.skip.length + 1;
    _intervalSize = self.bounds.size.width/normalizedNumberOfYears;
//    _monthIntervalSize = _intervalSize / MONTH_PER_YEAR;
    
    NSLog(@"DEBUG | %s | Interval size: (%f, %f)", __func__, self.intervalSize, self.monthIntervalSize);
}

- (void)initIntervalSizeWithMonth
{
    NSInteger normalizedNumberOfYears = self.endYear - self.startYear - self.skip.length + 1;
    
    NSInteger totalMonth = normalizedNumberOfYears * MONTH_PER_YEAR + ( MONTH_PER_YEAR - self.startYear ) + self.endYear;
    _monthIntervalSize = self.bounds.size.width / totalMonth;
    _intervalSize = self.monthIntervalSize * MONTH_PER_YEAR;
    
    NSLog(@"DEBUG | %s | Interval size: (%f, %f)", __func__, self.intervalSize, self.monthIntervalSize);
}

- (void)buildTimeLineWithYearsOnly
{
    self.backgroundColor = self.tintColor;// DEFAULT_TINT;// [UIColor blackColor];
    
    //NSInteger numberOfYears = _endYear - _startYear;
    for (int i = (int)self.startYear-1; i < self.endYear + 2; i++)
    {
        UILabel *currentYearLabel;
        
        // Dont add a year for the first and the last part of the time line
        if (i != self.startYear-1 && i != self.endYear+1)  {
            NSInteger factorX = i > self.skip.location ? i - self.startYear - self.skip.length :i - self.startYear ;
            CGFloat x = self.intervalSize * factorX;
            CGFloat y = 0.0;
            CGFloat width = self.intervalSize;
            CGFloat height = self.bounds.size.height;
            currentYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            NSString *yearString;
            if (i == self.skip.location)
            {
                yearString = @"...";
                i += self.skip.length;
            }
            else
            {
                yearString = [NSString stringWithFormat:@"%d", i];
            }
            currentYearLabel.text = yearString;
            currentYearLabel.textColor = [UIColor whiteColor];
            currentYearLabel.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:currentYearLabel];
        }
    }
}

- (void)buildTimeLineWithYearsAndMonth
{
    NSArray *year = [MonthHelper year];
    
    self.backgroundColor =  DEFAULT_TINT;// [UIColor blackColor];
    
    for (int i = (int)self.startYear-1; i < self.endYear + 2; i++) {
        
        UILabel *currentYearLabel = nil;
        
        CGFloat offsetX = (MONTH_PER_YEAR - self.startYear) * self.monthIntervalSize;
        
        // Dont add a year for the first and the last part of the time line
        if (i != self.startYear-1 && i != self.endYear+1)  {
            NSInteger factorX = i > self.skip.location ? i - self.startYear - self.skip.length :i - self.startYear ;
            CGFloat x = self.intervalSize * factorX;
            x += offsetX;
            CGFloat y = self.bounds.size.height / 2.0;
            CGFloat width = self.intervalSize;
            CGFloat height = self.bounds.size.height / 2.0;
            currentYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            NSString *yearString;
            if (i == self.skip.location)
            {
                yearString = @"...";
                i += self.skip.length;
            }
            else
            {
                yearString = [NSString stringWithFormat:@"%d", i];
            }
            currentYearLabel.text = yearString;
            currentYearLabel.textColor = [UIColor whiteColor];
            currentYearLabel.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:currentYearLabel];
            
            // Add the month labels
            Month *currentMonth = nil;
            UILabel *currentMonthLabel = nil;
            CGFloat monthLabelX = x;
            CGFloat monthLabelY = 0.0;
            for (int i = 0; i < [year count]; i++) {
                
                CGFloat monthIntervalSize = self.intervalSize / (CGFloat)[year count];
                
                monthLabelY = i%2 == 0 ? self.bounds.size.height / 4.0 : 0.0;
                currentMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthLabelX, monthLabelY, monthIntervalSize, self.bounds.size.height / 4.0)];
                currentMonth = year[i];
                
                monthLabelX += monthIntervalSize;
                
                currentMonthLabel.text = currentMonth.abbreviation;
                currentMonthLabel.textColor = [UIColor whiteColor];
                currentMonthLabel.textAlignment = NSTextAlignmentCenter;
                currentMonthLabel.font = [UIFont systemFontOfSize:10.0];
                [self addSubview:currentMonthLabel];
            }
        }
    }
}

- (void)buildTimeLineWithYearsAndMonthAccountingForStartAndEndMonth
{
    NSArray *year = [MonthHelper year];
    
    self.backgroundColor =  DEFAULT_TINT;// [UIColor blackColor];
    
    for (int i = (int)self.startYear-1; i < self.endYear + 2; i++) {
        
        UILabel *currentYearLabel = nil;
        
        // Dont add a year for the first and the last part of the time line
        if (i != self.startYear-1 && i != self.endYear+1)  {
            NSInteger factorX = i > self.skip.location ? i - self.startYear - self.skip.length :i - self.startYear ;
            CGFloat x = self.intervalSize * factorX;
            CGFloat y = self.bounds.size.height / 2.0;;
            CGFloat width = self.intervalSize;
            CGFloat height = self.bounds.size.height / 2.0;
            currentYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            NSString *yearString;
            if (i == self.skip.location)
            {
                yearString = @"...";
                i += self.skip.length;
            }
            else
            {
                yearString = [NSString stringWithFormat:@"%d", i];
            }
            currentYearLabel.text = yearString;
            currentYearLabel.textColor = [UIColor whiteColor];
            currentYearLabel.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:currentYearLabel];
            
            // Add the month labels
            Month *currentMonth = nil;
            UILabel *currentMonthLabel = nil;
            CGFloat monthLabelX = x;
            CGFloat monthLabelY = 0.0;
            for (int i = 0; i < [year count]; i++) {
                
                CGFloat monthIntervalSize = self.intervalSize / (CGFloat)[year count];
                
                monthLabelY = i%2 == 0 ? self.bounds.size.height / 4.0 : 0.0;
                currentMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(monthLabelX, monthLabelY, monthIntervalSize, self.bounds.size.height / 4.0)];
                currentMonth = year[i];
                
                monthLabelX += monthIntervalSize;
                
                currentMonthLabel.text = currentMonth.abbreviation;
                currentMonthLabel.textColor = [UIColor whiteColor];
                currentMonthLabel.textAlignment = NSTextAlignmentCenter;
                currentMonthLabel.font = [UIFont systemFontOfSize:10.0];
                [self addSubview:currentMonthLabel];
            }
            
            
        }
    }
}



@end
