//
//  ViewController.m
//  WFCustomUICollectionViewDemo
//
//  Created by JackWong on 15/9/2.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "WFLayOut.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WFLayOutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createCollectionView];
}

- (void)createCollectionView {
//    webRTC
    WFLayOut *layOut = [[WFLayOut alloc] init];
    layOut.interSpace = 10;
    layOut.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layOut.colNum = 3;
    layOut.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layOut];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
}

- (CGFloat)itemHeightLayOut:(WFLayOut *)layOut indexPath:(NSIndexPath *)indexPath {
    
    return 100 + arc4random()%100;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.aLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
