//
//  StoryThumbnail.m
//  WWDC14
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "StoryThumbnail.h"
#import "UIView+Decoration.h"
#import "Colors.h"
#import "UIView+FrameModification.h"
#import "Logging.h"
#import <QuartzCore/QuartzCore.h>

#define FRAME_WIDTH 3.5

#define SIZE_DELTA 7.5
#define ANIMATION_DURATION 0.5

@interface StoryThumbnail ()

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIView *frameView;

@end

@implementation StoryThumbnail

- (id)initWithFrame:(CGRect)frame story:(Story *)story
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _story = story;
        self.background = [[UIImageView alloc] initWithImage:[story.images firstObject]];
        [self.background setFrame:self.bounds];
        [self addSubview:self.background];
        [self updateUI];
        
        UIColor *frameColor = self.tintColor;
        self.frameView = [self generateDecorativeFrameWithWidth:FRAME_WIDTH color:frameColor];
        self.frameView.hidden = YES;
        [self addSubview:self.frameView];
        
        self.frameView.clipsToBounds = YES;
        self.frameView.layer.cornerRadius = 3.5;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3.5;
    }
    return self;
}

- (void)toggleHighlighted
{
    _highlighted = !_highlighted;
    self.frameView.hidden = ![self isHighlighted];
    [self updateUI];
}

- (void)updateUI
{
//    CGFloat newEdgeLength = [self isHighlighted] ? 75.0 /* self.bounds.size.width + SIZE_DELTA */ : self.bounds.size.width - SIZE_DELTA;
//
//    DLog(@"New edge length: %f --> %@", newEdgeLength, self.story);
    
//    [self setHeight:newEdgeLength];
//    [self setWidth:newEdgeLength];
    
//    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
//        [self setHeight:newEdgeLength];
//        [self setWidth:newEdgeLength];
//    } completion:^(BOOL finished){
//        
//    }];
    
    
//    UIColor *frameColor = self.isHighlighted ? DARK_GREEN : [UIColor blackColor];
//    [self addDecorativeFrameWithWidth:FRAME_WIDTH color:frameColor];
}



@end
