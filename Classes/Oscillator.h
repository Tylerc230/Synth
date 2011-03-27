//
//  Ossilator.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
	float left;
	float right;
}AudioFrame;
@interface Oscillator : NSObject {
@protected
	int oscId_;
    float frequency_;
	float amplitude_;
	float balance_;
	float phaseIncrement_;
	float phaseBase_;
	Oscillator * pitchModulator_;

}
@property (nonatomic, assign) int oscId;
@property (nonatomic, assign) float frequency;
@property (nonatomic, assign) float amplitude;
@property (nonatomic, assign) float balance;
@property (nonatomic, retain) Oscillator * pitchModulator;
@property (nonatomic, readonly) float currentPhase;

- (AudioFrame)nextFrame;
- (float)sample;
- (void)update;
@end
