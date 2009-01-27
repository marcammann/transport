//
//  TPFavorite.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TPTrip.h"
#import "TPScheduleInput.h"

@interface TPFavorite : NSObject {
    NSString *dbPath;
}

- (NSArray *)favorites;
- (NSArray *)favoriteStations:(NSString *)where;

- (NSArray *)queryToPlace:(const char *)sql;
- (NSArray *)queryStatementToPlace:(sqlite3_stmt *)select;

- (NSArray *)queryToTrip:(const char *)sql;
- (NSArray *)queryStatementToTrip:(sqlite3_stmt *)select;


+ (TPScheduleInput *)placeFromStatement:(sqlite3_stmt *)stmt;
+ (TPTrip *)tripFromStatement:(sqlite3_stmt *)stmt;

@end
