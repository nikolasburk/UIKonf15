//
//  NBTimeLineView.h
//  UIKonf15
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIME_LINE_HEIGHT 42.0

typedef enum {
    TLV_YearsOnly = 1,
    TLV_YearsAndMonth
} TLV_Type;

@interface NBTimeLineView : UIView

@property (nonatomic, assign, readonly) TLV_Type type;
@property (nonatomic, assign, readonly) NSInteger startYear;
@property (nonatomic, assign, readonly) NSInteger startMonth;
@property (nonatomic, assign, readonly) NSInteger endYear;
@property (nonatomic, assign, readonly) NSInteger endMonth;
@property (nonatomic, assign, readonly) NSRange skip; // gives the opportunity to skip a certain range
@property (nonatomic, assign, readonly) CGFloat intervalSize; // width for each (year) step

- (id)initWithStartYear:(NSInteger)startYear startMonth:(NSInteger)startMonth endYear:(NSInteger)endYear endMonth:(NSInteger)endMonth skip:(NSRange)skip width:(CGFloat)width type:(TLV_Type)type;
- (id)initWithStartYear:(NSInteger)startYear endYear:(NSInteger)endYear skip:(NSRange)skip width:(CGFloat)width type:(TLV_Type)type;


@end
