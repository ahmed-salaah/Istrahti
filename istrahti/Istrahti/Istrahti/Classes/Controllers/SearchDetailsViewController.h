//
//  SearchDetailsViewController.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/26/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "JOLImageSlider.h"
#import "JOLImageSlide.h"
#import "iCarousel.h"
#import "HCSStarRatingView.h"
@interface SearchDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong)NSString* idstring;
@property (weak, nonatomic) IBOutlet JOLImageSlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *istrahaNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *istrahaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *istrahaPhone;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *istrahaDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)forwardAction:(id)sender;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateView;
@end
