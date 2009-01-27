//
//  TPScheduleInput.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    TPScheduleInputTypeStation,
    TPScheduleInputTypePOI,
    TPScheduleInputTypeAddress,
    TPScheduleInputTypeCurrentLocation
} TPScheduleInputType;

typedef enum {
    TPScheduleInputListFavorite,
    TPScheduleInputListRecent,
    TPScheduleInputListPlace
} TPScheduleInputList;


@interface TPScheduleInput : NSObject {
    NSString *stringRepresentation;
    CLLocation *location;
    
    BOOL forced;
    BOOL validated;
    
    TPScheduleInputType type;
    TPScheduleInputList list;
    
    NSArray *stations;
    
    NSInteger iid;
    NSInteger requestCount;
}

@property (retain) NSString *stringRepresentation;
@property (nonatomic, retain) CLLocation *location;
@property (readwrite) BOOL forced, validated;
@property (nonatomic) TPScheduleInputType type;
@property (nonatomic) TPScheduleInputList list;
@property (nonatomic, retain) NSArray *stations;
@property (readwrite) NSInteger requestCount, iid;

@end
