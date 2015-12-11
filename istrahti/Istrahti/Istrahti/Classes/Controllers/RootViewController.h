//
//  RootViewController.h
//  Estra7ty
//
//  Created by Ahmed Askar on 8/18/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "UIViewController+KNSemiModal.h"

@interface RootViewController : UIViewController

@property (strong, nonatomic) SWRevealViewController *viewController;

@property (weak, nonatomic) UIButton *backBtn ;

- (SWRevealViewController *)setSideBarMenu ;

@end
