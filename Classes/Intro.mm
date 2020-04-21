//
//  Cover.m
//  Timmy Tickle Baby
//
//  Created by Harriet Pellereau on 24/05/13
//  Copyright 2013 NIMBLEBEAN LIMITED. All rights reserved.
//

// Import the interfaces
#import "Intro.h"
#import "Advert.h"
#import "scene_1AppDelegate.h"
#import "BackgroundSingleton.h"
#import "Globals.h"



// HelloWorld implementation
@implementation Intro



+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Intro *layer = [Intro node];
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}




// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    
                
        //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];

        
        [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"Default-Landscape~ipad.png"];
        
            // ADD WAVE VIDEO
            AVPlayer *avplayer_wave = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Nimblebean" ofType:@"m4v"]]];
            
            avplayerlayer_wave = [AVPlayerLayer playerLayerWithPlayer:avplayer_wave];
            [avplayer_wave release];
            
            avplayerlayer_wave.frame = CGRectMake(0, 0, 1024, 768);
            [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_wave];
            
            // WAVE VIDEO DID END NOTIFICATION
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(nimblebeanDidEnd)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[avplayerlayer_wave.player currentItem]];
	}
	return self;
}

-(void) playNimblebean {
    
    [avplayerlayer_wave.player play];
}


- (void) onEnterTransitionDidFinish {
    
    [self playNimblebean];
 
    [super onEnterTransitionDidFinish];
  
    
}



- (void)nimblebeanDidEnd
{
    
    [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"INTRO_background.jpg"];
    
    [self nextScene];

}


- (void) nextScene {
    
    [[CCDirector sharedDirector]replaceScene:[Advert scene]];
}





// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //CCLOG(@"Intro dealloc");
    //NSLog(@"rc: %d", [Intro retainCount]);
    
    
    // REMOVE AVPLAYER LAYERS FOR THIS SCENE
    
    if (avplayerlayer_wave) {
        [avplayerlayer_wave removeFromSuperlayer];
        avplayerlayer_wave = nil;
    }
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    // don't forget to call "super dealloc"
	[super dealloc];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    
    [[CCDirector sharedDirector] purgeCachedData];
}

@end
