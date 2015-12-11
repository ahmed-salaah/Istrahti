//
//  SearchResult.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/28/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

+ (NSDictionary *)JSONKeyTranslationDictionary
{
    return @{
             
             @"Message" : @"Message",
             @"Error"   : @"Error",
             @"Data" : @{@"class" : NSStringFromClass([SearchData class]), @"relationship" : @"Data", @"isArray" : @YES}
             };
}

@end
