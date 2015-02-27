//
//  NSDate+Util.h
//  TrafficAlarm
//
//  Created by Nikolas Burk on 18/05/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)
- (NSString *)dateString;
- (NSString *)timeString;
- (NSInteger)hours;
- (NSInteger)minutes;
@end
