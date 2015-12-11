//
//  MapResultViewController.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Istrahati.pch"
#import "MapAnnotation.h"
#import "LocationModel.h"

@interface MapResultViewController : RootViewController
{
    NSMutableArray		*_sitesAnnotations;
    MapAnnotation       *_tappedAnnotation;
}

@property (nonatomic ,assign) BOOL displayMap ;

@end
