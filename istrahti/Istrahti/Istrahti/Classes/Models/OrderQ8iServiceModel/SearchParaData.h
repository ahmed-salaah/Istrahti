//
//  SearchParaData.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/28/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParaData : NSObject

@property (nonatomic ,strong) NSString *City ;
@property (nonatomic ,strong) NSString *DateFrom ;
@property (nonatomic ,strong) NSString *DateTo ;
@property (nonatomic ,assign) BOOL HalfDay ;
@property (nonatomic ,strong) NSString *Time;
@property (nonatomic ,strong) NSString *Type ;
@property (nonatomic ,assign) int Page ;
@property (nonatomic ,strong) NSString *SortBy ;


@property (nonatomic ,assign) NSNumber *Singles ;
@property (nonatomic ,assign) NSNumber *Family ;
@property (nonatomic ,assign) NSNumber *Events ;
@property (nonatomic ,assign) NSNumber *KidsPlay ;
@property (nonatomic ,assign) NSNumber *SwimmingPool ;
@property (nonatomic ,assign) NSNumber *Seperation ;
@property (nonatomic ,assign) NSNumber *WomenSwimming ;


@property (nonatomic ,assign) NSNumber *Bedrooms ;
@property (nonatomic ,assign) NSNumber *Livingrooms ;
@property (nonatomic ,assign) NSNumber *Bathrooms ;
@property (nonatomic ,assign) NSNumber *Kitchens ;
@property (nonatomic ,assign) NSNumber *Space ;

@end