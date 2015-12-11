//
//  MapAnnotation.m
//  GuideMe
//
//  Created by Ahmed Askar on 1/10/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (id)init	{
    
    if (self = [super init])	{
        
    }
    return self;
}

#pragma mark -
#pragma mark MKAnnotation methods

- (NSString *)subtitle	{
    
    if (self.site.desc)
        return self.site.desc;
    
    return @"";
}

- (NSString *)title	{
    
    if (self.site.title)
        return self.site.title;
    
    return @"";
}

- (CLLocationCoordinate2D)coordinate
{
    double longitude	= self.site.longitude;
    double latitude		= self.site.latitude;

    CLLocationCoordinate2D coords;
    coords.longitude	= longitude;
    coords.latitude		= latitude;
    return coords;
}

@end
