//
//  TPScheduleEntryController.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPScheduleEntryController.h"


@implementation TPScheduleEntryController

- (id)init {
    if (self = [super init]) {
        inputMaskController = [[TPScheduleMaskController alloc] initWithViewController:self];
        quickLookupController = [[TPQuickLookupController alloc] init];
        
        toolbar = [[UIToolbar alloc] init];
        [toolbar sizeToFit];
        toolbar.frame = CGRectMake(toolbar.frame.origin.x, self.view.bounds.size.height - 2*toolbar.frame.size.height, toolbar.frame.size.width, toolbar.frame.size.height);
        UIBarButtonItem *recentBt = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbarRecent.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showRecentsModal)] autorelease];
        recentBt.width = 40.0f;
        UIBarButtonItem *favoriteBt = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbarFavorite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showFavoritesModal)] autorelease];
        favoriteBt.width = 40.0f;
        UIBarButtonItem *stationBt = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbarStation.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingsModal)] autorelease];
        stationBt.width = 40.0f;
        UIBarButtonItem *settingsBt = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbarSettings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingsModal)] autorelease];
        settingsBt.width = 40.0f;
        UIBarButtonItem *addBt = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbarAdd.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showAddActionSheet)] autorelease];
        addBt.width = 96.0f;
        [toolbar setItems:[NSArray arrayWithObjects:recentBt, favoriteBt,  addBt, stationBt, settingsBt, nil]];
        
    }
    
    return self;
}

- (void)showSettingsModal {
    settings = [[TPSettings alloc] initFromDefaults];
    settingsController = [[[TPSettingsController alloc] initWithSettings:settings] autorelease];
    settingsController.delegate = self;
    UINavigationController *settingsNavController = [[UINavigationController alloc] initWithRootViewController:settingsController];
    
    [self.navigationController presentModalViewController:settingsNavController animated:YES];
}

- (void)settingsControllerIsDone:(id)controller {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)showFavoritesModal {
    favoritesController = [[[TPFavoriteTableController alloc] initWithDelegate:self] autorelease];
    UINavigationController *favoritesNavController = [[UINavigationController alloc] initWithRootViewController:favoritesController];

    
    [self.navigationController presentModalViewController:favoritesNavController animated:YES];
}

- (void)favoritesControllerDidCancel:(id)controller {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    //[controller release];
}

- (void)favoritesController:(id)controller didSelectTrip:(TPFavoriteTrip *)trip {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [inputMaskController setCurrentTrip:trip];
    //[controller release];
}

- (void)showRecentsModal {
    recentsController = [[[TPRecentTableController alloc] initWithDelegate:self] autorelease];
    UINavigationController *recentsNavController = [[UINavigationController alloc]  initWithRootViewController:recentsController];
    [self.navigationController presentModalViewController:recentsNavController animated:YES];
}

- (void)recentsControllerDidCancel:(id)controller {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)recentsController:(id)controller didSelectTrip:(TPRecentTrip *)trip {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [inputMaskController setCurrentTrip:trip];
}

- (void)showAddActionSheet {
    UIActionSheet *addActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                delegate:self 
                       cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                  destructiveButtonTitle:nil
                       otherButtonTitles:NSLocalizedString(@"Name your Location", nil), NSLocalizedString(@"Add to Favorites", nil), nil];
    addActionSheet.tag = 1;
    [addActionSheet showInView:self.view];
    [addActionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UIAlertView *enterName = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter a Name", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Save", nil), nil];
            [enterName addTextFieldWithValue:@"" label:@"Home, Work etc."];
            enterName.tag = 1;
            [enterName show];
            [enterName release];
        } else {
            
            // TODO: Check and Write to Favorites
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        // TODO: Add to POIs
    }
}


- (id)initWithFrom:(TPScheduleInput *)from to:(TPScheduleInput *)to date:(NSDate *)travelDate isDeparture:(BOOL)travelDateDeparture {
    if (self = [super init]) {
        inputMaskController = [[TPScheduleMaskController alloc] initWithFrom:from to:to date:travelDate isDeparture:travelDateDeparture];
        quickLookupController = [[TPQuickLookupController alloc] init];
        toolbar = [[UIToolbar alloc] init];
        [toolbar sizeToFit];
    }
    
    return self;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.title = NSLocalizedString(@"Schedule", nil);
    [super loadView];
    [self.view addSubview:quickLookupController.view];
    [self.view addSubview:inputMaskController.view];
    [self.view addSubview:toolbar];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [quickLookupController viewWillAppear:animated];
    [inputMaskController viewWillAppear:animated];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [quickLookupController release];
    [inputMaskController release];
    [toolbar release];
    [settings release];
    [settingsController release];
    [super dealloc];
}


@end
