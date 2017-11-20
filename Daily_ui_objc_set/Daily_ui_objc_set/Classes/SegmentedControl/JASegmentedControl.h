//
//  JASegmentedControl.h
//  RssMoney
//
//  Created by Jason on 02/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JASegmentedControl : UISegmentedControl

/// 反选触发的操作
@property (nonatomic,copy) void (^undoBlock)(NSInteger index);
@property (nonatomic,strong) UIButton *undoBtn;

@end
