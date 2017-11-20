//
//  JASegmentedControl.m
//  RssMoney
//
//  Created by Jason on 02/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JASegmentedControl.h"
#import "JACategory.h"

@interface JASegmentedControl ()

@end

@implementation JASegmentedControl

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_undoBtn == nil) {
        _undoBtn = [[UIButton alloc] initWithFrame:CGRectMake(-1 * self.w / self.numberOfSegments, 0, self.w / self.numberOfSegments, self.h)];
        // _undoBtn.backgroundColor = [UIColor whiteColor];
        [_undoBtn addTarget:self action:@selector(unselectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_undoBtn];
    }else {
        // 切换时,segmentControl中的segment层级会变化,一时想不到比较好的解决方法
        [self bringSubviewToFront:_undoBtn];
    }
}

- (void)unselectedAction:(UIButton *)sender {
    if (self.undoBlock) {
        self.undoBlock([self selectedSegmentIndex]);
    }
}

- (NSInteger)selectedSegmentIndex {
    NSInteger index = [super selectedSegmentIndex];
    
    if (_undoBtn.x < 0 || _undoBtn.x != index * self.w / self.numberOfSegments) {
        _undoBtn.x = index * self.w / self.numberOfSegments;
    }
    return index;
}

@end
