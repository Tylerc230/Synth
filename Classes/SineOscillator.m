//
//  SineOssillator.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SineOscillator.h"
#import "OscillatorController.h"

@implementation SineOscillator

- (id)init
{
	if((self = [super init]))
	{
		currentPhase_ = 0.f;
	}
	return self;
}

- (void)setFrequency:(float)frequency
{
	[super setFrequency:frequency];
	phaseIncrement_ = self.frequency * 2 * M_PI / SAMPLE_RATE;
}

- (AudioFrame)nextFrame
{
	int16_t sample = INT16_MAX * sinf(currentPhase_) * self.amplitude;
	AudioFrame nextFrame;
	float leftAmp = 1 - self.balance;
	float rightAmp = self.balance;
	nextFrame.left = sample * leftAmp;
	nextFrame.right = sample * rightAmp;
	
	currentPhase_ += phaseIncrement_;	
	while(currentPhase_ > 2*M_PI)
	{
		currentPhase_ -= 2*M_PI;
	}
	
	return nextFrame;
	
}
@end
