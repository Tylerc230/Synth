//
//  Ossilator.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Oscillator.h"


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

- (AudioFrame)nextFrame
{
	return (AudioFrame){.left =0, .right = 0};
}

@end
