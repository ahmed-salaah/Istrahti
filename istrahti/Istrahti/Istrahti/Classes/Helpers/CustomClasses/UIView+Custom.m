//
//  UIView+Custom.m
//  ZakatFund
//
//  Created by Ahmed Askar on 1/29/14.
//  Copyright (c) 2014 asgatech. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

- (void) setX:(int)x {
    
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void) setY:(int)y {
    
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (int) x {
    
    return self.frame.origin.x;
}

- (int) y {
    
    return self.frame.origin.y;
}

- (void)setHeight:(int)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height) ;
}

- (int)height
{
    return self.frame.size.height ;
}

@end