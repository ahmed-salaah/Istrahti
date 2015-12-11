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
//static NSString *const settingsUrl      =    @"http://be3aq8.com/api/settings";
//static NSString *const offers           =    @"http://be3aq8.com/api/offers/get/10?page=";
//static NSString *const sections         =    @"http://be3aq8.com/api/sections";
static NSString *const categories         =    @"GetIstrahaDetails?id=";
//static NSString *const registerUrl      =    @"http://be3aq8.com/api/users/register";
//static NSString *const activeCode       =    @"http://be3aq8.com/api/users/code/";
//static NSString *const deActiveCode     =    @"http://be3aq8.com/api/users/deactivate/";
//static NSString *const SoldAd           =    @"http://be3aq8.com/api/ads/set-sold/";
//
//
//static NSString *const ads              =    @"http://be3aq8.com/api/ads/get/";
//static NSString *const adView           =    @"http://be3aq8.com/api/ads/view/";
//static NSString *const addFav           =    @"http://be3aq8.com/api/ads/add-to-fav/";
//static NSString *const removeFav        =    @"http://be3aq8.com/api/ads/remove-from-fav/";
//static NSString *const AllFavAds        =    @"http://be3aq8.com/api/ads/list-fav?user=";
//static NSString *const AllMyAds         =    @"http://be3aq8.com/api/ads/my-ads?user=";
//static NSString *const adAbuse          =    @"http://be3aq8.com/api/ads/abuse/";
//static NSString *const notifications    =    @"http://be3aq8.com/api/users/notifications/";
//static NSString *const contactUs        =    @"http://be3aq8.com/api/contact";
//static NSString *const addNewAd         =    @"http://be3aq8.com/api/ads/add";
//static NSString *const EditAd           =    @"http://be3aq8.com/api/ads/edit";
//static NSString *const updateUser       =    @"http://be3aq8.com/api/users/update";
//static NSString *const searchAd         =    @"http://be3aq8.com/api/ads/get/";
//
//static NSString *const offerView        =    @"http://be3aq8.com/api/offers/view/";
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

//- (void)getAllData:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:settingsUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//- (void)getOffersByPage:(NSString *)pageNumber :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock;
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",offers,pageNumber];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}
//
//- (void)getSections:(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:sections parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}
//
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
//
//- (void)registerWithSuccess:(UserModel *)user :(void (^)(id user))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:user];
//    NSLog(@"%@", dict);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:registerUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)updateWithSuccess:(UserModel *)user :(void (^)(id user))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:user];
//    NSLog(@"%@", dict);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:updateUser parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)getAdsByPage:(NSString *)pageNumber AdModel:(AdDataModel *)adModel :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *postString = [NSString stringWithFormat:@"%@/%@/10?user=%@&page=%@",adModel.province_id,adModel.category_id,adModel.user_id,pageNumber];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",ads,postString];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}
//
//- (void)getAdView:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *postString = [NSString stringWithFormat:@"%@?user=%@",ad_id,user_id];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",adView,postString];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}
//
//
//- (void)addFavoriteAdWithID:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *postString = [NSString stringWithFormat:@"%@?user=%@",ad_id,user_id];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",addFav,postString];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//- (void)removeFavoriteAdWithID:(NSString *)ad_id user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *postString = [NSString stringWithFormat:@"%@?user=%@",ad_id,user_id];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",removeFav,postString];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//
//- (void)getFavoriteAds:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",AllFavAds,user_id];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//- (void)getMyAds:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",AllMyAds,user_id];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//- (void)AbuseAd:(NSString *)ad_id user:(NSString *)user_id message:(NSString *)message :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@",adAbuse,ad_id];
//    
//    NSDictionary *parameters = @{@"user":user_id, @"message":message};
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)getNotifications:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",notifications,user_id];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//    }];
//}
//
//- (void)contactUs:(ContactUsDataModel *)model :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:model];
//    
//    [manager POST:contactUs parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         successBlock(responseObject);
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         failureBlock(error.localizedDescription);
//     }];
//}
//
//- (void)ActiveUser:(NSString *)code user:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@/%@",activeCode,user_id,code];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)DeActiveUser:(NSString *)user_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@",deActiveCode,user_id];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//
//- (void)addNewAdd:(AddNewAdModel *)model images:(NSArray *)images :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:model];
//  
//        [manager POST:addNewAd parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    
//            int i = 0;
//            for(UIImage *eachImage in images)
//            {
//                NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
//                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"photos[%d]",i+1 ] fileName:[NSString stringWithFormat:@"file%d.jpg",i+1] mimeType:@"image/jpeg"];
//                i++;
//            }
//
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            successBlock(responseObject);
//    
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failureBlock(error.localizedDescription);
//        }];
//}
//
//- (void)editAdd:(AddNewAdModel *)model images:(NSArray *)images :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:model];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",EditAd,model.id];
//    
//    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         successBlock(responseObject);
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         failureBlock(error.localizedDescription);
//     }];
//
//}
//
//- (void)SetSoldAd:(NSString *)ad_id :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@",SoldAd,ad_id];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)searchAd:(NSString *)postString :(void (^)(id result))successBlock andFailure:(void (^)(NSString * message))failureBlock
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@",searchAd,postString];
//    NSString* encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:
//                            NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:encodedUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//    }];
//}
//
//- (void)getOfferView:(NSString *)offer_id :(void (^)(id))successBlock andFailure:(void (^)(NSString *))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",offerView,offer_id];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}
//
//- (void)getBannerView:(NSString *)banner_id :(void (^)(id))successBlock andFailure:(void (^)(NSString *))failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",bannerView,banner_id];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error.localizedDescription);
//        NSLog(@"Error: %@", error);
//        
//    }];
//}


@end
