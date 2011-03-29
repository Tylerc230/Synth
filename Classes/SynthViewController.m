//
//  SynthViewController.m
//  Synth
//
//  Created by Tyler Casselman on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynthViewController.h"
#import "OscillatorEditorViewController.h"

@implementation SynthViewController


- (IBAction)playPressed:(id)button
{
	if(controller_.playing)
		[controller_ stop];
	else
		[controller_ play];	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	controller_ = [[OscillatorController alloc] init];
	[controller_ setup];
	[controller_ play];
}


- (void)oscillatorCreated:(Oscillator *)oscillator
{
	[controller_ addOscillator:oscillator];
}

- (Oscillator *)oscillatorForId:(int)oscId
{
	return [controller_ oscillatorWithId:oscId];
}

- (NSRange)rangeForScreen
{
	return NSMakeRange(0, 100);
}

#pragma UIAlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		OscillatorEditorViewController * editView = [[OscillatorEditorViewController alloc] initWithOscillator:[self selectedOscillator]];
		[self.navigationController pushViewController:editView animated:YES];
	}
	[alertView release];
}

@end
