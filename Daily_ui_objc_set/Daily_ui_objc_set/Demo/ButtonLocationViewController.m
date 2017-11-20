//
//  ButtonLocationViewController.m
//  Daily_ui_objc_set
//
//  Created by Jason on 18/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "ButtonLocationViewController.h"
#import "JAButton.h"

@interface ButtonLocationViewController ()

@end

@implementation ButtonLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    JAButton *b = [[JAButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [self.view addSubview:b];
    
//    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
//    b.layer.borderColor = [UIColor blueColor].CGColor;
//    b.layer.borderWidth = 1;
//    [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    
//    // [1]
//    [b setTitle:@"测试" forState:UIControlStateNormal];
//    
//    // [2]
//    [b setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
//    [self.view addSubview:b];
//    [b.titleLabel sizeToFit];
//    b.imageEdgeInsets = UIEdgeInsetsMake(0, b.titleLabel.frame.size.width, 0, -b.titleLabel.frame.size.width);
//    b.titleEdgeInsets = UIEdgeInsetsMake(0, -b.imageView.frame.size.width, 0, b.imageView.frame.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
