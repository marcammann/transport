//
//  TPFavorite.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPFavorite.h"


@implementation TPFavorite

sqlite3 *database;

- (id)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        dbPath = [[documentsDirectory stringByAppendingPathComponent:@"tp.db"] retain];
    }
    
    return self;
}

- (NSArray *)favorites {
    NSString *sql = [NSString stringWithFormat:@"SELECT f.favorite_name, f.favorite_id, fr.place_id as from_id, fr.place_name as from_name, fr.place_coordinate_lat as from_coord_lat, fr.place_coordinate_lon as from_coord_lon, fr.place_count as from_count, fr.place_type as from_type, tf.place_id as to_id, tf.place_name as to_name, tf.place_coordinate_lat as to_coord_lat,  tf.place_coordinate_lon as to_coord_lon, tf.place_count as to_count, tf.place_type as to_type FROM gg_favorite f LEFT JOIN gg_place fr ON (fr.place_id = f.from_id) LEFT JOIN gg_place tf ON (tf.place_id = f.to_id) ORDER BY favorite_name ASC"];
    const char *sSql = [sql UTF8String];
    return [self queryToTrip:sSql];
}

- (NSArray *)favoriteStations:(NSString *)where {
    NSString *sql = [NSString stringWithFormat:@"SELECT p.* FROM gg_place p INNER JOIN gg_favorite f ON (f.from_id = p.place_id OR f.to_id = p.place_id) WHERE LOWER(place_name) GLOB '*%@*' LIMIT 50", [where lowercaseString]];
    
    const char *sSql = [sql UTF8String];
    return [self queryToPlace:sSql];
}

- (NSArray *)queryStatementToPlace:(sqlite3_stmt *)select {
    NSMutableArray *result = [NSMutableArray array];
    while(sqlite3_step(select) == SQLITE_ROW) {
        [result addObject:[TPFavorite placeFromStatement:select offset:0]];
    }
    
    NSArray *ret = [NSArray arrayWithArray:result];
    return ret;
}

- (NSArray *)queryToPlace:(const char *)sql {    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *select;
        int ret = sqlite3_prepare_v2(database, sql, -1, &select, NULL);
        if (ret == SQLITE_OK) {
            return [self queryStatementToPlace:select];
        }
    }
    
    return nil;
}

- (NSArray *)queryStatementToTrip:(sqlite3_stmt *)select {
    NSMutableArray *result = [NSMutableArray array];
    while(sqlite3_step(select) == SQLITE_ROW) {
        [result addObject:[TPFavorite tripFromStatement:select]];
    }
    
    NSArray *ret = [NSArray arrayWithArray:result];
    return ret;
}

- (NSArray *)queryToTrip:(const char *)sql {    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *select;
        int ret = sqlite3_prepare_v2(database, sql, -1, &select, NULL);
        if (ret == SQLITE_OK) {
            return [self queryStatementToTrip:select];
        }
    }
    
    return nil;
}

+ (TPScheduleInput *)placeFromStatement:(sqlite3_stmt *)stmt offset:(NSInteger)offset {
    TPScheduleInput *place = [[[TPScheduleInput alloc] init] autorelease];
    place.inputID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0 + offset)];
    const char *name = (char *)sqlite3_column_text(stmt, 1 + offset);
    if (name != NULL) {
        place.stringRepresentation = [NSString stringWithUTF8String:name];
    } else {
        place.stringRepresentation = @"";
    }
    
    place.location = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)sqlite3_column_double(stmt, 2 + offset) longitude:(CLLocationDegrees)sqlite3_column_double(stmt, 3 + offset)];
    place.requestCount = [NSNumber numberWithInt:sqlite3_column_int(stmt, 4 + offset)];
    
    NSString *type;
    const char *ctype = (char *)sqlite3_column_text(stmt, 5 + offset);
    if (ctype != NULL) {
        type = [NSString stringWithUTF8String:ctype];
    } else {
        type = @"";
    }
    
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
    
    place.list = TPScheduleInputListFavorite;
    
    return place;
}

+ (TPFavoriteTrip *)tripFromStatement:(sqlite3_stmt *)stmt {
    TPFavoriteTrip *trip = [[[TPFavoriteTrip alloc] init] autorelease];
    
    const char *cname = sqlite3_column_text(stmt, 0);
    if (cname != NULL) {
        trip.name = [NSString stringWithUTF8String:cname];
    }
    
    trip.tripID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 1)];
    
    TPScheduleInput *from = [TPFavorite placeFromStatement:stmt offset:2];
    TPScheduleInput *to = [TPFavorite placeFromStatement:stmt offset:8];
    
    trip.from = from;
    trip.to = to;
    
    return trip;
}

- (void)dealloc {
    [dbPath release];
    sqlite3_free(database);
    [super dealloc];
}

@end
