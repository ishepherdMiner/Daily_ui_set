//
//  JATagSelectorView.h
//  Daily_ui_objc_set
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JATagSelectorView;

@protocol JATagSelectorViewDataSource <NSObject>

@required

/**
 提供每组的数量

 @param selectorView JATagSelectorView对象
 @param section 组别
 @return 数量
 */
- (NSInteger)tagSelectorView:(JATagSelectorView *)selectorView
      numberOfItemsInSection:(NSInteger)section;

/**
 提供每个位置具体的视图

 @param selectorView JATagSelectorView对象
 @param indexPath 具体第几组,第几个
 @return cell的内容视图
 */
- (UIView *)tagSelectorView:(JATagSelectorView *)selectorView
     cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTagSelectorView:(JATagSelectorView *)selectorView;


/**
 提供每个位置具体的视图的宽度

 @param selectorView JATagSelectorView对象
 @param indexPath 具体第几组,第几个
 @return cell的宽度
 */
- (CGFloat)tagSelectorView:(JATagSelectorView *)selectorView
        widthAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface JATagSelectorView : UIView

@property (nonatomic,strong) NSArray *datas;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic) CGFloat interitemSpace;
@property (nonatomic) UIEdgeInsets sectionInset;
@property (nonatomic) NSInteger columns;  // 列数
@property (nonatomic,weak) id<JATagSelectorViewDataSource> delegate;

+ (instancetype)tagSelectorViewWithFrame:(CGRect)frame                                   
                              clickBlock:(void (^)(JATagSelectorView *tagSelectorView,UIView *contentView,NSIndexPath *indexPath))clickBlock;


- (void)layoutWithColumns:(NSUInteger)columns
                lineSpace:(CGFloat)lineSpace
           interitemSpace:(CGFloat)interitemSpace
             sectionInset:(UIEdgeInsets)sectionInset;

- (void)reloadData;

@end
