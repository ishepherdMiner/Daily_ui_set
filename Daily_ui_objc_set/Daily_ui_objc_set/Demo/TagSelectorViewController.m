//
//  TagSelectorViewController.m
//  Daily_ui_objc_set
//
//  Created by Jason on 10/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "TagSelectorViewController.h"
#import "JATagSelectorView.h"

@interface TagSelectorViewController () <JATagSelectorViewDataSource>
@property (nonatomic,strong) JATagSelectorView *tagSelectorView;
@end

@implementation TagSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    JATagSelectorView *tagSelectorView = [JATagSelectorView tagSelectorViewWithFrame:self.view.bounds clickBlock:^(JATagSelectorView *tagSelectorView, UIView *contentView, NSIndexPath *indexPath) {
        
        NSLog(@"当前点击:%@,%@",contentView,indexPath);
        
    }];
    
    // [tagSelectorView layoutWithColumns:3 lineSpace:15 interitemSpace:5 sectionInset:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    tagSelectorView.delegate = self;
    
    [self.view addSubview:tagSelectorView];
    _tagSelectorView = tagSelectorView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{            
            NSArray *datas = @[
                               @"篮球afdasdf",@"足球",@"羽毛球",@"乒乓球",@"排球",
                               @"网球afdasdf",@"高尔夫球",@"冰球",@"沙滩排球",@"棒球",
                               @"垒球",@"藤球afdasdf",@"毽球",@"台球",@"鞠蹴",@"板球",
                               @"壁球",@"沙壶afdasdf",@"冰壶",@"克郎球",@"橄榄球",
                               @"曲棍球",@"水球",@"马球afdasdf",@"保龄球",@"健身球",
                               @"门球",@"弹球afdasdf",
                               ];
            NSMutableArray *randListM = [NSMutableArray arrayWithCapacity:300];
            for (int i = 0; i < 300; ++i) {
                [randListM addObject:datas[arc4random() % [datas count]]];
            }
            self.tagSelectorView.datas = randListM;
            [self.tagSelectorView reloadData];
        });
    });
}

#pragma mark - JATagSelectorViewDataSource

- (NSInteger)numberOfSectionsInTagSelectorView:(JATagSelectorView *)selectorView {
    return 1;
}

- (NSInteger)tagSelectorView:(JATagSelectorView *)selectorView numberOfItemsInSection:(NSInteger)section {
    if (self.tagSelectorView.datas.count > 0) {
        return self.tagSelectorView.datas.count;
    }
    return 0;
}

- (UIView *)tagSelectorView:(JATagSelectorView *)selectorView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.text = self.tagSelectorView.datas[indexPath.row];
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    tagLabel.layer.cornerRadius = 5;
    tagLabel.layer.masksToBounds = true;
    [tagLabel sizeToFit];
    return tagLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
