//
//  JARippleButton.m
//  Summary
//  只是将
//  https://github.com/zoonooz/ZFRippleButton
//  从 Swift 翻译成 ObjC
//  Created by Jason on 06/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JARippleButton.h"

@implementation JARippleButton

@synthesize ripplePercent = _ripplePercent,rippleColor = _rippleColor,rippleBackgroundColor = _rippleBackgroundColor,buttonCornerRadius = _buttonCornerRadius;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    [self setupRippleView];
    
    self.rippleBackgroundView.backgroundColor = self.rippleBackgroundColor;
    self.rippleBackgroundView.frame = self.bounds;
    [self.rippleBackgroundView addSubview:self.rippleView];
    self.rippleBackgroundView.alpha = 0;
    [self addSubview:self.rippleBackgroundView];
    
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.trackTouchLocation) {
        self.touchCenterLocation = [touch locationInView:self];
    }else {
        self.touchCenterLocation = CGPointZero;
    }
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.rippleBackgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    self.rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.rippleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.shadowRippleEnable) {
        self.tempShadowRadius = self.layer.shadowRadius;
        self.tempShadowOpacity = self.layer.shadowOpacity;
        
        CABasicAnimation *shadowAnim = [[CABasicAnimation alloc] init];
        shadowAnim.toValue = @(self.shadowRippleRadius);
        
        CABasicAnimation *opacityAnim = [[CABasicAnimation alloc] init];
        opacityAnim.toValue = @1;
        
        CAAnimationGroup *groupAnim = [[CAAnimationGroup alloc] init];
        groupAnim.duration = 0.7;
        groupAnim.fillMode = kCAFillModeForwards;
        groupAnim.removedOnCompletion = false;
        groupAnim.animations = @[shadowAnim,opacityAnim];
        
        [self.layer addAnimation:groupAnim forKey:@"shadow"];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}
//
- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    [self animateToNormal];
}
//
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    [self animateToNormal];
}
//
- (void)animateToNormal {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.rippleBackgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.touchUpAnimationTime delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.rippleBackgroundView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.rippleView.transform = CGAffineTransformIdentity;
        
        CABasicAnimation *shadowAnim = [[CABasicAnimation alloc] init];
        shadowAnim.toValue = @(self.tempShadowRadius);
        
        CABasicAnimation *opacityAnim = [[CABasicAnimation alloc] init];
        opacityAnim.toValue = @(self.tempShadowOpacity);
        
        CAAnimationGroup *groupAnim = [[CAAnimationGroup alloc] init];
        groupAnim.duration = 0.7;
        groupAnim.fillMode = kCAFillModeForwards;
        groupAnim.removedOnCompletion = false;
        groupAnim.animations = @[shadowAnim,opacityAnim];
        
        [self.layer addAnimation:groupAnim forKey:@"shadowBack"];
        
        
    } completion:^(BOOL finished) {
        
    }];
}

//
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupRippleView];
    
    if (!CGPointEqualToPoint(self.touchCenterLocation, CGPointZero)) {
        self.rippleView.center = self.touchCenterLocation;
    }
    
    self.rippleBackgroundView.layer.frame = self.bounds;
    self.rippleBackgroundView.layer.mask = self.rippleMask;
}

//
- (UIView *)rippleView {
    if (_rippleView == nil) {
        _rippleView = [[UIView alloc] init];
    }
    return _rippleView;
}
//
- (UIView *)rippleBackgroundView {
    if (_rippleBackgroundView == nil) {
        _rippleBackgroundView = [[UIView alloc] init];
    }
    return _rippleBackgroundView;
}

- (CGFloat)ripplePercent {
    if (_ripplePercent == 0) {
        _ripplePercent = 0.8;
    }
    return _ripplePercent;
}

- (void)setRipplePercent:(CGFloat)ripplePercent {
    _ripplePercent = ripplePercent;
    [self setupRippleView];
}

- (void)setupRippleView {
    CGFloat size = self.frame.size.width * self.ripplePercent;
    CGFloat x = (self.frame.size.width / 2) - (size / 2);
    CGFloat y = (self.frame.size.height / 2) - (size / 2);
    CGFloat corner = size / 2;
    
    self.rippleView.backgroundColor = self.rippleColor;
    self.rippleView.frame = CGRectMake(x, y, size, size);
    self.rippleView.layer.cornerRadius = corner;
}

- (UIColor *)rippleColor {
    if (_rippleColor == nil) {
        _rippleColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _rippleColor;
}

- (void)setRippleColor:(UIColor *)rippleColor {
    _rippleColor = rippleColor;
    self.rippleView.backgroundColor = rippleColor;
}

- (UIColor *)rippleBackgroundColor {
    if (_rippleBackgroundColor == nil) {
        _rippleBackgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _rippleBackgroundColor;
}

- (void)setRippleBackgroundColor:(UIColor *)rippleBackgroundColor {
    _rippleBackgroundColor = rippleBackgroundColor;
    self.rippleBackgroundView.backgroundColor = rippleBackgroundColor;
}

- (CGFloat)buttonCornerRadius {
    if (_buttonCornerRadius == 0) {
        _buttonCornerRadius = 0;
    }
    return _buttonCornerRadius;
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius {
    _buttonCornerRadius = buttonCornerRadius;
    self.layer.cornerRadius = buttonCornerRadius;
}

- (BOOL)rippleOverBounds {
    if (_rippleOverBounds == false) {
        _rippleOverBounds = false;
    }
    return _rippleOverBounds;
}

- (CGFloat)shadowRippleRadius {
    if (_shadowRippleRadius == 0) {
        _shadowRippleRadius = 1;
    }
    return _shadowRippleRadius;
}

- (BOOL)shadowRippleEnable {
    if (_shadowRippleEnable == false) {
        _shadowRippleEnable = true;
    }
    return _shadowRippleEnable;
}

- (BOOL)trackTouchLocation {
    if (_trackTouchLocation == false) {
        _trackTouchLocation = false;
    }
    return _trackTouchLocation;
}

- (CGFloat)touchUpAnimationTime {
    if (_touchUpAnimationTime == 0) {
        _touchUpAnimationTime = 0.6;
    }
    return _touchUpAnimationTime;
}

- (CGFloat)tempShadowRadius {
    if (_tempShadowRadius == 0) {
        _tempShadowRadius = 0;
    }
    return _tempShadowRadius;
}

- (CGFloat)tempShadowOpacity {
    if (_tempShadowOpacity == 0) {
        _tempShadowOpacity = 0;
    }
    return _tempShadowOpacity;
}

- (CGPoint)touchCenterLocation {
    if (CGPointEqualToPoint(CGPointZero, _touchCenterLocation)) {
        _touchCenterLocation = CGPointZero;
    }
    return _touchCenterLocation;
}

- (CAShapeLayer *)rippleMask {
    if (_rippleOverBounds == false) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
        return maskLayer;
    }
    return nil;
}

@end
