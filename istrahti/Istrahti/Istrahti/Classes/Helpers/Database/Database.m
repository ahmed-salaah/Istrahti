//
//  Database.m
//  ICU
//
//  Created by Askar on 6/10/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import "Database.h"
#import "CacheManager.h"

Database *databaseObject = nil;

@implementation Database

@synthesize databasePath;

#pragma mark - Initialization

+ (Database *)getObject{
	if (databaseObject == nil) {
		databaseObject = [[Database alloc] init];
	}
	
	return databaseObject;
}

#pragma mark - Configure

- (void)setDatabaseName:(NSString *)name andType:(NSString *)type{
	self.databasePath = [[[CacheManager getObject].documentPath stringByAppendingPathComponent:name] stringByAppendingPathExtension:type];

	if (![[CacheManager getObject] checkFileWithPath:[name stringByAppendingPathExtension:type]]) {
		[[CacheManager getObject] copyDataFromPath:[[NSBundle mainBundle] pathForResource:name ofType:type] toPath:databasePath];
	}
}

#pragma mark - Query

- (NSMutableDictionary *)databaseSelectQuery:(NSString *)query
{
    sqlite3 *database;

    BOOL dataSuccess = NO;

    NSMutableDictionary *rowDictionary ;

    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {

        const char *cQuery = [query UTF8String];

        sqlite3_stmt *statement;


        if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) == SQLITE_OK) {

            int count = sqlite3_column_count(statement);

            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                rowDictionary = [NSMutableDictionary dictionary];

                for (int i = 0; i < count ; i++) {

                    [rowDictionary setObject:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, i)] forKey:[NSString stringWithUTF8String:sqlite3_column_name(statement, i)]];
                }
            }

            dataSuccess = YES;

            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }

    return rowDictionary ;
}

- (void)databaseSelectQuery:(NSString *)query
               withDelegate:(id<DatabaseDelegate>)delegate
             AndRowDelegate:(id<DatabaseRowDelegate>)rowDelegate
{
    sqlite3 *database;
    BOOL dataSuccess = NO;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        const char *cQuery = [query UTF8String];

        sqlite3_stmt *statement;

        if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) == SQLITE_OK) {

            int count = sqlite3_column_count(statement);

            NSMutableArray *result = [[NSMutableArray alloc] init];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSMutableDictionary *rowDictionary = [NSMutableDictionary dictionary];
                
                for (int i = 0; i < count ; i++) {

                    [rowDictionary setObject:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, i)] forKey:[NSString stringWithUTF8String:sqlite3_column_name(statement, i)]];
                }

                if (delegate == nil) {
                    
                }else{
                    rowDictionary = [rowDelegate databaseRowSelect:rowDictionary];
                }

                [result addObject:rowDictionary];
            }

            [delegate databaseSelectResult:[[NSArray arrayWithArray:result] mutableCopy]];
            dataSuccess = YES;

            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    if (!dataSuccess) {
        [delegate databaseSelectResult:nil];
    }
}
    


- (void)databaseInsertQuery:(NSString *)query
{
    sqlite3 *database;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *cQuery = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) == SQLITE_OK) {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            else
                sqlite3_reset(statement);
        }
        sqlite3_finalize(statement);
        statement = nil;
    }
    sqlite3_close(database);
}

- (void)databasePerformQuery:(NSString *)query
{
    sqlite3 *database;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *cQuery = [query UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) == SQLITE_OK) {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            else
                sqlite3_reset(statement);
        }
        sqlite3_finalize(statement);
        statement = nil;
    }
    sqlite3_close(database);
}


- (void)databaseDeleteQuery:(NSString *)query
{
    sqlite3 *database;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        const char *cQuery = [query UTF8String];
        sqlite3_stmt *statement;

        if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) == SQLITE_OK) {

            if(SQLITE_DONE != sqlite3_step(statement))
                NSAssert1(0, @"Error while deleting data. '%s'", sqlite3_errmsg(database));
            else
                sqlite3_reset(statement);

            sqlite3_finalize(statement);
            statement = nil;
        }

        sqlite3_close(database);
    }
}


@end
