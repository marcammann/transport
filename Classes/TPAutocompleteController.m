//
//  TPAutocompleteController.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPAutocompleteController.h"

#define kTableWidth 300.0f
#define kTableHeight 160.0f
#define kTableLeftOffset 10.0f
#define kTableTopOffsetVisible 84.0f
#define kTableTopOffsetInvisible 480.0f

@implementation TPAutocompleteController

@synthesize delegate, data, stationData, additionalData, currentStationData, currentAdditionalData;

NSString *substring, *lastSubstring;
NSDate *date;
NBInvocationQueue *eventQueueStation;
NBInvocationQueue *eventQueueAdditonal;
NSLock *dblock, *lock;

- (id)init {
    if (self = [super init]) {
        substring = [[NSString string] retain];
        lastSubstring = [[NSString string] retain];
        tableView = [[TPAutocompleteTableView alloc] initWithFrame:CGRectMake(kTableLeftOffset, kTableTopOffsetInvisible, kTableWidth, kTableHeight) items:nil];
        tableView.hidden = YES;

        date = [[NSDate date] retain];
        
        eventQueueStation = [[NBInvocationQueue alloc] init];
        eventQueueAdditonal = [[NBInvocationQueue alloc] init];
        [NSThread detachNewThreadSelector:@selector(runQueueThread) toTarget:eventQueueStation withObject:nil];
        [NSThread detachNewThreadSelector:@selector(runQueueThread) toTarget:eventQueueAdditonal withObject:nil];
        [self loadWithSubstring:@""];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    self.view = tableView;
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    if (!animated) {
        [tableView.layer removeAllAnimations];
        tableView.hidden = hidden;
        if (hidden) {
            tableView.frame = CGRectMake(kTableLeftOffset, kTableTopOffsetInvisible, kTableWidth, kTableHeight);
        } else {
            tableView.frame = CGRectMake(kTableLeftOffset, kTableTopOffsetVisible, kTableWidth, kTableHeight);
        }
    } else {
        tableView.hidden = NO;
        [tableView.layer removeAllAnimations];
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
        anim.fromValue = [NSValue valueWithCGPoint:tableView.layer.position];
        anim.duration = 0.25f;
        if (hidden) {
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kTableLeftOffset + (kTableWidth/2), kTableTopOffsetInvisible + (kTableHeight/2))];
            tableView.frame = CGRectMake(kTableLeftOffset, kTableTopOffsetInvisible, kTableWidth, kTableHeight);
        } else {
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kTableLeftOffset + (kTableWidth/2), kTableTopOffsetVisible + (kTableHeight/2))];
            tableView.frame = CGRectMake(kTableLeftOffset, kTableTopOffsetVisible, kTableWidth, kTableHeight);
        }
        [[tableView layer] addAnimation:anim forKey:@"positionAnimation"];
    }
}


- (void)loadWithSubstring:(NSString *)aSubstring {
    lastSubstring = substring;
    substring = [aSubstring retain];
    
    [[eventQueueStation performThreadedWithTarget:self] loadAdditionalDataThreaded];
    [[eventQueueAdditonal performThreadedWithTarget:self] loadStationDataThreaded];
    //[NSThread detachNewThreadSelector:@selector(loadAdditionalDataThreaded) toTarget:self withObject:nil];
    //[NSThread detachNewThreadSelector:@selector(loadStationDataThreaded) toTarget:self withObject:nil];
}

- (NSArray *)additionalData {
    if (!additionalData) {
        [dblock lock];
        NSMutableArray *tmp;
        
        // Current Location - Top
        TPScheduleInput *currentlocation = [[TPScheduleInput alloc] init];
        currentlocation.list = TPScheduleInputListPlace;
        currentlocation.type = TPScheduleInputTypeCurrentLocation;
        currentlocation.stringRepresentation = NSLocalizedString(@"Current Location", nil);
        currentlocation.forced = YES;
        tmp = [NSMutableArray arrayWithObject:currentlocation];
        
        TPFavorite *fav = [[TPFavorite alloc] init];
        [tmp addObjectsFromArray:[fav favoriteStations:substring]];
        
        NSArray *ret = [[[NSArray alloc] initWithArray:tmp] autorelease];
        self.additionalData = ret;
        [dblock unlock];
    }
    
    return additionalData;
}

- (NSArray *)stationData {
    if (!stationData) {
        [dblock lock];
        NSString *dbWhere = [substring lowercaseString];
        
        TPPlace *place = [[TPPlace alloc] init];
        self.stationData = [[place stations:dbWhere] copy];
        [dblock unlock];
    }
    
    return stationData;
}

- (void)loadStationDataThreaded {
    self.currentStationData = [[self postProcessData:[self stationData]] retain];
    [self performSelectorOnMainThread:@selector(loadToTable) withObject:nil waitUntilDone:YES];
}

- (void)loadAdditionalDataThreaded {
    self.currentAdditionalData = [[self postProcessData:[self additionalData]] retain];
    [self performSelectorOnMainThread:@selector(loadToTable) withObject:nil waitUntilDone:YES];
}
     
- (void)loadToTable {
    NSMutableArray *tmp = [NSMutableArray array];
    [tmp addObjectsFromArray:self.currentAdditionalData];
    [tmp addObjectsFromArray:self.currentStationData];

        
    self.data = [NSArray arrayWithArray:tmp];
    [tableView loadWithSubstring:substring data:self.data];
}

- (NSArray *)postProcessData:(NSArray *)newData {
    NSString *aSubstring = [substring retain];
    NSMutableArray *newEntries = [[[NSMutableArray alloc] init] autorelease];   
    @synchronized(self) {
        NSArray *entries = [newData copy];
        NSEnumerator *enumerator = [entries objectEnumerator];
        id element;
        while ((element = [enumerator nextObject]) && ([newEntries count] < 20)) {        
            if ([aSubstring length] == 0 || [[element stringRepresentation] rangeOfString:aSubstring options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)].location != NSNotFound) {
                [newEntries addObject:element];
            }
        }
    }
    
    return newEntries;
}

- (void)setDelegate:(id)aDelegate {
    [delegate autorelease];
    delegate = [aDelegate retain];
    tableView.delegate = delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [data release];
    [additionalData release];
    [stationData release];
    [currentStationData release];
    [currentAdditionalData release];
    [delegate release];
    [tableView release];
    [super dealloc];
}


@end