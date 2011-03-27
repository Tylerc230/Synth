//
//  SineOssillator.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SineOscillator.h"

@implementation SineOscillator

- (id)init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (float)sample
{
	float phase = self.currentPhase;
	float amplitude = self.amplitude;
	float sample = sinf(phase * 2 * M_PI)  * amplitude;
	return sample;
}

@end
