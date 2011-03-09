//
//  Ossilator.h
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
	int16_t left;
	int16_t right;
}AudioFrame;
@interface Oscillator : NSObject {
@protected
	int oscId_;
    float frequency_;
	float amplitude_;
	float balance_;
	float phaseIncrement_;
	float currentPhase_;	

}
@property (nonatomic, assign) int oscId;
@property (nonatomic, assign) float frequency;
@property (nonatomic, assign) float amplitude;
@property (nonatomic, assign) float balance;

- (AudioFrame)nextFrame;
- (AudioFrame)getFrameForSample:(float)relativeValue;
- (void)update;
@end
