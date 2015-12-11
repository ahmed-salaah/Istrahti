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

//- (void)getAllData:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getOffersByPage:(NSString *)pageNumber :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getSections:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
- (void)getCategories:(NSString *)section_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
- (void)searchForLounge:(SearchParaData *)search :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)updateWithSuccess:(UserModel *)user :(void (^)(id user))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getAdsByPage:(NSString *)pageNumber AdModel:(AdDataModel *)adModel :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getAdView:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getOfferView:(NSString *)offer_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getBannerView:(NSString *)banner_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)addFavoriteAdWithID:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)removeFavoriteAdWithID:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getFavoriteAds:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)AbuseAd:(NSString *)ad_id user:(NSString *)user_id message:(NSString *)message :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getMyAds:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)getNotifications:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)contactUs:(ContactUsDataModel *)model :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)ActiveUser:(NSString *)code user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock ;
//
//- (void)DeActiveUser:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock ;
//
//- (void)addNewAdd:(AddNewAdModel *)model images:(NSArray *)images :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock ;
//
//- (void)editAdd:(AddNewAdModel *)model images:(NSArray *)images :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock ;
//
//- (void)SetSoldAd:(NSString *)ad_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//
//- (void)searchAd:(NSString *)postString :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;

@end