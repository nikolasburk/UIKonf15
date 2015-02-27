//
//  Month.m
//  TopicAnalyzer
//
//  Created by Nikolas Burk on 20/10/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "Month.h"

@implementation Month

- (id)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        _fullName = [self nameForIndex:index];
        _abbreviation = [self abbreviationForIndex:index];
        _days = [self daysForIndex:index];
    }
    return self;
}

- (NSString *)nameForIndex:(NSInteger)index
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

- (NSString *)abbreviationForIndex:(NSInteger)index
{
    NSString *abbreviation = nil;
    switch (index) {
        case JAN:
            abbreviation = NSLocalizedString(@"Jan", nil);
            break;
        case FEB:
            abbreviation = NSLocalizedString(@"Feb", nil);
            break;
        case MAR:
            abbreviation = NSLocalizedString(@"Mar", nil);
            break;
        case APR:
            abbreviation = NSLocalizedString(@"Apr", nil);
            break;
        case MAY:
            abbreviation = NSLocalizedString(@"May", nil);
            break;
        case JUN:
            abbreviation = NSLocalizedString(@"Jun", nil);
            break;
        case JUL:
            abbreviation = NSLocalizedString(@"Jul", nil);
            break;
        case AUG:
            abbreviation = NSLocalizedString(@"Aug", nil);
            break;
        case SEP:
            abbreviation = NSLocalizedString(@"Sep", nil);
            break;
        case OCT:
            abbreviation = NSLocalizedString(@"Oct", nil);
            break;
        case NOV:
            abbreviation = NSLocalizedString(@"Nov", nil);
            break;
        case DEC:
            abbreviation = NSLocalizedString(@"Dec", nil);
            break;
            
        default:
            break;
    }
    return abbreviation;

}

- (NSInteger)daysForIndex:(NSInteger)index
{
    NSInteger days = 30;
    switch (index) {
        case JAN:
            days = 31;
            break;
        case FEB:
            days = 28;
            break;
        case MAR:
            days = 31;
            break;
        case APR:
            days = 30;
            break;
        case MAY:
            days = 31;
            break;
        case JUN:
            days = 30;
            break;
        case JUL:
            days = 31;
            break;
        case AUG:
            days = 31;
            break;
        case SEP:
            days = 30;
            break;
        case OCT:
            days = 31;
            break;
        case NOV:
            days = 30;
            break;
        case DEC:
            days = 31;
            break;
            
        default:
            break;
    }
    return days;
}



@end
