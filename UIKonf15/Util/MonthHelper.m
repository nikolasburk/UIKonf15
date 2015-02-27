//
//  MonthHelper.m
//  TopicAnalyzer
//
//  Created by Nikolas Burk on 20/10/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "MonthHelper.h"

@implementation MonthHelper

+ (NSArray *)year
{
    NSMutableArray *year = [[NSMutableArray alloc] initWithCapacity:MONTH_PER_YEAR];
    for (int i = 1; i < MONTH_PER_YEAR+1; i++)
    {
        Month *month = [[Month alloc] initWithIndex:i];
        [year addObject:month];
    }
    return [[NSArray alloc] initWithArray:year];
}

+ (Month *)monthForIndex:(NSInteger)index
{
    return [[Month alloc] initWithIndex:index];
}

+ (NSString *)monthNameForIndex:(NSInteger)index
{
    NSString *name = nil;
    switch (index) {
        case JAN:
            name = NSLocalizedString(@"January", nil);
            break;
        case FEB:
            name = NSLocalizedString(@"February", nil);
            break;
        case MAR:
            name = NSLocalizedString(@"March", nil);
            break;
        case APR:
            name = NSLocalizedString(@"April", nil);
            break;
        case MAY:
            name = NSLocalizedString(@"May", nil);
            break;
        case JUN:
            name = NSLocalizedString(@"June", nil);
            break;
        case JUL:
            name = NSLocalizedString(@"July", nil);
            break;
        case AUG:
            name = NSLocalizedString(@"August", nil);
            break;
        case SEP:
            name = NSLocalizedString(@"September", nil);
            break;
        case OCT:
            name = NSLocalizedString(@"October", nil);
            break;
        case NOV:
            name = NSLocalizedString(@"November", nil);
            break;
        case DEC:
            name = NSLocalizedString(@"December", nil);
            break;
            
            
        default:
            break;
    }
    return name;
}

@end
