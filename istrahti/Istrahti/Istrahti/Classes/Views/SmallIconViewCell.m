//
//  SmallIconViewCell.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/29/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SmallIconViewCell.h"

@implementation SmallIconViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSmallIcon:(SmallIconsModel *)model
{
    _icon.image = [UIImage imageNamed:model.imageName] ;
    _name.text = model.name ;
}

@end
