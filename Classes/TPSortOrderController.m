//
//  SortOrderController.m
//  Transport
//
//  Created by Marc Ammann on 1/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPSortOrderController.h"


@implementation TPSortOrderController

@synthesize settings;



- (id)initWithSettings:(TPSettings *)aSettings {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.settings = aSettings;
        sortOrder = settings.sortOrder;
        self.title = NSLocalizedString(@"Sort Order", @"the order in which to sort trips");
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    [self.tableView setEditing:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sortOrder count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.text = [sortOrder objectAtIndex:indexPath.row];
    
    // Set up the cell...

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return NSLocalizedString(@"In what precedence do you want to list your trips? Highest has top precedence.", @"");
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *element = [sortOrder objectAtIndex:fromIndexPath.row];
    [sortOrder removeObjectAtIndex:fromIndexPath.row];
    [sortOrder insertObject:element atIndex:toIndexPath.row];
    [settings saveToDefaults];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)dealloc {
    [sortOrder release];
    [settings release];
    [super dealloc];
}


@end

