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
		currentPhase_ = 0.f;
	}
	return self;
}


- (AudioFrame)nextFrame
{
	float sample = sinf(currentPhase_ * 2 * M_PI);
	return [self getFrameForSample:sample];
	
}
@end
