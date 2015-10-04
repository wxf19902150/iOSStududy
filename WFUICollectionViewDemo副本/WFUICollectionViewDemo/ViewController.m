//
//  ViewController.m
//  WFUICollectionViewDemo
//
//  Created by JackWong on 15/9/2.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    NSMutableArray *_imagesArray;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self createCollectionView];
}

- (void)initData {
    _imagesArray = [NSMutableArray array];
    for (int i = 0; i < 51; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"JPG"];
        if (path) {
           [_imagesArray addObject:path];
        }
    }
    
    
}

- (void)createCollectionView {
    
    // 创建视图布局对象
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    // 设置左右之间的间隙(当间隙小于某一个值(需要),不起作用)
    layOut.minimumInteritemSpacing = 10;
    
    // 设置的上下之间的间隙
    layOut.minimumLineSpacing = 20;
    //设置每个 Item 的 size (宽高)
    layOut.itemSize = CGSizeMake(100, 100);
    //设置内容边界的距离
    layOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 指定它滚动的方向
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 创建 collectionView 类似九宫格布局的视图
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layOut];
    // 关联代理 类似于 tablview
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    // [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath] 创建的 cell必须注册,不注册的话就会崩溃, UITableViewCell 也可以以这种方式
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    
    //注册 collectionView 头部和尾部
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    // 注册 尾部 通过 kind 区分
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}
// 返回collectionView 视图的头部的CGSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 100);
}

//返回collectionView 的尾部 CGSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(200, 100);
}

// 返回collectionView头部或尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //获取collectionView 的头部
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];

        head.backgroundColor = [UIColor greenColor];
        
        return head;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //获取collectionView 的尾部
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor orangeColor];
        return footer;
    }
    
    return nil;
}
// 返回有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回一个分区有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArray.count;
}

// 返回 cell 对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor redColor];
    // 设置cell 被选中的背景
    cell.selectedBackgroundView = aView;
    
    cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:_imagesArray[indexPath.row]];
    
    return cell;
}

// 设置视图距边界的距离 UIEdgeInsets (通过代理设置)会覆盖掉前边设置的
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 10, 50, 10);
}
// 返回 Item 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(130, 150);
}

//点击某个 Item 会回调此协议方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section: %ld row: %ld",indexPath.section, indexPath.row);
    // 取消选中
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

// 是否允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
