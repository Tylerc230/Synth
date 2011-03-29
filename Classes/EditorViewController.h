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

@interface EditorViewController : UIViewController<UIAlertViewDelegate> {
	NSMutableArray * oscillatorViews_;
	Oscillator * focusOscillator_;
	NSTimer * longHold_;
	UITouch * currentTouch_;
	RadialMenuViewController * currentMenu_;
}

- (void)itemIndexSelected:(int)itemIndex;
- (Oscillator *)selectedOscillator;
- (void)oscillatorCreated:(Oscillator *)oscillator;
- (Oscillator *)oscillatorForId:(int)oscId;
- (NSRange)rangeForScreen;
@end

