//
//  SquareOscillator.m
//  Synth
//
//  Created by Tyler Casselman on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SquareOscillator.h"
#import "OscillatorController.h"

@implementation SquareOscillator

- (float)sample
{
	float sample = self.currentPhase > .5 ? 1 : -1;	
	return sample * self.amplitude;
	
}

@end
