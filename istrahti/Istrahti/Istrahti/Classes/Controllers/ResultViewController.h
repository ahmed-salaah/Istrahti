//
//  ResultViewController.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "SearchParaData.h"
#import "THDatePickerViewController.h"


@interface ResultViewController : RootViewController <THDatePickerDelegate>

@property (nonatomic, strong) THDatePickerViewController * datePickr;
@property (nonatomic ,assign) BOOL displayList ;
@property (nonatomic ,strong) NSMutableArray *Lounges ;
@property (nonatomic ,strong) SearchParaData *searchParaData ;
@property (nonatomic ,strong) NSMutableArray *smallIcons ;
@property (nonatomic ,assign) int smallIconsCount ;

@property (nonatomic ,strong) NSDate *startFromDate;
@property (nonatomic ,strong) NSDate *endToDate;

@end