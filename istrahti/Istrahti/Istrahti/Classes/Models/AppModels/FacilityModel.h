//
//  FacilityModel.h
//  Istrahti
//
//  Created by Ahmed Salah on 11/24/15.
//  Copyright © 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+ReplacingNull.h"

@interface FacilityModel : NSObject
@property (nonatomic, strong)NSString* imgUrl;
@property (nonatomic, strong)NSString* type;
-(id)initWithDic:(NSDictionary *)dic;
@end
