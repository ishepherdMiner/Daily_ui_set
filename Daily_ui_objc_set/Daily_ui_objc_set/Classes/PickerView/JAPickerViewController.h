//
//  JAPickerViewController.h
//  ActionSheetPickerDemo
//
//  Created by Jason on 24/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
// Migrate from AIDatePickerController

#import <UIKit/UIKit.h>

@interface JAPickerViewController : UIViewController

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,copy) void (^cancelBlock)();
@property (nonatomic,copy) void (^selectedBlock)(NSString *title);
@property (nonatomic,weak) UIViewController *controller;

+ (instancetype)pickerWithTitle:(NSArray <NSString *> *)titles
                  selectedBlock:(void (^)(NSString *title))selectedBlock
                    cancelBlock:(void (^)())cancelBlock;

// Custom
+ (instancetype)pickerWithTitle:(NSArray <NSString *> *)titles
                  selectedBlock:(void (^)(NSString *title))selectedBlock
                    cancelBlock:(void (^)())cancelBlock
          presentViewController:(UIViewController *)controller;

- (void)show;
- (void)dissmiss;

@end
