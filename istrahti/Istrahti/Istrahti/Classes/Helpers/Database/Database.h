//
//  Database.h
//  ICU
//
//  Created by Askar on 6/10/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

// DatabaseDelegate
@protocol DatabaseDelegate <NSObject>

- (void)databaseSelectResult:(NSMutableArray *)databaseData ;

@end

// DatabaseRowDelegate
@protocol DatabaseRowDelegate <NSObject>

- (id)databaseRowSelect:(NSMutableDictionary *)row ;

@end

@interface Database : NSObject

@property (nonatomic , weak) id <DatabaseDelegate> dataBaseDelegate ;
@property (nonatomic , weak) id <DatabaseRowDelegate> dataRowDelegate ;

@property (nonatomic, retain) NSString *databasePath;

// Initialization
+ (Database *)getObject;

// Configure
- (void)setDatabaseName:(NSString *)name andType:(NSString *)type;

// Query
- (void)databaseSelectQuery:(NSString *)query
               withDelegate:(id<DatabaseDelegate>)delegate
             AndRowDelegate:(id<DatabaseRowDelegate>)rowDelegate ;

- (void)databaseInsertQuery:(NSString *)query ;

- (void)databaseDeleteQuery:(NSString *)query ;

- (void)databasePerformQuery:(NSString *)query ;

- (NSDictionary *)databaseSelectQuery:(NSString *)query ;

@end
