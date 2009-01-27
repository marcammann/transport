//
//  TPTrip.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPScheduleInput.h"

@interface TPTrip : NSObject {
    NSNumber  *tripID;
    
    TPScheduleInput *from;
    TPScheduleInput *to;
    
    NSDate *travelDate;
    BOOL travelDateDeparture;
    
    BOOL userEditDate;
    
    NSArray *journeys;
}

@property (nonatomic, retain) NSNumber *tripID;
@property (nonatomic, retain) TPScheduleInput *from;
@property (nonatomic, retain) TPScheduleInput *to;
@property (nonatomic, retain) NSDate *travelDate;
@property (readwrite) BOOL travelDateDeparture;
@property (readwrite) BOOL userEditDate;

@property (nonatomic, retain) NSArray *journeys;

@end
