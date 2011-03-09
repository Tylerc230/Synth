//
//  SineOssillator.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Oscillator.h"

@interface SineOscillator : Oscillator {
	float phaseIncrement_;
	float currentPhase_;	
}

@end
