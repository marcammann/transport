//
//  SettingsTableViewController.h
//  gottaRun
//
//  Created by Marc Ammann on 5/29/08.
//  Licensed under the GPL Version 2.0. See LICENSE and NOTICE
//

#import <UIKit/UIKit.h>

#import "TPSortOrderController.h"
#import "TPAboutController.h"
#import "TPChangeDurationController.h"

#import "TPSettings.h"

@protocol TPSettingsControllerDelegate 
- (void)settingsControllerIsDone;
@end


@interface TPSettingsController : UITableViewController {
    NSArray *settingsData;
    UILabel *maxWalkingDistanceLabel;
    UILabel *locationAccuracyLabel;
    
    TPSettings *settings;
    
    id<TPSettingsControllerDelegate> delegate;
}

@property (retain) TPSettings *settings;
@property (nonatomic, retain) id delegate;


- (id)initWithSettings:(TPSettings *)settings;

- (void)changeLocationAccuracy:(id)sender;
- (void)changeMaxWalkingDistance:(id)sender;
- (void)changeCompressedTripView:(id)sender;
- (void)changeSuppressLongChanges:(id)sender;
- (void)changeGroupTransportation:(id)sender;
- (void)changeBicycleTransportation:(id)sender;
- (void)changeNoRunning:(id)sender;
@end