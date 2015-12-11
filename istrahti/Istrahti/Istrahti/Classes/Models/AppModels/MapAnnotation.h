//
//  MapAnnotation.h
//  GuideMe
//
//  Created by Ahmed Askar on 1/10/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationModel.h"

@interface MapAnnotation : NSObject<MKAnnotation> {
    
@private
    NSString    *_title;
    NSString	*_subtitle;
}

@property (nonatomic, copy)		NSString	*title;
@property (nonatomic, copy)		NSString	*subtitle;
@property (nonatomic, strong)	LocationModel    *site;

@end