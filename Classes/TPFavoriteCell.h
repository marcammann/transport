//
//  TPFavoriteCell.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFavoriteTrip.h"
#import "TPTrip.h"

@interface TPFavoriteCell : UITableViewCell {
    TPFavoriteTrip *trip;
    
    UILabel *from;
    UILabel *to;
    UIImageView *separtor;
}

@property (nonatomic, retain) TPFavoriteTrip *trip;

@end
