//
//  SmallIconViewCell.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/29/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallIconsModel.h"

@interface SmallIconViewCell : UICollectionViewCell

@property (nonatomic ,weak) IBOutlet UIImageView *icon ;
@property (nonatomic ,weak) IBOutlet UILabel *name ;

- (void)setSmallIcon:(SmallIconsModel *)model ;

@end
