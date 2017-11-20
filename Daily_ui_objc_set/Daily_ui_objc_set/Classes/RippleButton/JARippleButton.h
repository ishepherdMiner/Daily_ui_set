//
//  JARippleButton.h
//  Summary
//
//  Created by Jason on 06/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE

@interface JARippleButton : UIButton

@property (nonatomic,strong) IBInspectable UIColor *rippleColor;
@property (nonatomic,strong) IBInspectable UIColor *rippleBackgroundColor;
@property (nonatomic,assign) IBInspectable CGFloat buttonCornerRadius;
@property (nonatomic,assign) IBInspectable CGFloat ripplePercent;
@property (nonatomic,assign) IBInspectable CGFloat shadowRippleRadius;
@property (nonatomic,assign) IBInspectable BOOL rippleOverBounds;
@property (nonatomic,assign) IBInspectable BOOL shadowRippleEnable;
@property (nonatomic,assign) IBInspectable BOOL trackTouchLocation;

/// 默认0.6s
@property (nonatomic,assign) IBInspectable CGFloat touchUpAnimationTime;

@property (nonatomic,strong) UIView *rippleView;
@property (nonatomic,strong) UIView *rippleBackgroundView;

// private
@property (nonatomic,assign) CGFloat tempShadowRadius;
@property (nonatomic,assign) CGFloat tempShadowOpacity;
@property (nonatomic,assign) CGPoint touchCenterLocation;

@property (nonatomic,strong) CAShapeLayer *rippleMask;

@end

NS_ASSUME_NONNULL_END
