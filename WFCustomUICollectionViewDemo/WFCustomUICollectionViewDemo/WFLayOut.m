//
//  WFLayOut.m
//  WFCustomUICollectionViewDemo
//
//  Created by JackWong on 15/9/2.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import "WFLayOut.h"

@implementation WFLayOut {
    //装行高
    NSMutableArray *_columHeightArray;
    NSMutableArray *_attributeArray;
}

- (void)setColNum:(NSInteger)colNum {
    if (_colNum != colNum) {
        _colNum = colNum;
        //重新布局
        [self invalidateLayout];
    }
}
- (void)setInterSpace:(CGFloat)interSpace {
    if (_interSpace != interSpace) {
        _interSpace = interSpace;
        [self invalidateLayout];
    }
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
        [self invalidateLayout];
    }
}


/*
 Layout类中，有3个方法是必定会被依次调用：
 
 prepareLayout: 准备所有view的layoutAttribute信息
 
 collectionViewContentSize: 计算contentsize，显然这一步得在prepare之后进行
 
 layoutAttributesForElementsInRect: 返回在可见区域的view的layoutAttribute信息

 */
- (void)prepareLayout {
    [super prepareLayout];
    _columHeightArray = [NSMutableArray arrayWithCapacity:_colNum];
    _attributeArray = [NSMutableArray array];
    
    for (int index = 0; index < _colNum; index++) {
        // @( _edgeInsets.top) 等价于 [NSNumber numberWithFloat:_edgeInsets.top];
        _columHeightArray[index] = @(_edgeInsets.top);
    }
    
    //总宽度
    CGFloat totalWidth = self.collectionView.bounds.size.width;
    //每行所有 Item 的宽度
    CGFloat totalItemWidth = totalWidth - _edgeInsets.left - _edgeInsets.right - (_colNum - 1)*_interSpace;
    // 每个 Item 的宽度
    CGFloat itemWidth = totalItemWidth/_colNum;
    
    //拿到每个分区里边所有 Item 的个数
    NSInteger totalItems = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < totalItems; i++) {
        NSInteger currentCol = [self minCurrentCol];
        
        CGFloat xPos = _edgeInsets.left + (itemWidth + _interSpace)*currentCol;
        CGFloat yPos = [_columHeightArray[currentCol] floatValue];
        // 获取当前 Item 的 indexpath
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemheight = 0.0;
        if (_delegate && [_delegate respondsToSelector:@selector(itemHeightLayOut:indexPath:)]) {
            //通过代理返回行高
            itemheight = [_delegate itemHeightLayOut:self indexPath:indexpath];
        }
        CGRect frame = CGRectMake(xPos, yPos, itemWidth, itemheight);
        // 获取系统布局的 Item 位置信息
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        attribute.frame = frame;
        [_attributeArray addObject:attribute];
        CGFloat updateY = [_columHeightArray[currentCol] floatValue] + itemheight + _interSpace;
        _columHeightArray[currentCol] = @(updateY);
        
    }
}

- (CGSize)collectionViewContentSize {
    //    return CGSizeMake(0, 0);
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger integer = [self maxCurrentCol];
    CGFloat maxheight = [_columHeightArray[integer] floatValue];
    return CGSizeMake(width, maxheight);
}

// 接下来就要实现layoutAttributesForElementsInRect，这个通过CGRectIntersectsRect来选择是否在当前的rect里：
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _attributeArray) {
        CGRect rect1 = attributes.frame;
        NSLog(@"%@", NSStringFromCGRect(rect));
        if (CGRectIntersectsRect(rect1, rect)) {
            [resultArray addObject:attributes];
        }
    }
    return resultArray;
}

- (NSInteger)maxCurrentCol {
    
    __block CGFloat  maxHeight = 0;
    __block NSInteger maxIndex = 0;
    [_columHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightInarray = [_columHeightArray[idx] floatValue];
//        NSLog(@"idx - -- - - %ld",idx);
        if (heightInarray > maxHeight ) {
            maxHeight = heightInarray;
            maxIndex = idx;
        }
    }];
    return maxIndex;
}

// 每次取最小Y的列
- (NSInteger)minCurrentCol {
    __block CGFloat minHeight = MAXFLOAT;
    __block NSInteger minCol = 0;
    //遍历数组的 block
    [_columHeightArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightInArray = [_columHeightArray[idx] floatValue];
        if (heightInArray < minHeight) {
            minHeight = heightInArray;
            minCol = idx;
        }
//        _name = @"不需要加__Block";
        
    }];
    return minCol;
    
}
@end
