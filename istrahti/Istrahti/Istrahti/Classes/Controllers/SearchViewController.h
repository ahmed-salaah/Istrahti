//
//  SearchViewController.h
//  Estra7ty
//
//  Created by Ahmed Askar on 8/17/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "THDatePickerViewController.h"

@interface SearchViewController : RootViewController <THDatePickerDelegate>

@property (nonatomic, strong) THDatePickerViewController * datePickr;

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;

@end