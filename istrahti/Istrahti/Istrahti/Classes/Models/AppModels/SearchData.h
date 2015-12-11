//
//  SearchData.h
//  Istrahti
//
//  Created by Ahmed Askar on 8/28/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBJSONModel.h"

@interface SearchData : MBJSONModel

@property (nonatomic ,strong) NSString *Address;
@property (nonatomic ,assign) int Bathrooms;
@property (nonatomic ,assign) int Bedrooms;
@property (nonatomic ,strong) NSString *City;
@property (nonatomic ,strong) NSString *ContactEmail;
@property (nonatomic ,strong) NSString *ContactName;
@property (nonatomic ,strong) NSString *ContactNo;
@property (nonatomic ,strong) NSString *Country;
@property (nonatomic ,strong) NSString *DefaultImage;
@property (nonatomic ,strong) NSString *Description;
@property (nonatomic ,assign) BOOL Events;
@property (nonatomic ,assign) BOOL Family;
@property (nonatomic ,assign) BOOL HalfDay;
@property (nonatomic ,assign) int IstrahaID;
@property (nonatomic ,strong) NSString *IstrahaName;
@property (nonatomic ,assign) BOOL KidsPlay;
@property (nonatomic ,assign) int Kitchens;
@property (nonatomic ,assign) int LivingRooms;
@property (nonatomic ,strong) NSString *ModifiedDate;
@property (nonatomic ,assign) int NoramlWeekendPrice;
@property (nonatomic ,assign) int NormalHalfPrice;
@property (nonatomic ,assign) int NormalWeekendHalfPr;
@property (nonatomic ,assign) int Price;
@property (nonatomic ,assign) BOOL Published;
@property (nonatomic ,assign) BOOL Singles;
@property (nonatomic ,assign) int Space;
@property (nonatomic ,assign) int SpecialDaysPrice;
@property (nonatomic ,assign) int SummerFullPrice;
@property (nonatomic ,assign) int SummerHalfPrice;
@property (nonatomic ,strong) NSString *Type;
@property (nonatomic ,assign) BOOL SwimmingPool;
@property (nonatomic ,assign) int UserID;

@property (nonatomic ,assign) BOOL Available;
@property (nonatomic ,assign) BOOL Deleted;
@property (nonatomic ,assign) BOOL Seperation;

@property (nonatomic ,assign) BOOL SpecialDaysHalfPr;
@property (nonatomic ,assign) BOOL SummerWeekendHalfPr;
@property (nonatomic ,assign) BOOL SummerWeekendPrice;
@property (nonatomic ,assign) BOOL WomenSwimming;

@property (nonatomic ,strong) NSString *Key;
@property (nonatomic ,assign) int Rating;
@property (nonatomic ,assign) int Reviews;

@end
