//
//  JATagSelectorView.m
//  Daily_ui_objc_set
//
//  Created by Jason on 09/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JATagSelectorView.h"
#import <objc/message.h>

const char *cellKey = "tagSelectorCellKey";

@protocol JATagFlowLayoutDelegate <NSObject>

/**
 提供宽度

 @param collectionView 布局对应的collectionView对象
 @param indexPath indexPath对象
 @return 宽度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
       widthAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface JATagFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) NSUInteger columns;
@property (nonatomic,strong) NSMutableArray *originXs;
@property (nonatomic,strong) NSMutableArray *originYs;
@property (nonatomic) CGFloat rowHeight; // 行高
@property (nonatomic) CGFloat preWidth;
@property (nonatomic) id<JATagFlowLayoutDelegate> delegate;

@end

@implementation JATagFlowLayout

#pragma mark - 当尺寸/偏移量变化时，重新刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    CGPoint oldOffset = self.collectionView.contentOffset;
    
    if ((CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) ||
        (CGRectGetHeight(newBounds) != CGRectGetHeight(oldBounds))) {
        return true;
    }
    
    // 当偏移量大于行高时,刷新
    if (oldOffset.y > self.rowHeight) { return true; }
    
    return false;
}


- (void)prepareLayout {
    [super prepareLayout];
}

#pragma mark - 处理所有的Item的layoutAttributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    for(UICollectionViewLayoutAttributes *attrs in array){
        //类型判断
        if(attrs.representedElementCategory == UICollectionElementCategoryCell){
            UICollectionViewLayoutAttributes *theAttrs = [self layoutAttributesForItemAtIndexPath:attrs.indexPath];
            attrs.frame = theAttrs.frame;
        }
    }
    return array;
}
#pragma mark - 处理单个的Item的layoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    CGFloat x = self.sectionInset.left;
    // 如果有sectionheader需要加上sectionheader高度
    CGFloat y = self.headerReferenceSize.height + self.sectionInset.top;
    //判断获得前一个cell的x和y
    NSInteger preRow = indexPath.row - 1;
    if(preRow >= 0){
        if(_originYs.count > preRow){
            x = [_originXs[preRow] floatValue];
            y = [_originYs[preRow] floatValue];
        }
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:preRow inSection:indexPath.section];
        CGFloat preWidth = [self.delegate collectionView:self.collectionView widthAtIndexPath:preIndexPath];
        x += preWidth + self.minimumInteritemSpacing;
    }
    
    CGFloat currentWidth = [self.delegate collectionView:self.collectionView widthAtIndexPath:indexPath];
    //保证一个cell不超过最大宽度
    currentWidth = MIN(currentWidth, self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right);
    if(x + currentWidth > self.collectionView.frame.size.width - self.sectionInset.right){
        //超出范围，换行
        x = self.sectionInset.left;
        y += _rowHeight + self.minimumLineSpacing;
    }

    attrs.frame = CGRectMake(x, y, currentWidth, _rowHeight);
    _originXs[indexPath.row] = @(x);
    _originYs[indexPath.row] = @(y);
    return attrs;
}

#pragma mark - CollectionView的滚动范围
- (CGSize)collectionViewContentSize{
    CGFloat width = self.collectionView.frame.size.width;
    
    __block CGFloat maxY = 0;
    [_originYs enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number floatValue] > maxY) {
            maxY = [number floatValue];
        }
    }];
    
    return CGSizeMake(width, maxY + _rowHeight + self.sectionInset.bottom);
}

@end

@interface JATagSelectorView () <UICollectionViewDataSource,UICollectionViewDelegate,JATagFlowLayoutDelegate>

@property (nonatomic,copy) void (^clickBlock)(JATagSelectorView *tagSelectorView,UIView *contentView,NSIndexPath *indexPath);
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) JATagFlowLayout *flowLayout;
@property (nonatomic,strong) NSArray *randDatas; // 随机绘制
@end

@implementation JATagSelectorView

+ (instancetype)tagSelectorViewWithFrame:(CGRect)frame
                              clickBlock:(void (^)(JATagSelectorView *tagSelectorView,UIView *contentView,NSIndexPath *indexPath))clickBlock{
    
    JATagSelectorView *tagView = [[JATagSelectorView alloc] initWithFrame:frame];
    tagView.clickBlock = clickBlock;
    return tagView;
}

- (void)layoutWithColumns:(NSUInteger)columns
                lineSpace:(CGFloat)lineSpace
           interitemSpace:(CGFloat)interitemSpace
             sectionInset:(UIEdgeInsets)sectionInset {
    
    JATagFlowLayout *flowLayout = [[JATagFlowLayout alloc] init];
    flowLayout.rowHeight = 28;
    flowLayout.minimumLineSpacing = lineSpace;
    flowLayout.minimumInteritemSpacing = interitemSpace;
    flowLayout.sectionInset = sectionInset;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.originXs = [NSMutableArray array];
    flowLayout.originYs = [NSMutableArray array];
    flowLayout.columns = columns;
    flowLayout.delegate = self;
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                                       collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"tagSelector"];
    collectionView.dataSource = self;
    collectionView.delegate = self;

    self.lineSpace = lineSpace;
    self.interitemSpace = interitemSpace;
    self.sectionInset = sectionInset;
    self.columns = columns;
    
    [self addSubview:_collectionView = collectionView];
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.collectionView reloadData];
    });
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self layoutWithColumns:self.columns lineSpace:self.lineSpace interitemSpace:self.interitemSpace sectionInset:self.sectionInset];
        [self reloadData];
    }
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInTagSelectorView:)]) {
        // 代理
        return [self.delegate numberOfSectionsInTagSelectorView:self];
    }else if(self.datas.count > 0) {
        // 二维数组
        if ([self.datas[arc4random() % (self.datas.count)] isKindOfClass:[NSArray class]]) {
            return self.datas.count;
        }
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tagSelectorView:numberOfItemsInSection:)]) {
        return [self.delegate tagSelectorView:self numberOfItemsInSection:section];
    }else if (self.datas.count > 0) {
        // 二维数组
        if ([self.datas[arc4random() % (self.datas.count)] isKindOfClass:[NSArray class]]) {
            return [self.datas[section] count];
        }
    }
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagSelector" forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(tagSelectorView:cellForItemAtIndexPath:)]) {
        if (objc_getAssociatedObject(cell.contentView,cellKey)) {
            UIView *v = objc_getAssociatedObject(cell.contentView,cellKey);
            [v removeFromSuperview];
            objc_setAssociatedObject(cell.contentView, cellKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        UIView *sView = [self.delegate tagSelectorView:self cellForItemAtIndexPath:indexPath];
        sView.frame = cell.contentView.bounds;
        sView.userInteractionEnabled = true;        
        [cell.contentView addSubview:sView];
        objc_setAssociatedObject(cell.contentView, cellKey, sView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickBlock) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIView *cView = objc_getAssociatedObject(cell.contentView, cellKey);
        self.clickBlock(self,cView,indexPath);
    }
}

#pragma mark - JATagFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView widthAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tagSelectorView:widthAtIndexPath:)]) {
        return [self.delegate tagSelectorView:self widthAtIndexPath:indexPath];
    }else if (self.datas.count > 0){
        if ([self.datas[arc4random() % (self.datas.count)] isKindOfClass:[NSArray class]]) {
            
            // 二维
            return ([UIScreen mainScreen].bounds.size.width - (self.sectionInset.left + self.sectionInset.right) * self.columns - 15 - self.interitemSpace * (self.columns - 1) + [[self randDatasWithCount:self.datas.count][indexPath.section][indexPath.row] doubleValue]) / self.columns;
            
        }else {
            
            return ([UIScreen mainScreen].bounds.size.width - (self.sectionInset.left + self.sectionInset.right) * self.columns - 15 - self.interitemSpace * (self.columns - 1) + [[self randDatasWithCount:self.datas.count][indexPath.row] doubleValue]) / self.columns ;
        }
    }
    return ([UIScreen mainScreen].bounds.size.width - (self.sectionInset.left + self.sectionInset.right) * self.columns - self.interitemSpace * (self.columns - 1)) / self.columns;
}

- (NSArray *)randDatasWithCount:(NSInteger)count{
    if (_randDatas == nil) {
        NSArray *randTable = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15];
        NSMutableArray *randDatasM = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; ++i) {
            [randDatasM addObject:randTable[arc4random() % [randTable count]]];
        }
        _randDatas = [randDatasM copy];
    }
    return _randDatas;
}



#pragma mark - 懒加载
- (CGFloat)lineSpace {
    if (_lineSpace == 0) {
        _lineSpace = 5;
    }
    return _lineSpace;
}

- (NSInteger)columns {
    if (_columns == 0) {
        _columns = 4;
    }
    return _columns;
}

- (CGFloat)interitemSpace {
    if (_interitemSpace == 0) {
        _interitemSpace = 10;
    }
    return _interitemSpace;
}

- (UIEdgeInsets)sectionInset {
    if (UIEdgeInsetsEqualToEdgeInsets(_sectionInset, UIEdgeInsetsZero)) {
        _sectionInset = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return _sectionInset;
}
@end
