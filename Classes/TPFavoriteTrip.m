//
//  TPFavoriteTrip.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPFavoriteTrip.h"


@implementation TPFavoriteTrip

@synthesize name;

- (void)dealloc {
    [name release];
    [super dealloc];
}

@end
