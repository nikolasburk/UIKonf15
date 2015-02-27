//
//  MonthHelper.h
//  TopicAnalyzer
//
//  Created by Nikolas Burk on 20/10/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Month.h"

#define MONTH_PER_YEAR 12

@interface MonthHelper : NSObject

+ (NSArray *)year;
+ (Month *)monthForIndex:(NSInteger)index;
+ (NSString *)monthNameForIndex:(NSInteger)index;

@end
