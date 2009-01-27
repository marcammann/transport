//
//  TPRecent.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TPRecentTrip.h"
#import "TPScheduleInput.h"
#import "TPFavorite.h"

@interface TPRecent : NSObject {
    NSString *dbPath;
}

- (NSArray *)recents;

- (NSArray *)queryToTrip:(const char *)sql;
- (NSArray *)queryStatementToTrip:(sqlite3_stmt *)select;

+ (TPFavoriteTrip *)tripFromStatement:(sqlite3_stmt *)stmt;

@end
