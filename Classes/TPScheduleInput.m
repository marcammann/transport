//
//  TPScheduleInput.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPScheduleInput.h"



@implementation TPScheduleInput

@synthesize stringRepresentation, location, stations;
@synthesize forced, validated, type, list, requestCount, iid;

- (void)dealloc {
    [stringRepresentation release];
    [location release];
    [stations release];
    [super dealloc];
}

@end
