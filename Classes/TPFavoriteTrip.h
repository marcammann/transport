//
//  TPFavoriteTrip.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPTrip.h"

@interface TPFavoriteTrip : TPTrip {
    NSString *name;
}

@property (nonatomic, retain) NSString *name;

@end
