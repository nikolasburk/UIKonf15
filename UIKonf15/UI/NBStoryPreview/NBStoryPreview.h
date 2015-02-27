//
//  NBStoryPreview.h
//  UIKonf15
//
//  Created by Nikolas Burk on 25/02/15.
//  Copyright (c) 2015 Nikolas Burk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@class NBStoryPreview;

@protocol NBStoryPreviewDelegate <NSObject>

//- (void)storyPreviewDidPressArticleButton:(NBStoryPreview *)articleInfoView;
//- (void)storyPreviewDidPressShowKeywordsButton:(NBStoryPreview *)articleInfoView;
//- (void)storyPreviewDidPressShowRelevantSentenceButton:(NBStoryPreview *)articleInfoView;

@end

@interface NBStoryPreview : UIView

@property (nonatomic, strong) Story *story;
@property (nonatomic, weak) id<NBStoryPreviewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *teaserTextView;

@end
