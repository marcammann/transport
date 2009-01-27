//
//  TPScheduleMaskController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAutocompleteController.h"
#import "TPTravelDateSelectorController.h"

#import "TPTrip.h"
#import "TPScheduleInput.h"

#import "TPTextFieldOverlay.h"

@interface TPScheduleMaskController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, TPAutocompleteTableViewDelegate> {
    TPTrip *currentTrip;
    TPAutocompleteController *autocompleteController;
    
    UITableView *maskTable;
    
    TPTextFieldOverlay *fromTextField;
    TPTextFieldOverlay *toTextField;
    
    UIViewController *parentController;
}

- (id)initWithViewController:(UIViewController *)aController;
- (UIButton *)createSmallButtonWithTitle:(NSString *)title xoffset:(CGFloat)xoffset yoffset:(CGFloat)yoffset;
- (UIImageView *)createHighlightWithText:(NSString *)text;
- (TPTextFieldOverlay *)setupFieldWithTitle:(NSString *)title;
- (void)setupField:(TPTextFieldOverlay *)field withInput:(TPScheduleInput *)input;
@end
