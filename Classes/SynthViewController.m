//
//  SynthViewController.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynthViewController.h"
#import "SineOscillator.h"
#import "OscillatorView.h"

@interface SynthViewController ()
- (Oscillator *)createOscillator;
@end

@implementation SynthViewController

- (IBAction)playPressed:(id)button
{
	[controller_ play];	
}

- (IBAction)addPressed:(id)button
{

		
}

- (Oscillator*)createOscillator
{
	OscillatorView * view = [[OscillatorView alloc] init];
	[oscillatorViews_ addObject:view];
	[self.view addSubview:view];
	int oscillatorId = 3000 + oscillatorViews_.count;
	view.tag = oscillatorId;
	SineOscillator * sine = [[SineOscillator alloc] init];
	[controller_ addOscillator:sine withId:oscillatorId];
	[sine release];
	return sine;
	
}

- (float)pitchForTouch:(UITouch *)touch
{
	float base = 0;
	float range = 400.f;
	float y = [touch locationInView:self.view].y;
	float windowHeight = self.view.frame.size.height;
	float ratio = 1 - (y/windowHeight);
	return ratio * range + base;
}

- (float)balanceForTouch:(UITouch *)touch
{
	float range = 1.0;
	float x = [touch locationInView:self.view].x;
	float ratio = x/self.view.frame.size.width;
	return ratio * range;
}

- (void)setOsc:(Oscillator *) osc withTouch:(UITouch*) touch
{
	float pitch = [self pitchForTouch:touch];
	float balance = [self balanceForTouch:touch];
	osc.frequency = pitch;
	osc.balance = balance;
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	draggingOsc_ = [self createOscillator];
	[self setOsc:draggingOsc_ withTouch:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	OscillatorView * currentView = (OscillatorView*)[self.view viewWithTag:draggingOsc_.oscId];
	currentView.center = [[touches anyObject] locationInView:self.view];
	[self setOsc:draggingOsc_ withTouch:[touches anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	oscillatorViews_ = [[NSMutableArray alloc] initWithCapacity:10];
	controller_ = [[OscillatorController alloc] init];
	[controller_ setup];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
