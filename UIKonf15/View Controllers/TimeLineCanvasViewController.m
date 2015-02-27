//
//  TimeLineCanvasViewController.m
//  WWDC14
//
//  Created by Nikolas Burk on 09/04/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#import "TimeLineCanvasViewController.h"
#import "StoryBuilder.h"
#import "StoryThumbnail.h"
#import "StoryViewController.h"
#import "UIView+FrameModification.h"

#define BIRTH_YEAR 1989
#define CURRENT_YEAR 2015
#define SKIP_RANGE NSMakeRange(1990, 14)

#define HELP_SHAKE_NIBNAME_SUFFIX @"TimeLineCanvas"

@interface TimeLineCanvasViewController ()

@property (nonatomic, assign) NSInteger indexOfCurrentlySelectedStory;

@property (nonatomic, strong) NSArray *stories;
@property (nonatomic, strong) NBStoryPreview *storyPreview;
@property (nonatomic, strong) NBClickWheel *clickWheel;

@property (nonatomic, strong) TimeLineCanvas *timeLineCanvas;

@end

@implementation TimeLineCanvasViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.timeLineCanvas.timeLineView) {
        [self.timeLineCanvas buildTimeLineWithWidth:self.view.frame.size.width startYear:BIRTH_YEAR endYear:CURRENT_YEAR skip:SKIP_RANGE];
        for (Story *story in self.stories) {
            [self.timeLineCanvas addStoryThumbnailToCanvasForStory:story];
        }
    }
    [self.timeLineCanvas setFirstStoryThumbnailHighlighted];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize stories
    self.stories = [[StoryBuilder storyBuilderSharedInstance] stories];
    
    [self buildTimeLineCanvas];

    // Create and add the the article info view
    self.storyPreview = [[[NSBundle mainBundle] loadNibNamed:@"NBStoryPreview" owner:self options:nil] objectAtIndex:0];
    self.storyPreview.delegate = self;
    [self.storyPreview setX:self.view.bounds.size.width - TB_SLIDER_SIZE - 20.0];
    [self.storyPreview setY:20.0];
    [self.view addSubview:self.storyPreview];
    [self.view bringSubviewToFront:self.storyPreview];
    self.storyPreview.story = [self.stories firstObject];
    
//    self.indexOfCurrentlySelectedStory = 0;
    
    // Create and add the circular slider
    CGRect clickWheelFrame = CGRectMake(self.view.bounds.size.width - TB_SLIDER_SIZE, self.view.bounds.size.height - TB_SLIDER_SIZE  + 20.0 - self.tabBarController.tabBar.frame.size.height, TB_SLIDER_SIZE, TB_SLIDER_SIZE);
    NBClickWheel *clickWheel = [[NBClickWheel alloc] initWithFrame:clickWheelFrame];
    clickWheel.delegate = self;
    self.clickWheel = clickWheel;
    [self.view addSubview:self.clickWheel];
    
    // Hide status bar on canvas
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}


- (void)buildTimeLineCanvas
{
    // Build the canvas
    CGFloat timeLineCanvasWidth = self.view.bounds.size.width - TB_SLIDER_SIZE;
    CGRect timeLineCanvasFrame = CGRectMake(0.0, 0.0, timeLineCanvasWidth, self.view.bounds.size.height);
    TimeLineCanvas *timeLineCanvas = [[TimeLineCanvas alloc] initWithFrame:timeLineCanvasFrame];
    timeLineCanvas.delegate = self;
    timeLineCanvas.center = CGPointMake(timeLineCanvas.center.x, self.view.center.y);
    timeLineCanvas.backgroundColor = [UIColor clearColor];
    self.timeLineCanvas = timeLineCanvas;
    [self.view addSubview:self.timeLineCanvas];
    [self.view sendSubviewToBack:self.timeLineCanvas];
}



#pragma mark - Help shake

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"DEBUG | %s | Got shaked", __func__);
        [HelpShakeViewController openHelpShakeViewControllerWithViewController:self];
    }
}

- (NSString *)nibNameSuffix
{
    return HELP_SHAKE_NIBNAME_SUFFIX;
}

- (IBAction)helpShakeButtonPressed
{
    [HelpShakeViewController showHelpShakeInfo];
}
         
         
#pragma mark - Click wheel delegate
         
- (void)clickWheel:(NBClickWheel *)clickWheel didMoveHandleClockwise:(BOOL)clockwise withDegree:(NSInteger)degree
{
    if (self.indexOfCurrentlySelectedStory == [self.stories count]-1 && clockwise) {
        NSLog(@"DEBUG | %s | Did reach end: %li", __func__, (long)[self.stories count]);
//        [SVProgressHUD showErrorWithStatus:@"Keine weiteren Artikel..."];
        self.indexOfCurrentlySelectedStory = [self.stories count]-1;
        return;
    }
    else if(self.indexOfCurrentlySelectedStory == 0 && !clockwise) {
        NSLog(@"DEBUG | %s | Did reach start: 0", __func__);
        self.indexOfCurrentlySelectedStory = 0;
//        [SVProgressHUD showErrorWithStatus:@"Keine weiteren Artikel..."];
        return;
    }
//
    self.indexOfCurrentlySelectedStory = clockwise ? self.indexOfCurrentlySelectedStory+1 : self.indexOfCurrentlySelectedStory-1;
    NSLog(@"DEBUG | %s | New index: %li", __func__, (long)self.indexOfCurrentlySelectedStory);
}
 
 - (void)clickWheelDidPressControlButton:(NBClickWheel *)clickWheel
{
    Story *currentStory = self.stories[self.indexOfCurrentlySelectedStory];
    [self showDetailsForStory:currentStory];
    
//    NSArray *keywordsForArticle = [self keywordsForArticle:currentArticle];
//    ArticleDetailsViewController *articleDetailsViewController = [[ArticleDetailsViewController alloc] initWithNibName:@"ArticleDetailsViewController3" article:currentArticle keywords:keywordsForArticle numberOfArticles:self.articles.count currentlySelectedArticleIndex:self.indexOfCurrentlySelectArticle bundle:nil];
//    articleDetailsViewController.delegate = self;
//    articleDetailsViewController.modalPresentationStyle = UIModalPresentationPageSheet;
//    [self presentViewController:articleDetailsViewController animated:YES completion:nil];
}
 
 - (void)clickWheelDidStopMoving:(NBClickWheel *)clickWheel
{
//    Article *article = ((ArticleDot *)[self.dotPlotCanvas articleDotForIndex:self.indexOfCurrentlySelectArticle]).article;    
//    [[ArticleGenerator articleGeneratorSharedInstance] startLoadingArticleWithID:article.articleID];
}

- (void)setIndexOfCurrentlySelectedStory:(NSInteger)indexOfCurrentlySelectedStory
{
    _indexOfCurrentlySelectedStory = indexOfCurrentlySelectedStory;
    [self.timeLineCanvas highlightStoryThumbnailAtIndex:self.indexOfCurrentlySelectedStory];
    self.storyPreview.story = self.stories[self.indexOfCurrentlySelectedStory];
}



#pragma mark - Time line canvas delegate
     
- (void)timeLineCanvas:(TimeLineCanvas *)timeLineCanvas didSelectStoryThumbnail:(StoryThumbnail *)storyThumbnail
{
    NSLog(@"DEBUG | %s | Did select story: %@", __func__, storyThumbnail.story);
    [self showDetailsForStory:storyThumbnail.story];
}
         
#pragma mark - Helpers
         
- (void)showDetailsForStory:(Story *)story
{
    StoryViewController *storyViewController = [[StoryViewController alloc] initWithNibName:@"StoryViewController" story:story bundle:nil];
    storyViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:storyViewController animated:YES completion:nil];
}
     

@end
