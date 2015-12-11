//
//  RootViewController.m
//  Estra7ty
//
//  Created by Ahmed Askar on 8/18/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "RootViewController.h"
#import "SearchViewController.h"
#import "SideMenuViewController.h"

@interface RootViewController () <SWRevealViewControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

    UIView *title = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190, 44)];
    
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(40, 7, 100, 25);
    titleImage.image = [UIImage imageNamed:@"header-logo.png"];
    [title addSubview:titleImage];
    self.navigationItem.titleView = title ;
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController tapGestureRecognizer];
    [revealController panGestureRecognizer];
    
//    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _backBtn.frame = CGRectMake(0, 0, 14, 22);
//    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
//    [_backBtn setHighlighted:NO];
//    [_backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    UIButton *reavelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reavelBtn.frame = CGRectMake(0, 0, 25, 22);
    [reavelBtn setBackgroundImage:[UIImage imageNamed:@"drawer.png"] forState:UIControlStateNormal];
    [reavelBtn setHighlighted:NO];
    [reavelBtn addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:reavelBtn];
}

- (SWRevealViewController *)setSideBarMenu
{
    SearchViewController *frontViewController = [[SearchViewController alloc] init];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    SideMenuViewController *sideViewController = [[SideMenuViewController alloc] init];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:nil frontViewController:navigation];
    
    revealController.delegate = self;
    
    revealController.rightViewController = sideViewController ;
    
    revealController.bounceBackOnOverdraw = NO;
    
    revealController.stableDragOnOverdraw = YES;
    
    self.viewController = revealController;
    
    return self.viewController ;
}

- (void)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
