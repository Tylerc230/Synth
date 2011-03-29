//
//  SynthViewController.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynthViewController.h"
#import "SineOscillator.h"
#import "SquareOscillator.h"
#import "TriangleOscillator.h"
#import "OscillatorView.h"


@interface SynthViewController ()
- (Oscillator*)createOscillator:(int)index;
- (void)longHoldOccured:(NSTimer*) timer;
- (void)showRadialMenu;
@end

@implementation SynthViewController

- (IBAction)playPressed:(id)button
{
	if(controller_.playing)
		[controller_ stop];
	else
		[controller_ play];	
}


- (Oscillator*)createOscillator:(int)index
{
	OscillatorView * view = [[OscillatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	[view addTarget:self action:@selector(editOscillator:) forControlEvents:UIControlEventTouchUpInside];
	[oscillatorViews_ addObject:view];
	[self.view addSubview:view];
	int oscillatorId = 3000 + oscillatorViews_.count;
	view.tag = oscillatorId;
	Class osClass = nil;
	switch (index) {
		case 1:
			osClass = [SineOscillator class];
			break;
		case 2:
			osClass = [SquareOscillator class];
			break;
		case 3:
			osClass = [TriangleOscillator class];
			break;
		default:
			break;
	}
	Oscillator * osc = [[osClass alloc] init];
	[controller_ addOscillator:osc withId:oscillatorId];
	[osc release];
	return osc;
	
}

- (float)pitchForTouch:(UITouch *)touch
{
	float base = 0;
	float range = 100.f;
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
	UITouch * touch = [touches anyObject];
	for (OscillatorView * oscView in oscillatorViews_) {
		if (CGRectContainsPoint(oscView.frame, [touch locationInView:self.view]))
		{
			draggingOsc_ = [controller_ oscillatorWithId:oscView.tag];
			break;
		}
	}
	if(draggingOsc_ == nil)
	{
		[self showRadialMenu];
		currentTouch_ = [touch retain];
	}else{
		[self setOsc:draggingOsc_ withTouch:[touches anyObject]];
		longHold_ = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(longHoldOccured:) userInfo:draggingOsc_ repeats:NO];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[longHold_ invalidate], longHold_ = nil;
	OscillatorView * currentView = (OscillatorView*)[self.view viewWithTag:draggingOsc_.oscId];
	currentView.center = [[touches anyObject] locationInView:self.view];
	[self setOsc:draggingOsc_ withTouch:[touches anyObject]];
	 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[longHold_ invalidate], longHold_ = nil;
	draggingOsc_ = nil;
}

- (void)longHoldOccured:(NSTimer*) timer
{
	
}

- (void)showRadialMenu
{
	currentMenu_ = [[RadialMenuViewController alloc] init];
	currentMenu_.menuDelegate = self;
	currentMenu_.view.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
	[self.view addSubview:currentMenu_.view];
}

- (void)hideRadialMenu
{
	[currentMenu_.view removeFromSuperview];
	[currentMenu_ release];
}

- (void)editOscillator:(OscillatorView *)oscillatorView
{
	UIAlertView * confirmation = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to edit this oscillator" delegate:self cancelButtonTitle:@"Don't edit" otherButtonTitles:@"Edit", nil];
	[confirmation show];
}

#pragma UIAlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		
	}
	[alertView release];
}


- (void)itemIndexSelected:(int)itemIndex
{
	Oscillator * osc = [self createOscillator:itemIndex];
	[self setOsc:osc withTouch:currentTouch_];
	[self hideRadialMenu];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	oscillatorViews_ = [[NSMutableArray alloc] initWithCapacity:10];
	controller_ = [[OscillatorController alloc] init];
	[controller_ setup];
	[controller_ play];
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
