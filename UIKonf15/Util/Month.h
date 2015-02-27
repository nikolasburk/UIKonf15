//
//  Month.h
//  TopicAnalyzer
//
//  Created by Nikolas Burk on 20/10/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#define JAN 1
#define FEB 2
#define MAR 3
#define APR 4
#define MAY 5
#define JUN 6
#define JUL 7
#define AUG 8
#define SEP 9
#define OCT 10
#define NOV 11
#define DEC 12

#import <Foundation/Foundation.h>

@interface Month : NSObject

@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, strong, readonly) NSString *fullName;
@property (nonatomic, strong, readonly) NSString *abbreviation;
@property (nonatomic, assign, readonly) NSInteger days;

- (id)initWithIndex:(NSInteger)index;

@end
