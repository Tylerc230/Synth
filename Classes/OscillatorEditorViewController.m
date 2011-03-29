//
//  OscillatorEditorViewController.m
//  Synth
//
//  Created by Tyler Casselman on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OscillatorEditorViewController.h"


@implementation OscillatorEditorViewController

- (OscillatorEditorViewController *)initWithOscillator:(Oscillator *)oscillator
{
	if((self = [super init]))
	{
		oscillator_ = [oscillator retain];
	}
	return self;
}

- (void)oscillatorCreated:(Oscillator *)oscillator
{
	oscillator_.pitchModulator = oscillator;
}

- (Oscillator *)oscillatorForId:(int)oscId
{
	return oscillator_.pitchModulator;
}

- (NSRange)rangeForScreen
{
	return NSMakeRange(0, 2);
}

- (void)dealloc
{
	[oscillator_ release], oscillator_ = nil;
	[super dealloc];
}


@end
