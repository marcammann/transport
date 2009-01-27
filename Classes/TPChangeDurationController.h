//
//  ChangeDurationController.h
//  Transport
//
//  Created by Marc Ammann on 1/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSettings.h"

@interface TPChangeDurationController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    TPSettings *settings;
    
    UITableView *valueTableView;
    UIPickerView *pickerView;
    
    NSArray *options;
}

@property (nonatomic, retain) TPSettings *settings;

- (id)initWithSettings:(TPSettings *)settings;

@end
