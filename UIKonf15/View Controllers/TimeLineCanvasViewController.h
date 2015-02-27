//
//  TimeLineCanvasViewController.h
//  WWDC14
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineCanvas.h"
#import "HelpShakeViewController.h"
#import "NBStoryPreview.h"
#import "NBClickWheel.h"

@interface TimeLineCanvasViewController : UIViewController <TimeLineCanvasDelegate, HelpShake, NBStoryPreviewDelegate, NBClickWheelDelegate>


@end
