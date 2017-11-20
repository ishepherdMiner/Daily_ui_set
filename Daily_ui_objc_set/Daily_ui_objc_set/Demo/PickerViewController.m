//
//  PickerViewController.m
//  Daily_ui_objc_set
//
//  Created by Jason on 25/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "PickerViewController.h"
#import "JAPickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[JAPickerViewController pickerWithTitle:@[@"1年",@"3年",@"5年"] selectedBlock:^(NSString *title) {
    
        NSLog(@"选择了%@",title);
        
    } cancelBlock:^{
        
    } presentViewController:self] show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
