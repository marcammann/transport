//
//  TPFavoriteCell.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPFavoriteCell.h"


@implementation TPFavoriteCell

@synthesize trip;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {        
        separtor = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 24.0f, 320.0f, 13.0f)];
        separtor.image = [UIImage imageNamed:@"favoriteArrow.png"];
        
        from = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 6.0f, 220.0f, 18.0f)];
        from.font = [UIFont boldSystemFontOfSize:14.0f];
        from.textColor = [UIColor darkGrayColor];
        
        to = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 36.0f, 220.0f, 18.0f)];
        to.font = [UIFont boldSystemFontOfSize:14.0f];
        to.textColor = [UIColor darkGrayColor];
        //to.textAlignment = UITextAlignmentRight;
        
        UILabel *fromTitle = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 6.0f, 50.0f, 18.0f)];
        fromTitle.text = NSLocalizedString(@"From:", nil);
        fromTitle.font = [UIFont boldSystemFontOfSize:14.0f];
        fromTitle.textColor = [UIColor lightGrayColor];
        
        UILabel *toTitle = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 36.0f, 50.0f, 18.0f)];
        toTitle.text = NSLocalizedString(@"To:", nil);
        toTitle.font = [UIFont boldSystemFontOfSize:14.0f];
        toTitle.textColor = [UIColor lightGrayColor];
        
        [self addSubview:fromTitle];
        [self addSubview:toTitle];
        [self addSubview:from];
        [self addSubview:to];
        [self addSubview:separtor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setTrip:(TPFavoriteTrip *)aTrip {
    [trip release];
    trip = [aTrip retain];
    
    from.text = trip.from.stringRepresentation;
    to.text = trip.to.stringRepresentation;
    
    if (trip.from.type == TPScheduleInputTypeCurrentLocation || trip.from.type == TPScheduleInputTypePOI) {
        from.textColor = [UIColor blueColor];
    } else {
        from.textColor = [UIColor darkGrayColor];
    }

    if (trip.to.type == TPScheduleInputTypeCurrentLocation || trip.to.type == TPScheduleInputTypePOI) {
        to.textColor = [UIColor blueColor];
    } else {
        to.textColor = [UIColor darkGrayColor];
    }
    
    [self setNeedsDisplay];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [trip release];
    [from release];
    [to release];
    [separtor release];
    [super dealloc];
}


@end
