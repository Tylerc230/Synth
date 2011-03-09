//
//  SynthViewController.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OscillatorController.h"

@interface SynthViewController : UIViewController {
	OscillatorController * controller_;
	NSMutableArray * oscillatorViews_;
	Oscillator * draggingOsc_;
}

- (IBAction)playPressed:(id)button;
- (IBAction)addPressed:(id)button;

@end

