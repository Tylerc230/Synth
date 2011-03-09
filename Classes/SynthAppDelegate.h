//
//  SynthAppDelegate.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SynthViewController;

@interface SynthAppDelegate : NSObject <UIApplicationDelegate> {
    SynthViewController *viewController;
}

@property (nonatomic, retain) IBOutlet SynthViewController *viewController;
@end

