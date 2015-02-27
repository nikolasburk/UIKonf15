//
//  StoryThumbnail.h
//  WWDC14
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

#define STORY_THUMBNAIL_EDGE 42.0

@interface StoryThumbnail : UIView

@property (nonatomic, assign, readonly, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, strong, readonly) Story *story;

- (id)initWithFrame:(CGRect)frame story:(Story *)story;

- (void)toggleHighlighted;

@end
