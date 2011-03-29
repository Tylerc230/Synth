//
//  OscillatorEditorViewController.h
//  Synth
//
//  Created by Tyler Casselman on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditorViewController.h"
#import "Oscillator.h"

@interface OscillatorEditorViewController : EditorViewController {
	Oscillator * oscillator_;    
}
- (OscillatorEditorViewController *)initWithOscillator:(Oscillator *)oscillator;

@end
