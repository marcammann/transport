//
//  TPRecentCell.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPRecent.h"
#import "TPRecentTrip.h"

@interface TPRecentCell : UITableViewCell {
    TPRecentTrip *trip;
    
    UILabel *from;
    UILabel *to;
    
    UILabel *time;
    UILabel *timeTitle;
    
    UIImageView *separtor;
}

@property (nonatomic, retain) TPRecentTrip *trip;

@end
