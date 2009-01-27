//
//  TPTrip.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPTrip.h"


@implementation TPTrip

@synthesize tripID, from, to, travelDate, travelDateDeparture, userEditDate, journeys;

- (id)init {
    if (self = [super init]) {
        self.tripID = [NSNumber numberWithInt:-1];
        self.from = [[TPScheduleInput alloc] init];
        self.to = [[TPScheduleInput alloc] init];
        self.travelDate = [NSDate date];
        self.travelDateDeparture = YES;
        self.userEditDate = NO;
        
        self.journeys = [NSArray array];
    }
    
    return self;
}

- (void)setTravelDate:(NSDate *)aDate {
    [travelDate autorelease];
    travelDate = [aDate retain];
    userEditDate = YES;
}

- (void)dealloc {
    [tripID release];
    [from release];
    [to release];
    [travelDate release];
    [journeys release];
    [super dealloc];
}

@end
