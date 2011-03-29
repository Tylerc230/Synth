//
//  OscillatorView.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OscillatorView.h"
#define cStrokeWidth 10


@implementation OscillatorView

- (void)drawRect:(CGRect)rect
{
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(currentContext, [UIColor greenColor].CGColor);
	CGContextSetStrokeColorWithColor(currentContext, [UIColor whiteColor].CGColor);
	CGContextSetLineWidth(currentContext, 5.f);
	CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
	CGContextAddArc(currentContext, center.x, center.y, (rect.size.width - cStrokeWidth)/2, 0, 2 * M_PI, YES);
	
	CGContextDrawPath(currentContext,  kCGPathFillStroke);
}

@end
