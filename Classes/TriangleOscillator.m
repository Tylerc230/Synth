//
//  TriangleOscillator.m
//  Synth
//
//  Created by Tyler Casselman on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TriangleOscillator.h"


@implementation TriangleOscillator
- (float)sample
{
	float sample = self.currentPhase < .5 ? (self.currentPhase * 4 - 1) : (self.currentPhase * -4 + 3);
	return sample * self.amplitude;
	
}
@end
