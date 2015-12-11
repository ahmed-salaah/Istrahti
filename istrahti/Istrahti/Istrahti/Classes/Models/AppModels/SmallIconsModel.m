//
//  SmallIconsModel.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/29/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SmallIconsModel.h"

@implementation SmallIconsModel

- (instancetype)initWithName:(NSString *)name andImage:(NSString *)imgName
{
    self = [super init];
    
    if (self) {
        _name = name ;
        _imageName = imgName ;
    }
    return self ;
}

@end