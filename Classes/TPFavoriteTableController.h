//
//  TPFavoriteTableController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFavoriteTrip.h"
#import "TPFavorite.h"

#import "TPFavoriteCell.h"

@protocol TPFavoriteTableControllerDelegate 
- (void)favoritesControllerDidCancel:(id)controller;
- (void)favoritesController:(id)controller didSelectTrip:(TPFavoriteTrip *)trip;
@end

@interface TPFavoriteTableController : UITableViewController {
    id delegate;
    NSArray *favorites;
}

@property (nonatomic, retain) id delegate;

@end
