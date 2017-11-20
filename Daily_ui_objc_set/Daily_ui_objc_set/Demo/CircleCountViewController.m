//
//  CircleCountViewController.m
//  Daily_ui_objc_set
//
//  Created by Jason on 19/04/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "CircleCountViewController.h"
#import "JACircleCountView.h"

@interface CircleCountViewController ()

@property (nonatomic,strong) JACircleCountView *circleCountView;

@end

@implementation CircleCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    JACircleCountView *circleCountView = [[JACircleCountView alloc] initWithTimes:3];
    circleCountView.info = @"跳过";
    [self.view addSubview:_circleCountView = circleCountView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
