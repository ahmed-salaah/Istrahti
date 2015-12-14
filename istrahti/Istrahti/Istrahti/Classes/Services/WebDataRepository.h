//
//  WebDataRepository.h
//  GuideMe
//
//  Created by Ahmed Askar on 12/28/14.
//  Copyright (c) 2014 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParaData.h"

@interface WebDataRepository : NSObject

+ (WebDataRepository *)sharedInstance;

- (void)getFacilities:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock ;

- (void)searchForLounge:(SearchParaData *)search :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;

- (void)getCategories:(NSString *)section_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
@end