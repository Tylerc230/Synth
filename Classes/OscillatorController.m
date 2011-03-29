//
//  OscillatorController.m
//  Synth
//
//  Created by Tyler Casselman on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OscillatorController.h"


#define FAIL_ON_ERR(x)\
failure = (x);\
if((failure) != noErr){NSLog(@"Err: %ld", failure); exit(failure);}

#pragma mark -
#pragma mark Application lifecycle
static void buffer_callback(void * userData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer);

@interface OscillatorController ()
- (int32_t) createFrame;
@end

@implementation OscillatorController
@synthesize playing = playing_;
- (void)setup
{
	oscillators_ = [[NSMutableDictionary alloc] initWithCapacity:10];
	NSError * error;
	AVAudioSession * session = [AVAudioSession sharedInstance];
    if (![session setActive:YES error:&error]) {
        NSLog(@"Could not activate audio session: %@ %@", error, [error userInfo]);
        return;
    }
	
	[session setDelegate:self];
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Could not set audio session category: %@ %@", error, [error userInfo]);
    }
	
    UInt32 formatFlags = (0 | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger | kAudioFormatFlagsNativeEndian);
	
	format_ = (AudioStreamBasicDescription){
        .mFormatID = kAudioFormatLinearPCM,
        .mFormatFlags = formatFlags,
        .mSampleRate = SAMPLE_RATE,
        .mBitsPerChannel = 16,
        .mChannelsPerFrame = 2,
        .mBytesPerFrame = 4,
        .mFramesPerPacket = 1,
        .mBytesPerPacket = 4,
    };
    

	
}

- (void)beginInterruption;
{
}

- (void)endInterruption;
{
}

- (void)addOscillator:(Oscillator * )osc
{
	[oscillators_ setObject:osc forKey:[NSNumber numberWithInt:osc.oscId]];
}

- (Oscillator *)oscillatorWithId:(int)oscId
{
	return  [oscillators_ objectForKey:[NSNumber numberWithInt:oscId]];
}

- (void)play
{
	playing_ = YES;
	OSStatus failure;
	FAIL_ON_ERR(AudioQueueNewOutput(&format_, buffer_callback, self, CFRunLoopGetCurrent(), kCFRunLoopCommonModes, 0, &queue_));

    UInt32 bufferSize = format_.mSampleRate * format_.mBytesPerPacket * .5f;
	
    for (int i = 0; i < 3; i++) {
        FAIL_ON_ERR(AudioQueueAllocateBuffer(queue_, bufferSize, &buffers_[i]));
    }
	for (int i = 0; i < 3; i++) {
        buffer_callback(self, queue_, buffers_[i]);
	}
	FAIL_ON_ERR(AudioQueueStart(queue_, NULL));

	
}

- (void)stop
{
	playing_ = NO;
	OSStatus failure;
	FAIL_ON_ERR(AudioQueueStop(queue_, YES));
	FAIL_ON_ERR(AudioQueueDispose(queue_, YES));
	queue_ = NULL;	

}

- (void)fillBuffer:(AudioQueueBufferRef) buffer
{
	if(!playing_)
		return;
	OSStatus failure;
	int16_t * sampleBuffer = buffer->mAudioData;
    UInt32 numFrames = buffer->mAudioDataBytesCapacity / format_.mBytesPerFrame;
	
	for(int i = 0; i < numFrames; i++)
	{
		*((int32_t*)sampleBuffer) = [self createFrame];
		sampleBuffer +=format_.mChannelsPerFrame;
	}
	buffer->mAudioDataByteSize = numFrames * format_.mBytesPerFrame;
	FAIL_ON_ERR(AudioQueueEnqueueBuffer(queue_, buffer, 0, NULL));
	
}

- (int32_t) createFrame
{
	int32_t sampleL = 0;
	int32_t sampleR = 0;
	int numOscillators = oscillators_.count;
	if (numOscillators <= 0) {
		return 0;
	}
	for (Oscillator * osc in [oscillators_ allValues]) {
		AudioFrame oscFrame = [osc nextFrame];
		sampleL += oscFrame.left * INT16_MAX;
		sampleR += oscFrame.right * INT16_MAX;
	}
	sampleL /= numOscillators;
	sampleR /= numOscillators;
	return (sampleL << 16 | sampleR);
}

@end

static void buffer_callback(void * userData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer)
{
    OscillatorController * control = userData;
	[control fillBuffer:inBuffer];
}
