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

- (AudioFrame)nextFrame
{
	float sample = currentPhase_ > .5 ? 1 : -1;	
	NSLog(@"tri %f", sample);
	return [self getFrameForSample:sample];
	
}

@end
