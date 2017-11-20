//
//  JAButton.m
//  Daily_ui_objc_set
//
//  Created by Jason on 18/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JAButton.h"

@implementation JAButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 1;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        // [1]
        [self setTitle:@"测试" forState:UIControlStateNormal];
        
        // [2]
        [self setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // [3]
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
//    
//    // [4]
//    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
//    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-5, self.titleLabel.frame.size.width * 0.5, 5, -self.titleLabel.frame.size.width * 0.5);
    self.titleEdgeInsets = UIEdgeInsetsMake(5, -self.imageView.frame.size.width * 0.5, -5, self.imageView.frame.size.width * 0.5);
}
@end
