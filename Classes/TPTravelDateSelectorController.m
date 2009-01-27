//
//  TPTravelDateSelectorController.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPTravelDateSelectorController.h"


@implementation TPTravelDateSelectorController

- (id)initWithTrip:(TPTrip *)aTrip {
    if (self = [super init]) {
        currentTrip = [aTrip retain];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 0, 0)];
        [datePicker addTarget:self action:@selector(setTravelDate) forControlEvents:UIControlEventValueChanged];
        datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        datePicker.hidden = NO;
        [datePicker setDate:currentTrip.travelDate];
        
        timeModeControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Departure", nil), NSLocalizedString(@"Arrival",nil), nil]];
        [timeModeControl addTarget:self action:@selector(setTravelMode) forControlEvents:UIControlEventValueChanged];
        timeModeControl.frame = CGRectMake(10, 110.0f, 300, 40);
        if (currentTrip.travelDateDeparture) {
            timeModeControl.selectedSegmentIndex = 0;
        } else {
            timeModeControl.selectedSegmentIndex = 1;
        }
        
        valueTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        valueTableView.delegate = self;
        valueTableView.dataSource = self;
        valueTableView.backgroundColor = [UIColor clearColor];
        valueTableView.scrollEnabled = NO;
        valueTableView.frame = CGRectMake(0.0f, 35.0f, 320.0f, 150.0f);
    }
    
    return self;
}


- (void)loadView {
    [super loadView];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 210.0f)];
    bgView.image = [UIImage imageNamed:@"maskBg.png"];
    [self.view addSubview:bgView]; 
    
    [self.view addSubview:valueTableView];
    [self.view addSubview:timeModeControl];
    [self.view addSubview:datePicker];
}

- (void)setTravelDate {
    currentTrip.travelDate = datePicker.date;
    [valueTableView reloadData];
}

- (void)setTravelMode {
    if (timeModeControl.selectedSegmentIndex == 0) {
        currentTrip.travelDateDeparture = YES;
    } else {
        currentTrip.travelDateDeparture = NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)newTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@""] autorelease];
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    [cell setTextAlignment:UITextAlignmentRight];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    dateLabel.text = [dateFormatter stringFromDate:currentTrip.travelDate];
    dateLabel.font = [UIFont boldSystemFontOfSize:14.0];
    dateLabel.textAlignment = UITextAlignmentCenter;
    dateLabel.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:dateLabel];
    
	
	[dateFormatter release];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [currentTrip release];
    [datePicker release];
    [timeModeControl release];
    [valueTableView release];
    [super dealloc];
}


@end
