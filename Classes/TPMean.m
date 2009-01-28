//
//  TPMean.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPMean.h"


@implementation TPMean

@synthesize name, enabled;

- (id)initWithName:(NSString *)aName enabled:(BOOL)isEnabled {
    if (self = [super init]) {
        self.name = aName;
        self.enabled = isEnabled;
    }
    
    return self;
}

- (void)dealloc {
    [name release];
    [super dealloc];
}

@end
