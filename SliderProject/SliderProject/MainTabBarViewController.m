//
//  MainTabBarViewController.m
//  SliderProject
//
//  Created by  江志磊 on 15-3-12.
//  Copyright (c) 2015年 江 志磊. All rights reserved.
//

#import "MainTabBarViewController.h"
//最近联系人
#import "RecentlyViewController.h"
//联系人
#import "FriendViewController.h"
//动态
#import "NewViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViewControllers];
    // Do any additional setup after loading the view.
}

-(void)createViewControllers{
    RecentlyViewController*vc1=[[RecentlyViewController alloc]init];
    vc1.title=@"消息";
    UINavigationController*nc1=[[UINavigationController alloc]initWithRootViewController:vc1];
    
    FriendViewController*vc2=[[FriendViewController alloc]init];
    vc2.title=@"联系人";
    UINavigationController*nc2=[[UINavigationController alloc]initWithRootViewController:vc2];
    
    NewViewController*vc3=[[NewViewController alloc]init];
    vc3.title=@"动态";
    UINavigationController*nc3=[[UINavigationController alloc]initWithRootViewController:vc3];
    self.viewControllers=@[nc1,nc2,nc3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
