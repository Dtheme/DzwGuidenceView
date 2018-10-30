//
//  DzwGuidenceView.h
//  DzwGuidenceView
//
//  Created by dzw on 2018/10/29.
//  Copyright © 2018 dzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DzwGuidenceView : UIView 

/**
 动画文件数组
 */
@property (nonatomic, strong) NSArray *animationsGroup;

/**
 文字数组
 */
@property (nonatomic, strong) NSArray *textGroup;

/**
 正常动画速度为1.0，demo默认动画速度为2.0
 */
@property (nonatomic, assign) CGFloat animationSpeed;

/**
 next按钮回调
 */
@property (nonatomic, copy) void(^nextAction)(UIButton *button);

@end


@interface ContentShineLabel : UILabel


/**
 渐入时长，默认是2.5秒
 */
@property (assign, nonatomic, readwrite) CFTimeInterval fadeInDuration;


/**
 渐出时长，默认是2.5秒
 */
@property (assign, nonatomic, readwrite) CFTimeInterval fadeOutDuration;

/*
  自动执行动画，默认是NO
 */
@property (assign, nonatomic, readwrite, getter = isAutoStart) BOOL autoStart;

/*
 ** 只读获取显示状态
 */
@property (assign, nonatomic, readonly, getter = isShining) BOOL shining;

/*
 ** 只读获取显示状态
 */
@property (assign, nonatomic, readonly, getter = isVisible) BOOL visible;

/*
 ** 外部方法
 */
- (void)fadeIn;
- (void)fadeInWithCompletion:(void (^)(void))completion;
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)(void))completion;
@end

