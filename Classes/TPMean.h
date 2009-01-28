//
//  TPMean.h
//  ZVVTransport
//
//  Created by Marc Ammann on 1/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TPMean : NSObject {
    NSString *name;
    BOOL enabled;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic) BOOL enabled;

- (id)initWithName:(NSString *)aName enabled:(BOOL)isEnabled;

@end
