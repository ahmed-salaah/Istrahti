//
//  NSDictionary+ObjectConvert.m
//  GuideMe
//
//  Created by Ahmed Askar on 1/1/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "NSDictionary+ObjectConvert.h"
#import <objc/runtime.h>

@implementation NSDictionary (ObjectConvert)

+ (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if([obj valueForKey:key] == nil){
            [dict setObject:[NSNull null] forKey:key];
        }else{
            [dict setObject:[obj valueForKey:key] forKey:key];

        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
