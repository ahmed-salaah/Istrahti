//
//  StorageSettingService.m
//  GuideMe
//
//  Created by Ahmed Askar on 1/2/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "StorageSettingService.h"

@implementation StorageSettingService

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self ;
}

+ (StorageSettingService *)sharedInstance
{
    static StorageSettingService *_sharedInstance = nil ;
    
    static dispatch_once_t oncePredict ;
    
    dispatch_once(&oncePredict, ^{
        _sharedInstance = [[StorageSettingService alloc] init];
    });
    
    return _sharedInstance ;
}

- (void)saveObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getObject:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)saveValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

- (void)deleteObject:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

- (void)deleteValue:(NSString *)key
{
    
    
}

- (void)userRegister:(BOOL)flag forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:flag forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (BOOL)isRegister:(NSString *)key
{
   return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
