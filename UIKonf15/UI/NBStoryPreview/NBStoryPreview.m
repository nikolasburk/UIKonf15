//
//  NBStoryPreview.m
//  UIKonf15
//
//  Created by Nikolas Burk on 25/02/15.
//  Copyright (c) 2015 Nikolas Burk. All rights reserved.
//

#import "NBStoryPreview.h"
#import "MonthHelper.h"
#import "UIView+Decoration.h"
#import "UIImage+Util.h"

@interface NBStoryPreview ()

@property (weak, nonatomic) IBOutlet UIImageView *storyImageView;
@property (nonatomic, weak) UIView *frameView;

@end

@implementation NBStoryPreview

- (void)setStory:(Story *)story
{
    _story = story;
    [self updateUI];

}

- (void)updateUI
{
    if (!self.story) {
        return;
    }
    
    self.titleLabel.text = self.story.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %ld", [MonthHelper monthNameForIndex:self.story.month], (long)self.story.year];
    self.teaserTextView.text = (NSString *)[self.story.paragraphs firstObject];
    self.teaserTextView.font =  [UIFont systemFontOfSize:15.0];
    self.teaserTextView.textAlignment = NSTextAlignmentJustified;
    
    self.storyImageView.image = [(UIImage *)[self.story.images firstObject] makeRoundedImage:[self.story.images firstObject] radius:75.0];
    self.storyImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}


@end
