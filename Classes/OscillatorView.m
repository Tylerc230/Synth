//
//  OscillatorView.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OscillatorView.h"


@implementation OscillatorView

- (id)init
{
	UIImage * cicle = [UIImage imageNamed:@"circle.jpg"];
	if((self = [super initWithImage:cicle]))
	{
		CGRect frame = self.frame;
		frame.size.width *= .25;
		frame.size.height *= .25;
		self.frame = frame;
	}
	return  self;
	
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

@end
