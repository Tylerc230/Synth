//
//  SynthViewController.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditorViewController.h"
#import "SineOscillator.h"
#import "SquareOscillator.h"
#import "TriangleOscillator.h"
#import "OscillatorView.h"


@interface EditorViewController ()
- (Oscillator*)createOscillator:(int)index;
- (void)longHoldOccured:(NSTimer*) timer;
- (void)showRadialMenu;
- (void)setOsc:(Oscillator *) osc withPosition:(CGPoint) position;
@end

@implementation EditorViewController


- (Oscillator*)createOscillator:(int)index
{
	CGPoint start = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
	OscillatorView * view = [[OscillatorView alloc] initWithFrame:CGRectMake(start.x, start.y, 50, 50)];
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
	osc.oscId = oscillatorId;
	[self setOsc:osc withPosition:start];
	return [osc autorelease];
	
}

- (float)pitchForPosition:(CGPoint )position
{
	NSRange screenRange = [self rangeForScreen];
	float base = screenRange.location;
	float range = screenRange.length;
	float y = position.y;
	float windowHeight = self.view.frame.size.height;
	float ratio = 1 - (y/windowHeight);
	return ratio * range + base;
}

- (float)balanceForPosition:(CGPoint )position
{
	float range = 1.0;
	float x = position.x;
	float ratio = x/self.view.frame.size.width;
	return ratio * range;
}

- (void)setOsc:(Oscillator *) osc withPosition:(CGPoint) position
{
	float pitch = [self pitchForPosition:position];
	float balance = [self balanceForPosition:position];
	osc.frequency = pitch;
	osc.balance = balance;
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch * touch = [touches anyObject];
	for (OscillatorView * oscView in oscillatorViews_) {
		if (CGRectContainsPoint(oscView.frame, [touch locationInView:self.view]))
		{
			focusOscillator_ = [self oscillatorForId:oscView.tag];
			break;
		}
	}
	if(focusOscillator_ == nil)
	{
		[self showRadialMenu];
		currentTouch_ = [touch retain];
	}else{
		CGPoint position = [[touches anyObject] locationInView:self.view];
		[self setOsc:focusOscillator_ withPosition:position];
		longHold_ = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(longHoldOccured:) userInfo:focusOscillator_ repeats:NO];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	[longHold_ invalidate], longHold_ = nil;
	OscillatorView * currentView = (OscillatorView*)[self.view viewWithTag:focusOscillator_.oscId];
	CGPoint position = [[touches anyObject] locationInView:self.view];
	currentView.center = position;
	[self setOsc:focusOscillator_ withPosition:position];
	 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[longHold_ invalidate], longHold_ = nil;
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
	focusOscillator_ = [self oscillatorForId:oscillatorView.tag];
	UIAlertView * confirmation = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you want to edit this oscillator" delegate:self cancelButtonTitle:@"Don't edit" otherButtonTitles:@"Edit", nil];
	[confirmation show];
}


- (void)itemIndexSelected:(int)itemIndex
{
	Oscillator * osc = [self createOscillator:itemIndex];
	[self setOsc:osc withPosition:[currentTouch_ locationInView:self.view]];
	[self oscillatorCreated:osc];

	[self hideRadialMenu];
}

- (void)oscillatorCreated:(Oscillator *)oscillator
{
	
}

- (Oscillator *)oscillatorForId:(int)oscId
{
	return nil;
}

- (NSRange)rangeForScreen
{
	return NSMakeRange(0, 0);
}

- (Oscillator *)selectedOscillator
{
	return focusOscillator_;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	oscillatorViews_ = [[NSMutableArray alloc] initWithCapacity:10];
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
