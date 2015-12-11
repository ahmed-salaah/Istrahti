//
//  FacilityModel.m
//  Istrahti
//
//  Created by Ahmed Salah on 11/24/15.
//  Copyright © 2015 Ahmed Askar. All rights reserved.
//

#import "FacilityModel.h"

@implementation FacilityModel
-(id)initWithDic:(NSDictionary *)dic{
    self.imgUrl = [dic jsonObjectForKey:@"Icon"];
    self.type = [dic jsonObjectForKey:@"Name"];
    return self;
}
@end
