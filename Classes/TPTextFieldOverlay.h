//
//  TPTextFieldOverlay.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TPTextFieldOverlay : UITextField {
    UIView *overlay;
}

@property (nonatomic, retain) UIView *overlay;

@end
