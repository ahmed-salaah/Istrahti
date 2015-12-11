//
//  CALayer+RuntimeAttribute.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/21/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "CALayer+RuntimeAttribute.h"

@implementation CALayer (RuntimeAttribute)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
