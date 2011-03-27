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
@synthesize pitchModulator = pitchModulator_;
@dynamic currentPhase;

- (id)init
{
	if((self = [super init]))
	{
		self.amplitude = .5f;
		self.balance = .5f;
		phaseBase_ = 0.f;
		
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
	float sample = [self sample];
	AudioFrame nextFrame;
	float leftAmp = 1 - self.balance;
	float rightAmp = self.balance;
	nextFrame.left = sample * leftAmp;
	nextFrame.right = sample * rightAmp;
	[self update];
	return nextFrame;
}

- (float)sample
{
	return 0;
}

- (void)update
{
	phaseBase_ += phaseIncrement_;	
	[pitchModulator_ update];
	while(phaseBase_ > 1.0)
	{
		phaseBase_ -= 1.0;
	}
}

- (float)currentPhase 
{
	float modulation = [pitchModulator_ sample] + 1;
	return phaseBase_ * modulation;
}

@end
