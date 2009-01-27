//
//  TPTextFieldOverlay.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPTextFieldOverlay.h"


@implementation TPTextFieldOverlay

@synthesize overlay;

- (void)setOverlay:(UIView *)anOverlay {
    if (overlay) {
        [overlay removeFromSuperview];        
    }

    [overlay autorelease];
    overlay = [anOverlay retain];
    if (overlay) {
        [self addSubview:overlay];    
    }
}

- (void)dealloc {
    [overlay release];
    [super dealloc];
}


@end
