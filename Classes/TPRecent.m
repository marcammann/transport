//
//  TPRecent.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPRecent.h"


@implementation TPRecent

sqlite3 *database;

- (id)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        dbPath = [[documentsDirectory stringByAppendingPathComponent:@"tp.db"] retain];
    }
    
    return self;
}

- (NSArray *)recents {
    NSString *sql = [NSString stringWithFormat:@"SELECT r.recent_id, r.recent_traveldatetime, r.recent_travelmode, r.recent_journeydata, fr.place_id as from_id, fr.place_name as from_name, fr.place_coordinate_lat as from_coord_lat, fr.place_coordinate_lon as from_coord_lon, fr.place_count as from_count, fr.place_type as from_type, tf.place_id as to_id, tf.place_name as to_name, tf.place_coordinate_lat as to_coord_lat,  tf.place_coordinate_lon as to_coord_lon, tf.place_count as to_count, tf.place_type as to_type FROM gg_recent r LEFT JOIN gg_place fr ON (fr.place_id = r.from_id) LEFT JOIN gg_place tf ON (tf.place_id = r.to_id) ORDER BY DATE(r.recent_traveldatetime) DESC"];
    const char *sSql = [sql UTF8String];
    return [self queryToTrip:sSql];
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

- (NSArray *)queryStatementToTrip:(sqlite3_stmt *)select {
    NSMutableArray *result = [NSMutableArray array];
    while(sqlite3_step(select) == SQLITE_ROW) {
        [result addObject:[TPRecent tripFromStatement:select]];
    }
    
    NSArray *ret = [NSArray arrayWithArray:result];
    return ret;
}

+ (TPFavoriteTrip *)tripFromStatement:(sqlite3_stmt *)stmt {
    TPRecentTrip *trip = [[[TPRecentTrip alloc] init] autorelease];
    
    trip.tripID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
    
    const char *cdate = (char *)sqlite3_column_text(stmt, 1);
    if (cdate != NULL) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        trip.travelDate = [dateFormatter dateFromString:[NSString stringWithUTF8String:cdate]];
    } else {
        trip.travelDate = [NSDate date];
    }
    trip.userEditDate = YES;
    
    NSInteger travelMode = sqlite3_column_int(stmt, 2);
    if (travelMode == 0) {
        trip.travelDateDeparture = NO;
    } else {
        trip.travelDateDeparture = YES;
    }
    
    // TODO: get journey data
    
    TPScheduleInput *from = [TPFavorite placeFromStatement:stmt offset:4];
    TPScheduleInput *to = [TPFavorite placeFromStatement:stmt offset:10];
    
    trip.from = from;
    trip.to = to;
    
    return trip;
}

@end