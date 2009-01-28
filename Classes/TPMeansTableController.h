//
//  TPMeansTableController.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSettings.h"

@protocol TPMeansTableControllerDelegate
- (void)meansTableControllerIsDone:(id)controller;
@end


@interface TPMeansTableController : UITableViewController {
    TPSettings *settings;
    id delegate;
}

@end
