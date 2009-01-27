//
//  TPAutocompleteTableView.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPAutocompleteTableView.h"


@implementation TPAutocompleteTableView

@synthesize baseEntries, currentEntries, delegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items {
    if (self = [super initWithFrame:frame]) {
        CGRect tableViewFrame = CGRectMake(5.0f, 1.0f, self.frame.size.width - 10, self.frame.size.height - 1);
        tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 35.0f;
        
        self.backgroundColor = [UIColor clearColor];
        self.baseEntries = items;
        self.currentEntries = items;
        
        substring = [[NSString string] retain];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIImageView *backgroundLayer = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"autocompleteBackground.png"] stretchableImageWithLeftCapWidth:150.0f topCapHeight:40.0f]];
    backgroundLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundLayer.backgroundColor = [UIColor clearColor];
    
    UIImageView *overlayLayer = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"autocompleteOverlay.png"] stretchableImageWithLeftCapWidth:150.0f topCapHeight:40.0f]];
    overlayLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    overlayLayer.backgroundColor = [UIColor clearColor];

    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor lightGrayColor];
    
    [self addSubview:backgroundLayer];
    [self addSubview:overlayLayer];
    [self addSubview:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    TPScheduleInput *element = [currentEntries objectAtIndex:indexPath.row];
    
    if (element.list == TPScheduleInputListFavorite) {
        cell.image = [UIImage imageNamed:@"autocompleteFavorite.png"];
    } else if (element.type == TPScheduleInputTypeAddress) {
        cell.image = [UIImage imageNamed:@"autocompleteContact.png"];
    } else if (element.type == TPScheduleInputTypeStation) {
        cell.image = [UIImage imageNamed:@"autocompleteStation.png"];
    } else if (element.type == TPScheduleInputTypeCurrentLocation) {
        cell.image = [UIImage imageNamed:@"autocompleteFavorite.png"];
    }

    cell.font = [UIFont boldSystemFontOfSize:14.0];
    cell.text = element.stringRepresentation;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([currentEntries count] < 20) {
        return [currentEntries count];
    } else {
        return 20;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [delegate autocompleteTableView:self didSelectItem:[currentEntries objectAtIndex:indexPath.row]];
}

- (void)dealloc {
    [tableView release];
    [baseEntries release];
    [currentEntries release];
    [delegate release];
    [substring release];
    [super dealloc];
}

- (void)loadWithSubstring:(NSString *)newSubstring data:(NSArray *)items {
    if ([self.currentEntries count]) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];    
    }
    
    self.currentEntries = items;
    
    
    [substring autorelease];
    substring = [newSubstring retain];
    
    [tableView reloadData];
}

- (void)clear {
    self.currentEntries = [NSMutableArray arrayWithArray:baseEntries];
}

@end
