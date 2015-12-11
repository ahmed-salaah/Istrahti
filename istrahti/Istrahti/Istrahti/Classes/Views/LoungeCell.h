//
//  LoungeCell.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "SearchData.h"
#import "AsyncImageView.h"
#import "HCSStarRatingView.h"
#import "SmallIconsModel.h"

@protocol BookingDelegate <NSObject>

- (void)bookNow:(NSString *)key ;

@end

@interface LoungeCell : UITableViewCell <UICollectionViewDataSource>

@property (weak ,nonatomic) id <BookingDelegate> delegate ;
@property (weak, nonatomic) IBOutlet AsyncImageView *loungeImage;
@property (weak, nonatomic) IBOutlet UILabel *loungeName;
@property (weak, nonatomic) IBOutlet UILabel *loungeDetails;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *review;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collection ;

@property (strong ,nonatomic) NSMutableArray *smallIcons;

- (IBAction)makeReservation:(id)sender;

@property (nonatomic ,weak) IBOutlet UIView *bgView ;
@property (nonatomic ,strong) NSString *Key ;
- (void)setLoungeData:(SearchData *)data;

@end
