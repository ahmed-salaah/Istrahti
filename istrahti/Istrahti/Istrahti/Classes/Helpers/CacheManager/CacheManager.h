//
//  CacheManager.h
//  Isuzu
//
//  Created by Askar on 4/1/12.
//  Copyright (c) 2012 __asgatech__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

@property (nonatomic, retain) NSString *documentPath;
@property (nonatomic, retain) NSFileManager *fileManager;

// Initialization
+ (CacheManager *)getObject;

// Save Data
- (void)saveData:(NSData *)data inPath:(NSString *)path;
- (void)saveDictionary:(NSDictionary *)dictionary inPath:(NSString *)path;
- (void)saveObject:(id)object withKey:(NSString *)key inPlistPath:(NSString *)path;

// Get Data
- (NSData *)getDataWithPath:(NSString *)path;
- (NSDictionary *)getDictionaryWithPath:(NSString *)path;
- (id)getObjectWithKey:(NSString *)key inPlistPath:(NSString *)path;

// Check Data
- (BOOL)checkFileWithPath:(NSString *)path;
- (BOOL)checkObjectWithKey:(NSString *)key inPlistPath:(NSString *)path;

// Copy Data
- (void)copyDataFromPath:(NSString *)oldPath toPath:(NSString *)newPath;

@end
