//
//  WebDataRepository.m
//  GuideMe
//
//  Created by Ahmed Askar on 12/28/14.
//  Copyright (c) 2014 Ahmed Askar. All rights reserved.
//

#import "WebDataRepository.h"
#import <objc/runtime.h>
#import "NSDictionary+ObjectConvert.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppManager.h"
#import "Istrahati.pch"

@class CompayResult ;

@interface WebDataRepository()

@end

@implementation WebDataRepository

static NSString *const baseURL            =    @"http://istrahti.com/Services/IstrahtiAppServices.svc/";
static NSString *const sections           =    @"GetFacilitiesList";
static NSString *const categories         =    @"GetIstrahaDetails?id=";
static NSString *const searchResult       =    @"GetSearchResults";

+ (WebDataRepository *)sharedInstance
{
    static WebDataRepository *_sharedInstance = nil ;
    
    static dispatch_once_t oncePredict ;
    
    dispatch_once(&oncePredict, ^{
        _sharedInstance = [[WebDataRepository alloc] init];
    });
    
    return _sharedInstance ;
}

- (void)searchForLounge:(SearchParaData *)search :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
{
    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:search];
    NSLog(@"%@", dict);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,searchResult];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failureBlock(error.localizedDescription);
    
    }];
}

- (void)getFacilities:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,sections];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
        NSLog(@"Error: %@", error);
        
    }];
}

- (void)getCategories:(NSString *)section_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",baseURL,categories,section_id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

@end
