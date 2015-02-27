//
//  NBClickWheel.h
//  UIKonf15
//
//  Created by Nikolas Burk on 25/02/15.
//  Copyright (c) 2015 Nikolas Burk. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Parameters **/
#define TB_SLIDER_SIZE 260                          //The width and the heigth of the slider
#define TB_BACKGROUND_WIDTH 60                      //The width of the dark background
#define TB_LINE_WIDTH 40                            //The width of the active area (the gradient) and the width of the handle


@class NBClickWheel;

@protocol NBClickWheelDelegate <NSObject>

@optional

- (void)clickWheel:(NBClickWheel *)clickWheel didMoveHandleWithDegree:(NSInteger)degree;
- (void)clickWheel:(NBClickWheel *)clickWheel didMoveHandleClockwise:(BOOL)clockwise withDegree:(NSInteger)degree;
- (void)clickWheelDidPressControlButton:(NBClickWheel *)clickWheel;
- (void)clickWheelDidStopMoving:(NBClickWheel *)clickWheel;

@end

@interface NBClickWheel : UIControl

@property (nonatomic,assign) int angle;
@property (nonatomic, assign) NSInteger sensitivity; // the higher the more sensitive

@property (nonatomic, weak) id <NBClickWheelDelegate> delegate;

@end
