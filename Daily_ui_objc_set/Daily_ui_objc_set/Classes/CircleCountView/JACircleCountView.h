//
//  JACircleCountView.h
//  Daily_ui_objc_set
//
//  Created by Jason on 19/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 开屏广告需要一个倒计时,封装下

@interface JACircleCountView : UIView

@property (nonatomic,assign) NSInteger times;
@property (nonatomic,copy) NSString *info;

- (instancetype)initWithTimes:(NSInteger)times;
- (void)start;
- (void)stopWithCompletedBlock:(void (^)())block;

@end
