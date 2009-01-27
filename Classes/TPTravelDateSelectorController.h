//
//  TPTravelDateSelectorController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTrip.h";

@interface TPTravelDateSelectorController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    TPTrip *currentTrip;
    UIDatePicker *datePicker;
    UISegmentedControl *timeModeControl;
    
    UITableView *valueTableView;
}

- (id)initWithTrip:(TPTrip *)aTrip;

@end
