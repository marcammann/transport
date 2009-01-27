//
//  AboutController.m
//  Transport
//
//  Created by Marc Ammann on 1/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPAboutController.h"


@implementation TPAboutController

- (id)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        data = [[NSArray arrayWithObjects:
                    [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"ZVV",@"name",@"http://www.zvv.ch",@"url",@"aboutzvv.png",@"image",nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"local.ch",@"name",@"http://www.local.ch",@"url",@"aboutlocal.png",@"image",nil],
                     nil],
                    [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Liip",@"name",@"http://www.liip.ch",@"url",@"aboutliip.png",@"image",nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"ZVV",@"name",@"http://www.zvv.ch",@"url",@"aboutzvv.png",@"image",nil],
                    nil],
                    [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"codesofa.com",@"name",@"http://www.codesofa.com",@"url",@"aboutcodesofa.png",@"image",nil],
                     nil],
                    [NSArray arrayWithObjects: 
                        [NSDictionary dictionaryWithObjectsAndKeys:@"codesofa.com",@"name",@"http://www.codesofa.com/code/Transport",@"url",@"aboutcodesofa.png",@"image",nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"sicher.com",@"name",@"http://www.sicher.com",@"url",@"aboutsicher.png",@"image",nil],
                     nil],
                    [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"GPL 2.0",@"name",@"http://www.gnu.org/licenses/gpl-2.0.html",@"url",@"aboutfoss.png",@"image",nil],
                     nil],
                nil] retain];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [data count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[data objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    

    cell.text = [[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.image = [UIImage imageNamed:[[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"image"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"Data Provider (official)", nil);
            break;
        case 1:
            return NSLocalizedString(@"Sponsors", nil);
            break;
        case 2:
            return NSLocalizedString(@"Code", nil);
            break;
        case 3:
            return NSLocalizedString(@"Design", nil);
            break;
        case 4:
            return NSLocalizedString(@"License", nil);
            break;
        default:
            return nil;
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"url"]]];
}


- (void)dealloc {
    [data release];
    [super dealloc];
}


@end