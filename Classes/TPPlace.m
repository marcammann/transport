//
//  TPPlaces.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPPlace.h"

@implementation TPPlace

sqlite3 *database;

- (id)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        dbPath = [[documentsDirectory stringByAppendingPathComponent:@"tp.db"] retain];
    }
    
    return self;
}

- (NSArray *)stations:(NSString *)where {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM gg_place WHERE place_type = 'station' AND LOWER(place_name) GLOB '*%@*'", where];
    
    const char *sSql = [sql UTF8String];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *select;
        int ret = sqlite3_prepare_v2(database, sSql, -1, &select, NULL);
        if (ret == SQLITE_OK) {
            return [self queryStatement:select];
        }
    }
    
    return nil;
}

- (NSArray *)currentlocation {
    const char *sql = "SELECT * FROM gg_place WHERE place_type = 'currentlocation'";
    return [self query:sql];
}

- (NSArray *)pois:(NSString *)where {
    const char *sql = "SELECT * FROM gg_place WHERE place_type = 'poi'";
    return [self query:sql];
}

- (NSArray *)places {
    const char *sql = "SELECT * FROM gg_place";
    return [self query:sql];
}

- (NSArray *)queryStatement:(sqlite3_stmt *)select {
    NSMutableArray *result = [NSMutableArray array];
    
    while(sqlite3_step(select) == SQLITE_ROW) {
        [result addObject:[TPPlace placeFromStatement:select]];
    }
    
    NSArray *ret = [NSArray arrayWithArray:result];
    
    return ret;
}

- (NSArray *)query:(const char *)sql {    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *select;
        int ret = sqlite3_prepare_v2(database, sql, -1, &select, NULL);
        if (ret == SQLITE_OK) {
            return [self queryStatement:select];
        }
    }
}

- (BOOL)writePlace:(TPScheduleInput *)place {
    
}

- (BOOL)deletePlace:(NSInteger)id {
    
}

- (BOOL)checkExists:(TPScheduleInput *)place {
    
}

+ (TPScheduleInput *)placeFromStatement:(sqlite3_stmt *)stmt {
    TPScheduleInput *place = [[[TPScheduleInput alloc] init] autorelease];
    place.iid = sqlite3_column_int(stmt, 0);
    place.stringRepresentation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
    place.location = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)sqlite3_column_double(stmt, 2) longitude:(CLLocationDegrees)sqlite3_column_double(stmt, 3)];
    place.requestCount = sqlite3_column_int(stmt, 4);
    NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
    
    if ([type isEqualToString:@"currentlocation"]) {
        place.type = TPScheduleInputTypeCurrentLocation;
        place.forced = YES;
    } else if ([type isEqualToString:@"poi"]) {
        place.type = TPScheduleInputTypePOI;
        place.forced = YES;
    } else if ([type isEqualToString:@"address"]) {
        place.type = TPScheduleInputTypeAddress;
        place.forced = YES;
    } else if ([type isEqualToString:@"station"]) {
        place.type = TPScheduleInputTypeStation;
        place.validated = YES;
    }
    
    place.list = TPScheduleInputListPlace;
    
    return place;
}

- (void)dealloc {
    [dbPath release];
    sqlite3_free(database);
    [super dealloc];
}

@end
