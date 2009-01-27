//
//  TPRecentTableController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPRecentTrip.h"
#import "TPRecent.h"

#import "TPRecentCell.h"

@protocol TPRecentTableControllerDelegate
- (void)recentsControllerDidCancel:(id)controller;
- (void)recentsController:(id)controller didSelectTrip:(TPRecentTrip *)trip;
@end

@interface TPRecentTableController : UITableViewController {
    id delegate;
    NSArray *recents;
}

@property (nonatomic, retain) id delegate;

@end
