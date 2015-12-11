//
//  CacheManager.m
//  Isuzu
//
//  Created by Askar on 4/1/12.
//  Copyright (c) 2012 __asgatech__. All rights reserved.
//

#import "CacheManager.h"

CacheManager *cacheManagerObject = nil;

@implementation CacheManager

@synthesize documentPath, fileManager;

#pragma mark - Initialization

- (id)init{
	self = [super init];
	if (self) {
		self.documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
		self.fileManager = [NSFileManager defaultManager];
	}
	return self;
}

+ (CacheManager *)getObject{
	if (cacheManagerObject == nil) {
		cacheManagerObject = [[CacheManager alloc] init];
	}
	
	return cacheManagerObject;
}


#pragma mark - Save Data

- (void)saveData:(NSData *)data inPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	if ([path rangeOfString:@"/"].location != NSNotFound) {
		[fileManager createDirectoryAtPath:[path stringByDeletingLastPathComponent]  withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	[data writeToFile:path atomically:YES];
}

- (void)saveDictionary:(NSDictionary *)dictionary inPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	if ([path rangeOfString:@"/"].location != NSNotFound) {
		[fileManager createDirectoryAtPath:[path stringByDeletingLastPathComponent]  withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	[dictionary writeToFile:path atomically:YES];
}

- (void)saveObject:(id)object withKey:(NSString *)key inPlistPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	
	NSMutableDictionary *plist = nil;
	if ([fileManager fileExistsAtPath:path]) {
		plist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	} else {
		if ([path rangeOfString:@"/"].location != NSNotFound) {
			[fileManager createDirectoryAtPath:[path stringByDeletingLastPathComponent]  withIntermediateDirectories:YES attributes:nil error:nil];
		}
		plist = [NSMutableDictionary dictionary];
	}
	
	[plist setObject:object forKey:key];
	[plist writeToFile:path atomically:YES];
}

#pragma mark - Get Data

- (NSData *)getDataWithPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	return [NSData dataWithContentsOfFile:path];
}

- (NSDictionary *)getDictionaryWithPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (id)getObjectWithKey:(NSString *)key inPlistPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	
	id object = nil;
	if ([fileManager fileExistsAtPath:path]) {
		NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
		object = [plist objectForKey:key];
	}
	
	return object;
}

#pragma mark - Check Data

- (BOOL)checkFileWithPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	
	BOOL fileExists = NO;
	if ([fileManager fileExistsAtPath:path]) {
		fileExists = YES;
	}
	
	return fileExists;
}

- (BOOL)checkObjectWithKey:(NSString *)key inPlistPath:(NSString *)path{
	path = [documentPath stringByAppendingPathComponent:path];
	
	BOOL objectExists = NO;
	if ([fileManager fileExistsAtPath:path]) {
		NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
		if ([plist objectForKey:key] != nil) {
			objectExists = YES;
		}
	}
	
	return objectExists;
}

#pragma mark - Copy Data

- (void)copyDataFromPath:(NSString *)oldPath toPath:(NSString *)newPath{
	[fileManager copyItemAtPath:oldPath toPath:newPath error:nil];
}

@end
