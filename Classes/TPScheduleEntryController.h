//
//  TPScheduleEntryController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPScheduleMaskController.h"
#import "TPQuickLookupController.h"

#import "TPScheduleInput.h"

#import "TPSettings.h"
#import "TPSettingsController.h"

@interface TPScheduleEntryController : UIViewController <TPSettingsControllerDelegate> {
    TPScheduleMaskController *inputMaskController;
    TPQuickLookupController *quickLookupController;
    
    TPSettingsController *settingsController;  
    TPSettings *settings;
    
    UIToolbar *toolbar;
}

- (id)initWithFrom:(TPScheduleInput *)from to:(TPScheduleInput *)to date:(NSDate *)travelDate isDeparture:(BOOL)travelDateDeparture;
- (void)loadWithSubstring:(NSString *)substring;

@end
