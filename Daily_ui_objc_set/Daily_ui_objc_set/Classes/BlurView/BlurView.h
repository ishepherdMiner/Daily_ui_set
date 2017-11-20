//
//  BlurView.h
//  NavScaleView
//
//  Created by Jason on 08/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurView : UIImageView

@property (nonatomic, strong) UIImage *originalImage;

@property (nonatomic, assign) CGFloat initialBlurLevel; // 初始模糊级别

@property (nonatomic, strong) UIScrollView *scrollView;

@end
