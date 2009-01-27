//
//  SettingsTableViewController.m
//  gottaRun
//
//  Created by Marc Ammann on 5/29/08.
//  Licensed under the GPL Version 2.0. See LICENSE and NOTICE
//

#import "TPSettingsController.h"

#define kSwitchButtonWidth 100
#define kSwitchButtonHeight 20
#define kRowHeight 50

@implementation TPSettingsController

@synthesize settings, delegate;

- (id)initWithSettings:(TPSettings *)aSettings {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.settings = aSettings;
		self.title = NSLocalizedString(@"Settings",nil);
 
        settingsData = [[NSArray alloc] initWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Max. Walking Distance", @"title", @"Maximum distance you are willing to walk", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Location Accuracy", @"title", @"Accuracy of the location service", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Sort Order", @"title", @"Order in which the trips should be sorted", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Min. Change Duration", @"title", @"Minimal duration of changes between trains", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Compressed Trips", @"title", @"Compress the trips list to a minium per default", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"No Long Changes", @"title", @"Suppress journeys with long changes", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Group Transport", @"title", @"Only display journeys with group capabilities", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Bicycle Transport", @"title", @"Only display journyes with bike capabilities", @"desc", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"No Running", @"title", @"Disable trips which require running", @"desc", nil],
                        nil];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(returnToParent)];
	}
	return self;
}

- (void)returnToParent {
    if (delegate) {
        [delegate settingsControllerIsDone];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [settings saveToDefaults];
    [super viewWillDisappear:animated];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2)) {
        return 1.5 * kRowHeight;
    } else {
        return kRowHeight;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 9;
    } else {
        return 2;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"Preferences", nil);
    } else {
        return NSLocalizedString(@"Extras", nil);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"Select your defaults for your journeys", nil);
    } else {
        return NSLocalizedString(@"", nil);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            // Sort Order
            TPSortOrderController *aController = [[TPSortOrderController alloc] initWithSettings:settings];
            [self.navigationController pushViewController:aController animated:YES];
        } else if (indexPath.row == 3) {
            // Change Duration
            TPChangeDurationController *aController = [[TPChangeDurationController alloc] initWithSettings:settings];
            [self.navigationController pushViewController:aController animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // About
            TPAboutController *aController = [[TPAboutController alloc] init];
            [self.navigationController pushViewController:aController animated:YES];
        } else if (indexPath.row == 1) {
            // Contact
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:rant@codesofa.com?subject=Transport"]];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
    NSString *identifier;   
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ||
            indexPath.row == 1) {
           
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];

            UISlider *aSlider = [[UISlider alloc] initWithFrame:CGRectMake(20.0, 45.0, 280.0, 20.0)];
            switch (indexPath.row) {
                case 0:
                    aSlider.minimumValue = 50.0;
                    aSlider.maximumValue = 2000.0;
                    aSlider.value = [[settings maxWalkingDistance] floatValue];
                    
                    [aSlider addTarget:self action:@selector(changeMaxWalkingDistance:) forControlEvents:UIControlEventValueChanged];
                    [cell addSubview:aSlider];
                    maxWalkingDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 80, 20)];
                    maxWalkingDistanceLabel.text = [NSString stringWithFormat:@"%.1fm",aSlider.value];
                    maxWalkingDistanceLabel.font = [UIFont systemFontOfSize:16];
                    maxWalkingDistanceLabel.textColor = [UIColor grayColor];
                    maxWalkingDistanceLabel.textAlignment = UITextAlignmentRight;                
                    [cell addSubview:maxWalkingDistanceLabel];
                    break;
                case 1:
                    aSlider.minimumValue = 50.0;
                    aSlider.maximumValue = 2000.0;
                    aSlider.value = [[settings locationAccuracy] floatValue];
                    
                    [aSlider addTarget:self action:@selector(changeLocationAccuracy:) forControlEvents:UIControlEventValueChanged];
                    [cell addSubview:aSlider];
                    
                    locationAccuracyLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 80, 20)];
                    locationAccuracyLabel.text = [NSString stringWithFormat:@"%.1fm",aSlider.value];
                    locationAccuracyLabel.font = [UIFont systemFontOfSize:16];
                    locationAccuracyLabel.textColor = [UIColor grayColor];
                    locationAccuracyLabel.textAlignment = UITextAlignmentRight;                
                    [cell addSubview:locationAccuracyLabel];                
                    break;
                default:
                    break;
            }
                
            
            [cell setClearsContextBeforeDrawing:YES];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 200.0, 20.0)];
            title.font = [UIFont boldSystemFontOfSize:16];
            title.text = NSLocalizedString([[settingsData objectAtIndex:indexPath.row] objectForKey:@"title"],nil);
            [cell addSubview:title];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } else if (indexPath.row == 2) {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
            
            UILabel *aLabel;
            switch (indexPath.row) {
                case 2:
                    aLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 35.0, 250.0, 30.0)];
                    aLabel.lineBreakMode = UILineBreakModeWordWrap;
                    aLabel.numberOfLines = 2;
                    
                    aLabel.text = [[settings sortOrder] componentsJoinedByString:@", "];
                    aLabel.font = [UIFont systemFontOfSize:12];
                    aLabel.textColor = [UIColor grayColor];
                    [cell addSubview:aLabel];
                    break;
            }
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 200.0, 20.0)];
            title.font = [UIFont boldSystemFontOfSize:16];
            title.text = NSLocalizedString([[settingsData objectAtIndex:indexPath.row] objectForKey:@"title"],nil);
            [cell addSubview:title];
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else if (indexPath.row == 3) {
            
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
            
            UILabel *aLabel;
            switch (indexPath.row) {
                case 3:
                    aLabel = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 15.0, 50.0, 20.0)];
                    aLabel.text = [NSString stringWithFormat:@"%@ Min", [settings minChangeDuration]];
                    aLabel.font = [UIFont systemFontOfSize:16];
                    aLabel.textColor = [UIColor grayColor];
                    aLabel.textAlignment = UITextAlignmentRight; 
                    [cell addSubview:aLabel];                
                    break;
            }
        
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.text =  NSLocalizedString([[settingsData objectAtIndex:indexPath.row] objectForKey:@"title"],nil);
            
        } else {
            identifier = @"SmallSwitch";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
                
                UISwitch *aSwitcher = [[UISwitch alloc] initWithFrame:CGRectZero];                
                switch (indexPath.row) {
                    case 4:
                        [aSwitcher addTarget:self action:@selector(changeCompressedTripView:) forControlEvents:UIControlEventValueChanged];
                        aSwitcher.on = [settings compressedTripView];
                        cell.accessoryView = aSwitcher;
                        break;
                    case 5:
                        [aSwitcher addTarget:self action:@selector(changeSuppressLongChanges:) forControlEvents:UIControlEventValueChanged];
                        aSwitcher.on = [settings suppressLongChanges];
                        cell.accessoryView = aSwitcher;
                        break;
                    case 6:
                        [aSwitcher addTarget:self action:@selector(changeGroupTransportation:) forControlEvents:UIControlEventValueChanged];
                        aSwitcher.on = [settings groupTransportation];
                        cell.accessoryView = aSwitcher;
                        break;
                    case 7:
                        [aSwitcher addTarget:self action:@selector(changeBicycleTransportation:) forControlEvents:UIControlEventValueChanged];
                        aSwitcher.on = [settings bicycleTransportation];
                        cell.accessoryView = aSwitcher;
                        break;
                    case 8:
                        [aSwitcher addTarget:self action:@selector(changeNoRunning:) forControlEvents:UIControlEventValueChanged];
                        aSwitcher.on = [settings noRunning];
                        cell.accessoryView = aSwitcher;
                        break;
                    default:
                        break;
                }
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.text =  NSLocalizedString([[settingsData objectAtIndex:indexPath.row] objectForKey:@"title"],nil);
        }
    } else {
        identifier = @"SmallActionNoText";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            // About
            cell.text = NSLocalizedString(@"About",nil);
        } else {
            // Contact
            cell.text = NSLocalizedString(@"Send E-Mail",nil);
        }
    }
	
	return cell;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)changeLocationAccuracy:(id)sender {
    [settings setLocationAccuracy:[NSNumber numberWithFloat:[(UISlider *)sender value]]];
    locationAccuracyLabel.text = [NSString stringWithFormat:@"%.1fm", [[settings locationAccuracy] floatValue]];
}

- (void)changeMaxWalkingDistance:(id)sender {
    [settings setMaxWalkingDistance:[NSNumber numberWithFloat:[(UISlider *)sender value]]];
    maxWalkingDistanceLabel.text = [NSString stringWithFormat:@"%.1fm", [[settings maxWalkingDistance] floatValue]];
}

- (void)changeCompressedTripView:(id)sender {
    [settings setCompressedTripView:[(UISwitch *)sender isOn]];
}

- (void)changeSuppressLongChanges:(id)sender {
    [settings setSuppressLongChanges:[(UISwitch *)sender isOn]];
}

- (void)changeGroupTransportation:(id)sender {
    [settings setGroupTransportation:[(UISwitch *)sender isOn]];
}

- (void)changeBicycleTransportation:(id)sender {
    [settings setBicycleTransportation:[(UISwitch *)sender isOn]];
}

- (void)changeNoRunning:(id)sender {
    [settings setNoRunning:[(UISwitch *)sender isOn]];
}

- (void)dealloc {
    [maxWalkingDistanceLabel release];
    [locationAccuracyLabel release];
    [settingsData release];
    [settings release];
    [super dealloc];
}

@end

