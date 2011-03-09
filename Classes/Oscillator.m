//
//  Ossilator.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Oscillator.h"
#import "OscillatorController.h"

@implementation Oscillator
@synthesize oscId = oscId_;
@synthesize frequency = frequency_;
@synthesize amplitude = amplitude_;
@synthesize balance = balance_;

- (id)init
{
	if((self = [super init]))
	{
		self.amplitude = .5f;
		self.balance = .5f;
		
	}
	return self;
}

- (void)setFrequency:(float)frequency
{
	frequency_ = frequency;
	phaseIncrement_ = self.frequency  / SAMPLE_RATE;
}


- (AudioFrame)nextFrame
{
	return (AudioFrame){.left =0, .right = 0};
}

- (AudioFrame)getFrameForSample:(float)relativeValue
{
	int16_t sample = relativeValue * self.amplitude * INT16_MAX;
	AudioFrame nextFrame;
	float leftAmp = 1 - self.balance;
	float rightAmp = self.balance;
	nextFrame.left = sample * leftAmp;
	nextFrame.right = sample * rightAmp;
	[self update];
	return nextFrame;
	
}

- (void)update
{
	currentPhase_ += phaseIncrement_;	
	while(currentPhase_ > 1.0)
	{
		currentPhase_ -= 1.0;
	}
}

@end
