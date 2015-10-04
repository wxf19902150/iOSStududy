//
//  WFLayOut.h
//  WFCustomUICollectionViewDemo
//
//  Created by JackWong on 15/9/2.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFLayOut;
@protocol WFLayOutDelegate <NSObject>

// 必须实现
@required
- (CGFloat)itemHeightLayOut:(WFLayOut *)layOut indexPath:(NSIndexPath *)indexPath;
@end

@interface WFLayOut : UICollectionViewFlowLayout {
    NSString *_name;
}

@property (nonatomic, weak) id<WFLayOutDelegate> delegate;

@property (nonatomic, assign) NSInteger colNum;

@property (nonatomic, assign) CGFloat interSpace;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end
