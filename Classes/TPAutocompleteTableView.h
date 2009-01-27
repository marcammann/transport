//
//  TPAutocompleteTableView.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPScheduleInput.h"


@protocol TPAutocompleteTableViewDelegate
- (void)autocompleteTableView:(id)aTableView didSelectItem:(id)item;
@end

@interface TPAutocompleteTableView : UIView <UITableViewDelegate, UITableViewDataSource> {
    id<TPAutocompleteTableViewDelegate> delegate;
    
    UITableView *tableView;
    
    NSArray *baseEntries;
    NSArray *currentEntries;
    
    NSString *substring;
}

@property (nonatomic, retain) NSArray *baseEntries;
@property (nonatomic, retain) NSArray *currentEntries;
@property (nonatomic, retain) id delegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)loadWithSubstring:(NSString *)newSubstring data:(NSArray *)items;

@end