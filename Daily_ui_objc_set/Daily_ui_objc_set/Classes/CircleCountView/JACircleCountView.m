//
//  JACircleCountView.m
//  Daily_ui_objc_set
//
//  Created by Jason on 19/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JACircleCountView.h"

@interface JACircleCountView ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation JACircleCountView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.origin.x + rect.size.width * 0.5 + 0.5,rect.origin.y + rect.size.height * 0.5+ 0.5) radius:rect.size.width * 0.5 - 5 startAngle:0.0 endAngle:M_PI_2 clockwise:true];
    
    [[UIColor redColor] setStroke];
    
    path.lineWidth = 5;
    [path stroke];
}

- (instancetype)initWithTimes:(NSInteger)times {
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 80;
    if (self = [super initWithFrame:CGRectMake(x, 80, 50, 50)]) {
        self.times = times;
         self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)start {
    [self.timer fire];
}

- (void)stopWithCompletedBlock:(void (^)())block{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        
        [self removeFromSuperview];
        
        if (block) {
            block();
        }
    }
}

@end
