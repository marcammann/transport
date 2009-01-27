//
//  TPSettings.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPSettings.h"


@implementation TPSettings
@synthesize locationAccuracy, minChangeDuration, maxWalkingDistance, noRunning, compressedTripView, bicycleTransportation, groupTransportation, suppressLongChanges, sortOrder;

- (id)initFromDefaults {
    if (self = [super init]) {
        [self loadFromDefaults];
    }
    
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self loadFromDefaults];
    }
    
    return self;
}

- (void)loadFromDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.locationAccuracy = [defaults objectForKey:@"locationAccuracy"];
    self.minChangeDuration = [defaults objectForKey:@"minChangeDuration"];
    self.maxWalkingDistance = [defaults objectForKey:@"maxWalkingDistance"];
    self.noRunning = [defaults boolForKey:@"noRunning"];
    self.compressedTripView = [defaults boolForKey:@"compressedTripView"];
    self.bicycleTransportation = [defaults boolForKey:@"bicycleTransportation"];
    self.groupTransportation = [defaults boolForKey:@"groupTransportation"];
    self.suppressLongChanges = [defaults boolForKey:@"suppressLongChanges"];
    self.sortOrder = [NSMutableArray arrayWithArray:[defaults objectForKey:@"sortOrder"]];
}

- (void)saveToDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.locationAccuracy forKey:@"locationAccuracy"];
    [defaults setObject:self.minChangeDuration forKey:@"minChangeDuration"];
    [defaults setObject:self.maxWalkingDistance forKey:@"maxWalkingDistance"];
    [defaults setBool:self.noRunning forKey:@"noRunning"];
    [defaults setBool:self.compressedTripView forKey:@"compressedTripView"];
    [defaults setBool:self.bicycleTransportation forKey:@"bicycleTransportation"];
    [defaults setBool:self.groupTransportation forKey:@"groupTransportation"];
    [defaults setBool:self.suppressLongChanges forKey:@"suppressLongChanges"];
    [defaults setObject:self.sortOrder forKey:@"sortOrder"];
}

- (void)dealloc {
    [sortOrder release];
    [maxWalkingDistance release];
    [locationAccuracy release];
    [minChangeDuration release];
    [super dealloc];
}

@end
