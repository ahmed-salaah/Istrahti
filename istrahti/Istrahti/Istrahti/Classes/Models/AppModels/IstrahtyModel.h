//
//  IstrahtyModel.h
//  Istrahti
//
//  Created by Ahmed Salah on 11/24/15.
//  Copyright © 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacilityModel.h"
@interface IstrahtyModel : NSObject
@property(nonatomic, strong)NSMutableArray *facilities;
@property(nonatomic, strong)NSMutableArray *imagesArray;
@property(nonatomic, strong)NSString *available;
@property(nonatomic, strong)NSString *bathrooms;
@property(nonatomic, strong)NSString *bedrooms;
@property(nonatomic, strong)NSString *city;
@property(nonatomic, strong)NSString *istrahtyAddress;
@property(nonatomic, strong)NSString *contactEmail;
@property(nonatomic, strong)NSString *contactName;
@property(nonatomic, strong)NSString *contactNo;
@property(nonatomic, strong)NSString *country;
@property(nonatomic, strong)NSString *defaultImage;
@property(nonatomic, strong)NSString *deleted;
@property(nonatomic, strong)NSString *istrahaDescription;
@property(nonatomic, strong)NSString *istrahaName;
@property(nonatomic, strong)NSString *price;
@property(nonatomic, assign)BOOL events;
@property(nonatomic, assign)BOOL family;
@property(nonatomic, assign)BOOL kidsPlay;
@property(nonatomic, assign)BOOL singles;
@property(nonatomic, assign)BOOL womenSwimming;
@property(nonatomic, assign)BOOL swimmingPool;
@property(nonatomic, assign)BOOL seperation;
@property(nonatomic, strong)NSString *rating;
-(id)initWithDic:(NSDictionary *)dic;
@end
