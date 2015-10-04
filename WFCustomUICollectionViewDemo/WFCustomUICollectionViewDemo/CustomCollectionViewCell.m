//
//  CustomCollectionViewCell.m
//  WFCustomUICollectionViewDemo
//
//  Created by JackWong on 15/9/2.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _aLabel = [[UILabel alloc] initWithFrame:frame];
        
        _aLabel.textColor = [UIColor yellowColor];
        _aLabel.font = [UIFont boldSystemFontOfSize:30];
        _aLabel.adjustsFontSizeToFitWidth = YES;
        _aLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aLabel];
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _aLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
