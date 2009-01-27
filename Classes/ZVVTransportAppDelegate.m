//
//  ZVVTransportAppDelegate.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ZVVTransportAppDelegate.h"


@implementation ZVVTransportAppDelegate

@synthesize window, tabBarController, settingsController, scheduleController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [self createDefaults];
    [self createDatabase];
    UITabBarController *aTabBarController = [[UITabBarController alloc] init];
    

    
    // Schedules Mask Controller
    scheduleController = [[[TPScheduleEntryController alloc] init] autorelease];
    UINavigationController *scheduleNavController = [[UINavigationController alloc] initWithRootViewController:scheduleController];
    scheduleNavController.navigationBar.barStyle = UIBarStyleDefault;
    scheduleNavController.title = NSLocalizedString(@"Schedule", nil);
    scheduleNavController.tabBarItem.image = [UIImage imageNamed:@"mainMenuSchedule.png"];
 
    [window addSubview:scheduleNavController.view];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [settings saveToDefaults];
    [self saveApplicationState];
}

- (void)createDatabase {
    BOOL success;
    NSError *err;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"tp.db"];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if (success)
        return;
	
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tp.db"];
    success = [fileManager copyItemAtPath:dbPath toPath:databasePath error:&err];
    if (!success)
        NSAssert1(0, @"Could not copy DB file. Error: %@.", [err localizedDescription]);
}

- (void)createDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:0], @"lastSelectedTab",
                                 @"",@"lastOriginalSource",
                                 @"",@"lastOriginalDestination",
                                 [NSNumber numberWithInt:-1], @"lastTripID",
                                 [NSNumber numberWithInt:-1], @"lastJourneyID",
                                 [NSNumber numberWithInt:-1], @"lastLinkID",
                                 [NSNumber numberWithInt:-1], @"lastPartID",
                                 [NSNumber numberWithFloat:200.0], @"locationAccuracy",
                                 [NSNumber numberWithInt:0], @"minChangeDuration",
                                 [NSNumber numberWithFloat:500.0], @"maxWalkingDistance",
                                 [NSMutableArray arrayWithObjects:@"Quickest Arrival", @"Shortest Duration", @"Quickest Departure", @"Closest Station", nil], @"sortOrder",
                                 NO, @"noRunning",
                                 NO, @"compressedTripView",
                                 NO, @"bicycleTransportation",
                                 NO, @"groupTransportation",
                                 NO, @"suppressLongChanges",
                                 nil];
    
    [defaults registerDefaults:appDefaults];
    
}



- (void)saveApplicationState {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    return;
}

- (BOOL)loadApplicationState {
    return NO;
}

- (void)dealloc {
    [window release];
    [tabBarController release];
    [settings release];
    [super dealloc];
}


@end