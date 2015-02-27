//
//  NBPuzzleGameGridView.h
//  WWDC14
//
//  Created by Nikolas Burk on 05/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "NBGridView.h"

@class NBPuzzleGameGridView, QuestionView, Question;

@protocol NBPuzzleGameGridViewDelegate <NSObject, NBGridViewDelegate>

- (void)puzzleGameGridView:(NBPuzzleGameGridView *)puzzleGameGridView didSelectViewAtIndex:(NSInteger)index;

@optional

- (void)puzzleGameGridView:(NBPuzzleGameGridView *)puzzleGameGridView didEnterPuzzleMode:(BOOL)puzzleMode;
- (void)puzzleGameGridViewPuzzleSolved:(NBPuzzleGameGridView *)puzzleGameGridView;

@end

@interface NBPuzzleGameGridView : NBGridView

@property (nonatomic, strong) id <NBPuzzleGameGridViewDelegate> puzzleGridViewDelegate;
@property (nonatomic, assign) BOOL puzzleMode;

- (void)flipQuestionViewAtIndex:(NSInteger)index;
- (QuestionView *)questionViewForQuestion:(Question *)question;


@end
