//
//  IstrahtyModel.m
//  Istrahti
//
//  Created by Ahmed Salah on 11/24/15.
//  Copyright © 2015 Ahmed Askar. All rights reserved.
//

#import "IstrahtyModel.h"
#import "NSDictionary+ReplacingNull.h"

@implementation IstrahtyModel

- (id)initWithDic:(NSDictionary *)dic
{
    self.facilities = [NSMutableArray new];
    self.imagesArray = [NSMutableArray new];
    NSArray *facilitiesArr = [dic jsonObjectForKey:@"Facilities"];
    for (NSDictionary *facilityDic in facilitiesArr) {
        FacilityModel *model = [[FacilityModel alloc]initWithDictionary:facilityDic];
        [self.facilities addObject:model];
    }
    NSArray *images = [dic jsonObjectForKey:@"Images"];
    for (NSDictionary *imageDic in images) {
        [self.imagesArray addObject:[imageDic jsonObjectForKey:@"ImageUrl"]];
    }
    NSDictionary *istrahaDic = [dic jsonObjectForKey:@"Istraha"];
    self.istrahtyAddress = [istrahaDic jsonObjectForKey:@"Address"];
    self.bathrooms = [istrahaDic jsonObjectForKey:@"Bathrooms"];
    self.bedrooms = [istrahaDic jsonObjectForKey:@"Bedrooms"];
    self.city = [istrahaDic jsonObjectForKey:@"City"];
    self.contactEmail = [istrahaDic jsonObjectForKey:@"ContactEmail"];
        self.contactNo = [istrahaDic jsonObjectForKey:@"ContactNo"];
    self.country = [istrahaDic jsonObjectForKey:@"Country"];
    self.istrahaDescription = [istrahaDic jsonObjectForKey:@"Description"];
    self.events = [istrahaDic jsonObjectForKey:@"Events"];
    self.family = [istrahaDic jsonObjectForKey:@"Family"];
    self.seperation = [istrahaDic jsonObjectForKey:@"Seperation"];
    self.singles = [istrahaDic jsonObjectForKey:@"Singles"];
    self.swimmingPool = [istrahaDic jsonObjectForKey:@"SwimmingPool"];
    self.womenSwimming = [istrahaDic jsonObjectForKey:@"WomenSwimming"];
    self.istrahaName = [istrahaDic jsonObjectForKey:@"IstrahaName"];
    self.kidsPlay = [istrahaDic jsonObjectForKey:@"KidsPlay"];
    self.price = [istrahaDic jsonObjectForKey:@"Price"];
    self.rating = [istrahaDic jsonObjectForKey:@"Rating"];
    self.price = [istrahaDic jsonObjectForKey:@"Price"];

    return self;
}
@end
