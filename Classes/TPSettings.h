//
//  TPSettings.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TPSettings : NSObject {
    // Preferences
    NSNumber *maxWalkingDistance;
    NSNumber *locationAccuracy;
    NSNumber *minChangeDuration;
    BOOL suppressLongChanges;
    BOOL groupTransportation;
    BOOL bicycleTransportation;
    BOOL compressedTripView;
    BOOL noRunning;
    NSMutableArray *sortOrder;
}

// Preferences
@property (nonatomic, retain) NSNumber *maxWalkingDistance;
@property (nonatomic, retain) NSNumber *locationAccuracy;
@property (nonatomic, retain) NSNumber *minChangeDuration;
@property (readwrite) BOOL suppressLongChanges;
@property (readwrite) BOOL groupTransportation;
@property (readwrite) BOOL bicycleTransportation;
@property (readwrite) BOOL compressedTripView;
@property (readwrite) BOOL noRunning;
@property (nonatomic, retain) NSMutableArray *sortOrder;

- (id)initFromDefaults;
- (void)saveToDefaults;
- (void)loadFromDefaults;
@end
