//
//  NSDictionary+ReplacingNull.m
//  Qiyas
//
//  Created by Ahmed Salah on 4/26/15.
//  Copyright (c) 2015 ITWorx. All rights reserved.
//

#import "NSDictionary+ReplacingNull.h"

@implementation NSDictionary (ReplacingNull)
- (id)jsonObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    
    return object;
}
@end
