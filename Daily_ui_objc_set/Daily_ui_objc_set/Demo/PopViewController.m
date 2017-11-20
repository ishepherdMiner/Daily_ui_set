//
//  PopViewController.m
//  Daily_ui_objc_set
//
//  Created by Jason on 04/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "PopViewController.h"
#import "JAPopView.h"

@interface PopViewController () <JAPopViewDelegate>

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showPopView1:nil];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"窗1" style:UIBarButtonItemStylePlain target:self action:@selector(showPopView1:)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"窗2" style:UIBarButtonItemStylePlain target:self action:@selector(showPopView2:)];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"窗3" style:UIBarButtonItemStylePlain target:self action:@selector(showPopView3:)];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"窗4" style:UIBarButtonItemStylePlain target:self action:@selector(showPopView4:)];
    
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithTitle:@"窗5" style:UIBarButtonItemStylePlain target:self action:@selector(showPopView5:)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3,item4,item5];
}

- (void)showPopView1:(UIBarButtonItem *)buttonItem {
    JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeSingle];
    popView.topDistance = 100;
    popView.delegate = self;
    
    // JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeSingle delegate:self];
 
    UIButton *btn = [popView actionWithTitle:@"你好"
                                       style:JAPopViewActionStyleEnsure
                                     handler:^(UIButton *btn) {
                                         
                                         NSLog(@"点击你好按钮");
                                     }];
    [popView addAction:btn];
    
    [self.view addSubview:popView];
}

- (void)showPopView2:(UIBarButtonItem *)buttonItem {
    JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeAverage];
    popView.topDistance = 100;
    popView.delegate = self;
    
    UIButton *btn = [popView actionWithTitle:@"确定"
                                       style:JAPopViewActionStyleEnsure
                                     handler:^(UIButton *btn) {
                                         
                                         NSLog(@"点击确定按钮");
                                     }];
    [popView addAction:btn];
    
    UIButton *btn2 = [popView actionWithTitle:@"取消"
                                       style:JAPopViewActionStyleCancel
                                     handler:^(UIButton *btn) {
                                         
                                         NSLog(@"点击取消按钮");
                                     }];
    [popView addAction:btn2];
    
    [self.view addSubview:popView];
}

- (void)showPopView3:(UIBarButtonItem *)sender {
    JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeThreeMouth];
    
    popView.delegate = self;
    
    popView.topDistance = 100;
    
    UIButton *btn = [popView actionWithTitle:@"你不好"
                                       style:JAPopViewActionStyleEnsure
                                     handler:^(UIButton *btn) {
                                         
                                         NSLog(@"点击你不好按钮");
                    }];
    [popView addAction:btn];
     
    UIButton *btn2 = [popView actionWithTitle:@"对吗"
                                        style:JAPopViewActionStyleExec
                                      handler:^(UIButton *btn) {
     
                                          NSLog(@"点击对吗按钮");
                    }];
    [popView addAction:btn2];
     
    UIButton *btn3 = [popView actionWithTitle:@"不对"
                                        style:JAPopViewActionStyleCancel
                                      handler:^(UIButton *btn) {
                                           
                                           NSLog(@"点击不对按钮");
                     }];
    [popView addAction:btn3];
    [self.view addSubview:popView];
     
}

- (void)showPopView4:(UIBarButtonItem *)sender {
    JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeAlignHorizontal];
    
    popView.delegate = self;
    
    popView.topDistance = 100;
    
    UIButton *btn = [popView actionWithTitle:@"确定"
                                       style:JAPopViewActionStyleEnsure
                                     handler:^(UIButton *btn) {
                                         
                                         NSLog(@"点击确定按钮");
                                     }];
    [popView addAction:btn];
    
    UIButton *btn2 = [popView actionWithTitle:@"取消"
                                        style:JAPopViewActionStyleCancel
                                      handler:^(UIButton *btn) {
                                          
                                          NSLog(@"点击取消按钮");
                                          
                                          JAPopView *popView2 = [JAPopView popViewWithType:JAPopViewTypeAlignHorizontal];
                                          popView2.delegate = self;
                                          popView2.topDistance = 100;
                                          UIButton *btn21 = [popView2 actionWithTitle:@"确定"
                                                                             style:JAPopViewActionStyleEnsure
                                                                           handler:^(UIButton *btn) {
                                                                               
                                                                               NSLog(@"点击确定按钮");
                                                                           }];
                                          [popView2 addAction:btn21];                                          
                                          [popView2 addWindow];
                                      }];
    [popView addAction:btn2];
    
    UIButton *btn3 = [popView actionWithTitle:@"取消"
                                        style:JAPopViewActionStyleCancel
                                      handler:^(UIButton *btn) {
                                          
                                          NSLog(@"点击取消按钮");
                                      }];
    [popView addAction:btn3];
    
//    UIButton *btn4 = [popView actionWithTitle:@"取消"
//                                        style:JAPopViewActionStyleCancel
//                                      handler:^(UIButton *btn) {
//                                          
//                                          NSLog(@"点击取消按钮");
//                                      }];
//    [popView addAction:btn4];
    [self.view addSubview:popView];
}

- (void)showPopView5:(UIBarButtonItem *)sender {
    
    JAPopView *popView = [JAPopView popViewWithType:JAPopViewTypeNone];
    
    popView.delegate = self;
    
    popView.topDistance = 100;
    
    [self.view addSubview:popView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - JAPopViewDelegate
- (UIView *)popViewProviderContent:(JAPopView *)popView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popViewWidth, 100)];
    UILabel *titleLabel = [[UILabel alloc] init];
    
    CGRect frame = titleLabel.frame;
    frame.size.width = 240;
    frame.origin.y = 20;
    titleLabel.frame = frame;
    
    NSArray *contents = @[
                          @"提供弹窗内容视图",
                          @"提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图",
                          @"提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图提供弹窗内容视图"
                          ];
    
    titleLabel.text = contents[arc4random() % contents.count];
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(contentView.center.x,titleLabel.center.y);
    
    if (CGRectGetMaxY(titleLabel.frame) >= CGRectGetHeight(contentView.frame)) {
        CGRect contentFrame = contentView.frame;
        
        // popViewTop = 100;
        
        /*
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            CGFloat offsetY =  CGRectGetHeight(titleLabel.frame) - CGRectGetHeight(contentView.frame);
            // 修改距离顶部的偏移量
            popViewTop -= offsetY;
        });
        */
        
        contentFrame.size.height = CGRectGetMaxY(titleLabel.frame) + 10;
        contentView.frame = contentFrame;
        
        [popView refreshWithContentViewFrame:contentFrame];
    }
    
    [contentView addSubview:titleLabel];
    return contentView;
}

@end
