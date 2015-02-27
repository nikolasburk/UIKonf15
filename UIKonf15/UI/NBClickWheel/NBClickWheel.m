//
//  NBClickWheel.m
//  UIKonf15
//
//  Created by Nikolas Burk on 25/02/15.
//  Copyright (c) 2015 Nikolas Burk. All rights reserved.
//

#import "NBClickWheel.h"
#import "UIView+FrameModification.h"
#import "Logging.h"

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

/** Parameters **/
#define TB_SAFEAREA_PADDING 60

#define SENSITIVITY 15


#pragma mark - Private

@interface NBClickWheel(){

    int radius;
    float formerAngle;
    
    NSInteger sensitivityCounter;
    
    UIButton *actionButton;
    
    //    UIImageView *controlButton;
}
@end

#pragma mark - Implementation

@implementation NBClickWheel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.opaque = NO;
        
        //Define the circle radius taking into account the safe area
        radius = self.frame.size.width/2 - TB_SAFEAREA_PADDING;
        
        // Set sensitity
        self.sensitivity = SENSITIVITY;
        sensitivityCounter = 0;
        
        //Initialize the Angle at 0
        self.angle = 90;
        
        actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [actionButton setTitle:@"Read more" forState:UIControlStateNormal];
        [actionButton setTitle:@"Read more" forState:UIControlStateHighlighted];
        [actionButton sizeToFit];
        actionButton.center = self.center;
        [self addSubview:actionButton];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.opaque = NO;
        
        //Define the circle radius taking into account the safe area
        radius = self.frame.size.width/2 - TB_SAFEAREA_PADDING;
        
        //Initialize the Angle at 0
        self.angle = 90;
        
        // Set sensitity
        self.sensitivity = SENSITIVITY;
        sensitivityCounter = 0;
        
        //        controlButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"details"]];
//        UIButton *controlButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [controlButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
//        [controlButton setWidth:48.0];
//        [controlButton setHeight:48.0];

        UIButton *controlButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        controlButton.titleLabel.numberOfLines = 2;
        [controlButton setTitle:@"Read more" forState:UIControlStateNormal];
        [controlButton setTitle:@"Read more" forState:UIControlStateHighlighted];
        
        [controlButton setWidth:48.0];
        [controlButton setHeight:48.0];
        
//        [controlButton sizeToFit];
        
        controlButton.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        [controlButton addTarget:self action:@selector(controlButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:controlButton];
        
    }
    
    return self;
}


- (void)controlButtonPressed
{
    DLog(@"Control button pressed");
    if ([self.delegate respondsToSelector:@selector(clickWheelDidPressControlButton:)])
    {
        [self.delegate clickWheelDidPressControlButton:self];
    }
}


#pragma mark - UIControl

/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    //We need to track continuously
    return YES;
}

/** Track continuos touch event (like drag) **/
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    //Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    
    //Use the location to design the Handle
    [self movehandle:lastPoint];
    
    //Control value has changed, let's notify that
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

/** Track is finished **/
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(clickWheelDidStopMoving:)]) {
        [self.delegate clickWheelDidStopMoving:self];
    }
    
    sensitivityCounter = 0;
}

#pragma mark - Drawing Functions -

//Use the draw rect to draw the Background, the Circle and the Handle
-(void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /** Draw the Background **/
    
    //Create the path
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius, 0, M_PI *2, 0);
    
    //Set the stroke color to black
    //    [[UIColor blackColor]setStroke];
    [self.tintColor setStroke];
//    [[UIColor blackColor] setStroke];
    
    //Define line width and cap
    CGContextSetLineWidth(ctx, TB_BACKGROUND_WIDTH);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    //** Draw the circle (using a clipped gradient) **/
    
    /** Create THE MASK Image **/
    UIGraphicsBeginImageContext(CGSizeMake(TB_SLIDER_SIZE,TB_SLIDER_SIZE));
    CGContextRef imageCtx = UIGraphicsGetCurrentContext();
    
    //    CGContextAddArc(imageCtx, self.frame.size.width/2  , self.frame.size.height/2, radius, 0, ToRad(self.angle), 0);
    CGContextAddArc(imageCtx, self.frame.size.width/2  , self.frame.size.height/2, radius, 0, ToRad(0.0), 0);
//    [[UIColor redColor] set];
    [[UIColor whiteColor] set];

    //Use shadow to create the Blur effect
    //    CGContextSetShadowWithColor(imageCtx, CGSizeMake(0, 0), self.angle/20, [UIColor blackColor].CGColor);
    
    //define the path
    CGContextSetLineWidth(imageCtx, TB_LINE_WIDTH);
    CGContextDrawPath(imageCtx, kCGPathStroke);
    
    //save the context content into the image mask
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    
    /** Clip Context to the mask **/
    CGContextSaveGState(ctx);
    
    CGContextClipToMask(ctx, self.bounds, mask);
    CGImageRelease(mask);
    
    
    /** THE GRADIENT **/
    
    //list of components
    CGFloat components[8] = {
        0.5, 0.5, 0.5, 1.0,     // Start color - Blue
        0.5, 0.5, 0.5, 1.0 };   // End color - Violet
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    //Gradient direction
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    //Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    
    CGContextRestoreGState(ctx);
    
    /** Draw the handle **/
    [self drawTheHandle:ctx];
    
}

/** Draw a white knob over the circle **/
-(void)drawTheHandle:(CGContextRef)ctx{
    
    CGContextSaveGState(ctx);
    
    //I Love shadows
    //    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, [UIColor blackColor].CGColor);
    
    //Get the handle position
    CGPoint handleCenter =  [self pointFromAngle: self.angle];
    
    //Draw It!
    //    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
//    [[UIColor redColor] set];
    [[UIColor whiteColor] set];
  
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, TB_LINE_WIDTH, TB_LINE_WIDTH));
    
    CGContextRestoreGState(ctx);
}

#pragma mark - Math -

/** Move the Handle **/
-(void)movehandle:(CGPoint)lastPoint
{
    
    //Calculate the direction from a center point and a arbitrary position.
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    float currentAngle = AngleFromNorth(centerPoint, lastPoint, NO);
    
    // Are we moving clockwise or counter clockwise?
    BOOL clockwise;
    NSInteger difference;
    if (currentAngle > formerAngle) {
        clockwise = YES;
    }
    else {
        clockwise = NO;
    }
    
    // Calculate and store the new angle
    formerAngle = currentAngle;
    int angleInt = floor(currentAngle);
    difference = self.angle - currentAngle;
    self.angle = 360 - angleInt;
    
    // Sensitivity update
    sensitivityCounter++;
    
    // Do we have to notifify the delegate?
    if (sensitivityCounter%self.sensitivity == 0) {
        if ([self.delegate respondsToSelector:@selector(clickWheel:didMoveHandleClockwise:withDegree:)]) {
            [self.delegate clickWheel:self didMoveHandleClockwise:clockwise withDegree:difference];
        }
        sensitivityCounter = 0;
    }
    
    
    //Redraw
    [self setNeedsDisplay];
}

/** Given the angle, get the point position on circumference **/
-(CGPoint)pointFromAngle:(int)angleInt
{
    
    //Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - TB_LINE_WIDTH/2, self.frame.size.height/2 - TB_LINE_WIDTH/2);
    
    //The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(-angleInt))) ;
    result.x = round(centerPoint.x + radius * cos(ToRad(-angleInt)));
    
    return result;
}

//Sourcecode from Apple example clockControl
//Calculate the direction in degrees from a center point to an arbitrary position.
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped)
{
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}




@end
