//
//  TPPlaces.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "TPScheduleInput.h"

@interface TPPlace : NSObject {
    NSString *dbPath;
}

- (NSArray *)places;
- (NSArray *)pois:(NSString *)where;
- (NSArray *)currentlocation;
- (NSArray *)stations:(NSString *)where;
- (BOOL)writePlace:(TPScheduleInput *)place;
- (BOOL)deletePlace:(NSInteger)id;
- (BOOL)checkExists:(TPScheduleInput *)place;

- (NSArray *)query:(const char *)sql;
- (NSArray *)queryStatement:(sqlite3_stmt *)select;

+ (TPScheduleInput *)placeFromStatement:(sqlite3_stmt *)stmt;

@end
