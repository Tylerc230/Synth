//
//  SynthViewController.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OscillatorController.h"
#import "RadialMenuViewController.h"

@interface SynthViewController : UIViewController {
	OscillatorController * controller_;
	NSMutableArray * oscillatorViews_;
	Oscillator * draggingOsc_;
	NSTimer * longHold_;
	UITouch * currentTouch_;
	RadialMenuViewController * currentMenu_;
}

- (IBAction)addPressed:(id)button;
- (void)itemIndexSelected:(int)itemIndex;

@end

