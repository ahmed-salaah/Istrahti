//
//  LocationModel.h
//  GuideMe
//
//  Created by Ahmed Askar on 1/1/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBJSONModel.h"

@interface LocationModel : NSObject

@property (nonatomic,assign) double latitude ;
@property (nonatomic,assign) double longitude ;
@property (nonatomic,copy) NSString * title ;
@property (nonatomic,copy) NSString * desc ;

+ (NSDictionary *)JSONKeyTranslationDictionary ;

@end
