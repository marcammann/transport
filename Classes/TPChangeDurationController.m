//
//  ChangeDurationController.m
//  Transport
//
//  Created by Marc Ammann on 1/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPChangeDurationController.h"


@implementation TPChangeDurationController

@synthesize settings;

- (id)initWithSettings:(TPSettings *)aSettings {
    if (self = [super init]) {
        options = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:15], [NSNumber numberWithInt:20], [NSNumber numberWithInt:30], nil];
        
        self.settings = aSettings;
        self.title = NSLocalizedString(@"Min. Change Duration", @"Title for minimal change duration selector");
        
        valueTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        valueTableView.delegate = self;
        valueTableView.dataSource = self;
        valueTableView.backgroundColor = [UIColor clearColor];
        valueTableView.scrollEnabled = NO;
        valueTableView.frame = CGRectMake(0, 40.0, 320.0, 150.0);
        
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 151, 0, 0)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.showsSelectionIndicator = YES;
    }
    
    
    return self;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([[options objectAtIndex:row] integerValue] == 0) {
        return NSLocalizedString(@"Don't care", "User doesn't care about that selection");
    }
    return [NSString stringWithFormat:@"%@ Min", [options objectAtIndex:row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([settings.minChangeDuration integerValue] == 0) {
        cell.text =  NSLocalizedString(@"Don't care", "User doesn't care about that selection");
    } else {
        cell.text = [NSString stringWithFormat:@"%@ Min", settings.minChangeDuration];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return NSLocalizedString(@"How long do you need to transfer between links?", @"");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [options count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    settings.minChangeDuration = [options objectAtIndex:row];
    [settings setMinChangeDuration:settings.minChangeDuration];
    [settings saveToDefaults];
    [valueTableView reloadData];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    [self.view addSubview:valueTableView];
    [self.view addSubview:pickerView];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [valueTableView release];
    [pickerView release];
    [options release];
    [settings release];
    [super dealloc];
}


@end
