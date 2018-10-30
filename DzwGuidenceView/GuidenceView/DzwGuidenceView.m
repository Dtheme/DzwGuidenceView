//
//  DzwGuidenceView.m
//  DzwGuidenceView
//
//  Created by dzw on 2018/10/29.
//  Copyright © 2018 dzw. All rights reserved.
//

#import "DzwGuidenceView.h"
#import <Lottie/Lottie.h>

@interface DzwGuidenceView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger pagesCount;//总页数，与动画数组元素个数一致
@property (nonatomic, strong) NSMutableArray *animationViews;
@property (nonatomic, strong) NSMutableArray *animationLabels;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation DzwGuidenceView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self configUI];
    }
    return self;
}



- (void)configUI{
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.scrollView];
    [self insertSubview:self.nextButton aboveSubview:self.scrollView];
    [self insertSubview:self.pageControl aboveSubview:self.scrollView];
}

-(void)setAnimationsGroup:(NSArray *)animationsGroup{
    _animationsGroup = animationsGroup;
    
    _pagesCount = animationsGroup.count;
    
    _pageControl.numberOfPages = self.pagesCount;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * _pagesCount, self.frame.size.height);
   
    for (int i = 0 ; i < _animationsGroup.count; i++) {
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:_animationsGroup[i]];
        CGRect animationframe =  CGRectMake(0, 0, 300, 300);
        animationframe.origin.x = i * self.frame.size.width+self.center.x-150;
        animationframe.origin.y = self.center.y-300;
        animationView.frame =animationframe;
        
        [self.scrollView addSubview:animationView];
        [animationView play];
        [self.animationViews addObject:animationView];
    }
}

-(void)setTextGroup:(NSArray *)textGroup{
    _textGroup = [NSArray arrayWithArray:textGroup];
     for (int i = 0 ; i < _textGroup.count; i++) {

         CGRect animationframe =  CGRectMake(0, 0, 300, 300);
         animationframe.origin.x = i * self.frame.size.width+self.center.x-150;
         animationframe.origin.y = self.center.y-300;

         ContentShineLabel *animationlabel = [[ContentShineLabel alloc]initWithFrame:CGRectMake(animationframe.origin.x, CGRectGetMaxY(animationframe)+50, animationframe.size.width, 64)];
         animationlabel.backgroundColor = [UIColor clearColor];
         animationlabel.fadeInDuration = 1.5;
         animationlabel.fadeOutDuration = 1.5;
         animationlabel.numberOfLines = 0;
         animationlabel.font = [UIFont systemFontOfSize:24.f];
         animationlabel.textAlignment = NSTextAlignmentCenter;
         animationlabel.textColor = [UIColor blackColor];
         animationlabel.text = self.textGroup[i];
         [self.animationLabels addObject:animationlabel];
         [self.scrollView addSubview:animationlabel];
         
         if (i == 0) {
             [animationlabel fadeIn];
         }else{
             [animationlabel fadeOut];
         }
    }
}


#pragma mark - button Action
- (void)nextButtonAction:(UIButton *)sender{
    if (_nextAction) {
        _nextAction(sender);
    }
}

#pragma mark - scrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = self.currentIndex;
    
    LOTAnimationView *view = self.animationViews[self.currentIndex];
    _animationSpeed == 0? ( view.animationSpeed = 2):( view.animationSpeed = _animationSpeed);
    [view stop];
    [view play];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.animationLabels[self.currentIndex] fadeOut];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.animationLabels[self.currentIndex] fadeIn];
}


#pragma mark - lazyload properties & UI initialize
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
   
    }
    return _scrollView;
}


-(UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [UIColor clearColor];
        _nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
        _nextButton.frame = CGRectMake(self.frame.size.width-64-64, self.frame.size.height-100-20, 64, 20);
        _nextButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(64, self.frame.size.height-100-20, 64, 20)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:228.0/255.0 green:66.0/255.0 blue:69.0/255.0 alpha:255.0/255.0];
    }
    return _pageControl;
}


- (NSMutableArray *)animationViews{
    if(!_animationViews){
        _animationViews = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _animationViews;
}


-(NSMutableArray *)animationLabels{
    if(!_animationLabels){
        _animationLabels = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _animationLabels;
}
@end


@interface ContentShineLabel ()
@property (strong, nonatomic) NSMutableAttributedString *attributedString;
@property (nonatomic, strong) NSMutableArray *characterAnimationDurations;
@property (nonatomic, strong) NSMutableArray *characterAnimationDelays;
@property (strong, nonatomic) CADisplayLink *displaylink;
@property (assign, nonatomic) CFTimeInterval beginTime;
@property (assign, nonatomic) CFTimeInterval endTime;
@property (assign, nonatomic, getter = isFadedOut) BOOL fadedOut;
@property (nonatomic, copy) void (^completion)(void);
@end


@implementation ContentShineLabel

-(instancetype)init{
    
    if ([super init]) {
        [self configLabel];
    }
    
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        [self configLabel];
    }
    
    return self;
}


-(void)configLabel{
    _fadeInDuration   = 2.5;
    _fadeOutDuration = 2.5;
    _autoStart       = NO;
    _fadedOut        = YES;
    self.textColor  = [UIColor whiteColor];
    _characterAnimationDurations = [NSMutableArray array];
    _characterAnimationDelays    = [NSMutableArray array];
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAttributedString)];
    
    _displaylink.paused = YES;
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setText:(NSString *)text
{
    self.attributedText = [[NSAttributedString alloc] initWithString:text];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    self.attributedString = [self initialAttributedStringFromAttributedString:attributedText];
    [super setAttributedText:self.attributedString];
    for (NSUInteger i = 0; i < attributedText.length; i++) {
        self.characterAnimationDelays[i] = @(arc4random_uniform(self.fadeInDuration / 2 * 100) / 100.0);
        CGFloat remain = self.fadeInDuration - [self.characterAnimationDelays[i] floatValue];
        self.characterAnimationDurations[i] = @(arc4random_uniform(remain * 100) / 100.0);
    }
}


/**
 当self被成功添加到视图层级上后调用
 */
-(void)didMoveToWindow{
    //判断拿到的window不为空，并且需要自动执行代码，就开始执行动画
    if (self.window!=nil&&self.autoStart) {
        [self fadeIn];
    }
}



- (void)fadeIn{
    [self fadeInWithCompletion:nil];
}


- (void)fadeInWithCompletion:(void (^)(void))completion{
    if (!self.isShining && self.isFadedOut) {
        self.completion = completion;
        self.fadedOut = NO;
        [self startAnimationWithDuration:self.fadeInDuration];
    }
}


- (void)fadeOut{
    [self fadeOutWithCompletion:nil];
}


- (void)fadeOutWithCompletion:( void (^)(void))completion{
    if (!self.isShining && !self.isFadedOut) {
        self.completion = completion;
        self.fadedOut = YES;
        [self startAnimationWithDuration:self.fadeOutDuration];
    }
}



- (void)startAnimationWithDuration:(CFTimeInterval)duration
{
    self.beginTime = CACurrentMediaTime();
    self.endTime = self.beginTime + self.fadeInDuration;
    self.displaylink.paused = NO;
}
- (BOOL)isShining
{
    return !self.displaylink.isPaused;
}

- (BOOL)isVisible
{
    return NO == self.isFadedOut;
}



-(void)updateAttributedString{
    CFTimeInterval now = CACurrentMediaTime();
    for (NSUInteger i = 0; i < self.attributedString.length; i ++) {
        
        if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:[self.attributedString.string characterAtIndex:i]]) {
            continue;
        }

        [self.attributedString enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(i, 1) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            
            CGFloat currentAlpha = CGColorGetAlpha([(UIColor *)value CGColor]);
            BOOL shouldUpdateAlpha = (self.isFadedOut && currentAlpha > 0) || (!self.isFadedOut && currentAlpha < 1) || (now - self.beginTime) >= [self.characterAnimationDelays[i] floatValue];
            if (!shouldUpdateAlpha) {
                return;
            }
            
            CGFloat percentage = (now - self.beginTime - [self.characterAnimationDelays[i] floatValue]) / ( [self.characterAnimationDurations[i] floatValue]);
            if (self.isFadedOut) {
                percentage = 1 - percentage;
            }
            
            UIColor *color = [self.textColor colorWithAlphaComponent:percentage];
            
            [self.attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
            
        }];
    }
    [super setAttributedText:self.attributedString];
    if (now > self.endTime) {
        self.displaylink.paused = YES;
        if (self.completion) {
            self.completion();
        }
    }
}



/**
 转换attributedString效果

 @param attributedString 需要处理的attributedString
 @return 透明的attributedString T：NSMutableAttributedString
 */
-(NSMutableAttributedString *)initialAttributedStringFromAttributedString:(NSAttributedString *)attributedString{
    NSMutableAttributedString *mutableAttributedString=[attributedString mutableCopy];
    UIColor *color=[self.textColor colorWithAlphaComponent:0];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
    return mutableAttributedString;
}

@end

