//
//  SortOrderController.h
//  Transport
//
//  Created by Marc Ammann on 1/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSettings.h"

@interface TPSortOrderController : UITableViewController {
    TPSettings *settings;
    NSMutableArray *sortOrder;
}

@property (nonatomic, retain) TPSettings *settings;

- (id)initWithSettings:(TPSettings *)settings;

@end
