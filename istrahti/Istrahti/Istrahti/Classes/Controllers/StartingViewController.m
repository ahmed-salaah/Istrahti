//
//  StartingViewController.m
//  Estra7ty
//
//  Created by Ahmed Askar on 8/17/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "StartingViewController.h"
#import "SideMenuViewController.h"
#import "RootViewController.h"

@interface StartingViewController () <SWRevealViewControllerDelegate>

@end

@implementation StartingViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    RootViewController *searchView = [[RootViewController alloc] init];
    UIViewController *viewController = [searchView setSideBarMenu];
    [[appDelegate window] setRootViewController:viewController];
//    [self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
//    [self presentViewController:viewController animated:NO completion:nil];
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
