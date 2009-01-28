//
//  ZVVTransportAppDelegate.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPScheduleEntryController.h"
#import "TPSettingsController.h"
#import "TPSettings.h"
#import "TPMean.h"

#define kScreenWidth 320.0f
#define kScreenHeight 480.0f

@interface ZVVTransportAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    
    TPSettingsController *settingsController;
    TPScheduleEntryController *scheduleController;
    
    TPSettings *settings;
    
    BOOL userDidChangDate;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@property (nonatomic, retain) TPSettingsController *settingsController;
@property (nonatomic, retain) TPScheduleEntryController *scheduleController;

- (void)createDefaults;
- (void)createDatabase;

- (void)saveApplicationState;
- (BOOL)loadApplicationState;
@end

