//
//  TriangleOscillator.m
//  Synth
//
//  Created by Tyler Casselman on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TriangleOscillator.h"


@implementation TriangleOscillator
- (AudioFrame)nextFrame
{
	float sample = currentPhase_ < .5 ? (currentPhase_ * 4 - 1) : (currentPhase_ * -4 + 3);
	return [self getFrameForSample:sample];
	
}
@end
