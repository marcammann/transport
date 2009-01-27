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

#import "TPFavoriteTrip.h"
#import "TPFavoriteTableController.h"

#import "TPRecentTrip.h"
#import "TPRecentTableController.h"

@interface TPScheduleEntryController : UIViewController <TPSettingsControllerDelegate, TPFavoriteTableControllerDelegate, TPRecentTableControllerDelegate> {
    TPScheduleMaskController *inputMaskController;
    TPQuickLookupController *quickLookupController;
    
    TPSettingsController *settingsController;  
    TPSettings *settings;
    
    TPFavoriteTableController *favoritesController;
    
    TPRecentTableController *recentsController;
    
    UIToolbar *toolbar;
}

- (id)initWithFrom:(TPScheduleInput *)from to:(TPScheduleInput *)to date:(NSDate *)travelDate isDeparture:(BOOL)travelDateDeparture;
- (void)loadWithSubstring:(NSString *)substring;

@end
