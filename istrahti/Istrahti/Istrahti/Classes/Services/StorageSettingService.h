//
//  StorageSettingService.h
//  GuideMe
//
//  Created by Ahmed Askar on 1/2/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageSettingService : NSObject

+ (StorageSettingService *)sharedInstance ;
- (void)saveObject:(id)object forKey:(NSString *)key ;
- (void)getObject:(id)object forKey:(NSString *)key ;
- (void)deleteObject:(NSString *)key;
- (void)saveValue:(id)value forKey:(NSString *)key;
- (void)getValue:(id)value forKey:(NSString *)key;
- (void)deleteValue:(NSString *)key;
- (void)userRegister:(BOOL)flag forKey:(NSString *)key ;
- (BOOL)isRegister:(NSString *)key ;
@end
