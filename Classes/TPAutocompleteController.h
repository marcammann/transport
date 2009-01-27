//
//  TPAutocompleteController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAutocompleteTableView.h"
#import "TPScheduleInput.h"
#import <QuartzCore/QuartzCore.h>
#import "NBInvocationQueue.h"

#import "TPPlace.h"
#import "TPFavorite.h"
#import "TPRecent.h"

@interface TPAutocompleteController : UIViewController {
    TPAutocompleteTableView *tableView;
    NSArray *data;
    NSMutableArray *currentAdditionalData;
    NSMutableArray *currentStationData;
    
    NSArray *additionalData;
    NSArray *stationData;
    
    id delegate;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSArray *data, *stationData, *additionalData;
@property (nonatomic, retain) NSMutableArray *currentStationData, *currentAdditionalData;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)loadWithSubstring:(NSString *)substring;

- (NSArray *)postProcessData:(NSArray *)newData;
@end
