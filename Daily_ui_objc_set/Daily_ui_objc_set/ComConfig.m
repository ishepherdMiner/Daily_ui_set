//
//  JAComConfig.m
//  Daily_ui_objc_set
//
//  Created by Jason on 17/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

#import "ComConfig.h"

@implementation ComConfig

- (NSArray *)dataList {
    if (_dataList == nil) {
        _dataList = @[
                      @{
                           @"name":@"弹窗",
                           @"ctrl":@"PopViewController"
                        },
                      @{
                           @"name":@"标签选择",
                           @"ctrl":@"TagSelectorViewController"
                        },
                      @{
                          @"name":@"环形倒计时",
                          @"ctrl":@"CircleCountViewController"
                          
                          },                      
                      @{
                          @"name":@"按钮中的标题与图片位置",
                          @"ctrl":@"ButtonLocationViewController"
                          },
                      @{
                          @"name":@"选择器",
                          @"ctrl":@"PickerViewController"
                          }
                      ];
    }
    return _dataList;
}

- (NSString *)moduleName {
    if (_moduleName == nil) {
        _moduleName = @"Daily_ui_objc_set";
    }
    return _moduleName;
}

+ (instancetype)sharedConfig {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
@end
