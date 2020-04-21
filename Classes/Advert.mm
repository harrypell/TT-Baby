//
//  Cover.m
//  Timmy Tickle Baby
//
//  Created by Harriet Pellereau on 24/05/13
//  Copyright 2013 NIMBLEBEAN LIMITED. All rights reserved.
//

// Import the interfaces
#import "Advert.h"
#import "Cover.h"
#import "SimpleAudioEngine.h"
#import "scene_1AppDelegate.h"
#import "BackgroundSingleton.h"
#import "Globals.h"




// HelloWorld implementation
@implementation Advert

/* BLINK REMOVED
@synthesize blink = _blinkC;
@synthesize blinkAction = _blinkActionC;
*/


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Advert *layer = [Advert node];
    
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
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            offset = 0;
            //blinkOffset = 0;
            infoOffsetBack = 0;
            offsetIcons = 0;
            offsetInfo = 0;
            offesetPlay = 0;
            offesetCopy = 0;
            offesetCopy1 = 0;
            offesetClippers = 0;
            ofsetTom = 0;
            offsetControl = 0;

            
        }
        
        else {
            offset = 37;
            //blinkOffset = 0.1;
            infoOffsetBack = 5;
            offsetIcons = 30;
            offsetInfo = 22;
            offesetPlay = 30;
            offesetCopy = 20;
            offesetCopy1 = 40;
            offesetClippers = 10;
            ofsetTom = 20;
            offsetControl = 25;
        }
        
        [SimpleAudioEngine initialize];
		[CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_HIGH];
		
        [CDAudioManager sharedManager].backgroundMusic.volume = 0.4f;
                        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        ////CCLOG(@"Cover Init Start Ignoring");

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];


        [[SimpleAudioEngine sharedEngine] preloadEffect:@"plop3.mp3"];
        
        // SET BACKGROUND IMAGE
        
            // Blue Background
            
            IntroBackground = [CCSprite spriteWithFile:@"INTRO_background.jpg"];
            IntroBackground.position = ccp((size.width)/2, (size.height/2));
            IntroBackground.opacity = 255;
            [self addChild:IntroBackground z:30];
            
            // Skip BUTTON
            
            CCMenuItemImage *skip1 = [CCMenuItemImage itemFromNormalImage:@"INTRO_SKIP.png" selectedImage:@"INTRO_SKIP_ROLL.png"
                                                                   target:self selector:@selector(IntroHomeSkip)];
            
            Skip = [CCMenu menuWithItems:skip1, nil];
            Skip.position = ccp(1150, 700-offset);
            Skip.opacity = 255;
            [self addChild:Skip z:31];
            
            
            
            // Intro 1 Assets
            
            Intro1_Copy = [CCSprite spriteWithFile:@"INTRO_01_Copy.png"];
            Intro1_Copy.position = ccp((size.width)/2, 192);
            [[Intro1_Copy texture] setAntiAliasTexParameters];
            //[Intro1_Copy setAntiAliasTexParameters];
            Intro1_Copy.opacity = 0;
            [self addChild:Intro1_Copy z:31];



            
            Intro1_Logo = [CCSprite spriteWithFile:@"INTRO_01_Logo.png"];
            Intro1_Logo.position = ccp((size.width)/2, 433);
            Intro1_Logo.opacity = 0;
            [self addChild:Intro1_Logo z:31];
            
            // Intro 2 Assets
            
            Intro2_Copy = [CCSprite spriteWithFile:@"INTRO_02_Copy.png"];
            Intro2_Copy.position = ccp((size.width)/2, 510-offesetCopy1);
            [[Intro2_Copy texture] setAntiAliasTexParameters];
            //[Intro2_Copy setAntiAliasTexParameters];
            Intro2_Copy.opacity = 0;
            [self addChild:Intro2_Copy z:31];
            
            Intro2_Tom = [CCSprite spriteWithFile:@"INTRO_02_Tom.png"];
            Intro2_Tom.position = ccp(+1340,240-ofsetTom);
            Intro2_Tom.opacity = 255;
            [self addChild:Intro2_Tom z:31];
            
            // Intro 3 Assets
            
            Intro3_Copy = [CCSprite spriteWithFile:@"INTRO_03_Copy.png"];
            Intro3_Copy.position = ccp(353, 494);
            [[Intro3_Copy texture] setAntiAliasTexParameters];
            //[Intro3_Copy setAntiAliasTexParameters];
            Intro3_Copy.opacity = 0;
            [self addChild:Intro3_Copy z:31];
            
                     
            Intro3_Sketch = [CCSprite spriteWithFile:@"INTRO_03_Sketch.png"];
            [[Intro3_Sketch texture] setAntiAliasTexParameters];
            Intro3_Sketch.position = ccp(800,306);
            Intro3_Sketch.opacity = 0;
            [self addChild:Intro3_Sketch z:31];
            
            // Intro 4 Assets
            
            Intro4_Copy = [CCSprite spriteWithFile:@"INTRO_04_Copy.png"];
            Intro4_Copy.position = ccp(507,540-offesetCopy);
            [[Intro4_Copy texture] setAntiAliasTexParameters];
            //[Intro4_Copy setAntiAliasTexParameters];
            Intro4_Copy.opacity = 0;
            [self addChild:Intro4_Copy z:31];
            
            Intr04_BabyBody = [CCSprite spriteWithFile:@"INTRO_04_BabyBody_03.png"];
            Intr04_BabyBody.position = ccp(1300,240+offset);
            Intr04_BabyBody.opacity = 255;
            [self addChild:Intr04_BabyBody z:31];
            
            Intr04_BabyArm1 = [CCSprite spriteWithFile:@"INTRO_04_BabyArm_Left.png"];
            Intr04_BabyArm1.position = ccp(1052, 200+offset);
            Intr04_BabyArm1.opacity = 255;
            [self addChild:Intr04_BabyArm1 z:31];
            
            Intr04_BabyArm2 = [CCSprite spriteWithFile:@"INTRO_04_BabyArm_Right.png"];
            Intr04_BabyArm2.position = ccp(1150, 200+offset);
            Intr04_BabyArm2.opacity = 255;
            [self addChild:Intr04_BabyArm2 z:31];
            
            Intr04_iPad = [CCSprite spriteWithFile:@"INTRO_04_iPad_01.png"];
            Intr04_iPad.position = ccp(-170, 230+offsetInfo);
            Intr04_iPad.opacity = 255;
            [self addChild:Intr04_iPad z:31];
            
            Intr04_Notes = [CCSprite spriteWithFile:@"INTRO_04_Notes_01.png"];
            Intr04_Notes.position = ccp(438,340);
            Intr04_Notes.opacity = 0;
            [self addChild:Intr04_Notes z:32];
            
            // Intro 5 Assets
            
            Intro5_Copy = [CCSprite spriteWithFile:@"INTRO_05_Copy.png"];
            Intro5_Copy.position = ccp(624,188);
            [[Intro5_Copy texture] setAntiAliasTexParameters];
            //[Intro4_Copy setAntiAliasTexParameters];
            Intro5_Copy.opacity = 0;
            [self addChild:Intro5_Copy z:31];
            
            Intro3_Clipper = [CCSprite spriteWithFile:@"INTRO_03_Clipper.png"];
            Intro3_Clipper.position = ccp(1550, 477-offesetClippers);
            Intro3_Clipper.opacity = 255;
            [self addChild:Intro3_Clipper z:31];
            
            Intro3_Packaging = [CCSprite spriteWithFile:@"INTRO_03_Packaging.png"];
            Intro3_Packaging.position = ccp(-150,384);
            Intro3_Packaging.opacity = 255;
            [self addChild:Intro3_Packaging z:31];

        
        
        
	}
	return self;
}



- (void) touchenabled {
    ////CCLOG(@"Cover Init Stop Ignoring");
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    self.isTouchEnabled = YES;
}



-(void)playAudioNamed:(NSString*)name
{
    [UkeLoop stop];
    NSString *ukeIRL = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    UkeLoop = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:ukeIRL] error:NULL];
    [UkeLoop prepareToPlay];
    UkeLoop.volume = 0.7;
    UkeLoop.numberOfLoops = -1;
    [UkeLoop play];
}


-(void)fadeTextAudioOut
{
    if (UkeLoop.volume > 0.1) {
        UkeLoop.volume = UkeLoop.volume - 0.1;
        [self performSelector:@selector(fadeTextAudioOut) withObject:nil afterDelay:0.1];
    } else {
        UkeLoop.volume = 0;
        [UkeLoop stop];
    }
}




- (void) onEnterTransitionDidFinish {
    
    [self playAudioNamed:@"UkuleleToy"];
    
    
    id TouchDelay = [CCDelayTime actionWithDuration:1.0];
    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
    [self runAction:TouchSequence];
    
    //IntroBackground.opacity = 255;
    
    [self playIntro];
    
    [super onEnterTransitionDidFinish];
    
    
}

- (void) GoToCover {
    
    [[CCDirector sharedDirector]replaceScene:[Cover scene]];
}



- (void) playIntro {
    
    IntroBackground.opacity = 255;
    
    id IntroPAUSE = [CCDelayTime actionWithDuration:4.0];
    id IntroPAUSE2 = [CCDelayTime actionWithDuration:3.0];
    id IntroPAUSE3 = [CCDelayTime actionWithDuration:5.0];
    
    id Intro1 = [CCCallFunc actionWithTarget:self selector:@selector(Intro1)];
    id Intro2 = [CCCallFunc actionWithTarget:self selector:@selector(Intro2)];
    id Intro3 = [CCCallFunc actionWithTarget:self selector:@selector(Intro3)];
    id Intro4 = [CCCallFunc actionWithTarget:self selector:@selector(Intro4)];
    
    CCSequence *IntroSequence = [CCSequence actions: Intro1, IntroPAUSE2, Intro2, IntroPAUSE, Intro3, IntroPAUSE3, Intro4, nil];
    IntroSequence.tag = 715;
    
    [self runAction:IntroSequence];
    
    
}




- (void) IntroHomeSkip {

    [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"orangeBgStart.jpg"];
    
    id FadeOut = [CCFadeOut actionWithDuration:0.6];
    [IntroBackground runAction:FadeOut];

    
    [self fadeTextAudioOut];
    
    ////CCLOG(@"INTRO SKIPPED");
    
    
    [self stopActionByTag:715];
    
    
    Skip.position = ccp(3000,3000);
    //IntroBackground.position = ccp(3000,3000);
    
    Intro1_Copy.position = ccp(3000,3000);
    Intro1_Logo.position = ccp(3000,3000);
    
    Intro2_Copy.position = ccp(3000,3000);
    Intro2_Tom.position = ccp(3000,3000);
    
    Intro3_Copy.position = ccp(3000,3000);
    Intro3_Clipper.position = ccp(3000,3000);
    Intro3_Packaging.position = ccp(3000,3000);
    Intro3_Sketch.position = ccp(3000,3000);
    
    Intro4_Copy.position = ccp(3000,3000);
    Intr04_BabyBody.position = ccp(3000,3000);
    Intr04_BabyArm1.position = ccp(3000,3000);
    Intr04_BabyArm2.position = ccp(3000,3000);
    Intr04_iPad.position = ccp(3000,3000);
    Intr04_Notes.position = ccp(3000,3000);
    
    Intro5_Copy.position = ccp(3000,3000);
    
    Skip.opacity = 0;
    //IntroBackground.opacity = ccp(3000,3000);
    
    Intro1_Copy.opacity = 0;
    Intro1_Logo.opacity = 0;
    
    Intro2_Copy.opacity = 0;
    Intro2_Tom.opacity = 0;
    
    Intro3_Copy.opacity = 0;
    Intro3_Clipper.opacity = 0;
    Intro3_Packaging.opacity = 0;
    Intro3_Sketch.opacity = 0;
    
    Intro4_Copy.opacity = 0;
    Intr04_BabyBody.opacity = 0;
    Intr04_BabyArm1.opacity = 0;
    Intr04_BabyArm2.opacity = 0;
    Intr04_iPad.opacity = 0;
    Intr04_Notes.opacity = 0;
    
    Intro5_Copy.opacity = 0;
    
    
    id HomeDelay = [CCDelayTime actionWithDuration:1.0];
    id HomeGo = [CCCallFunc actionWithTarget:self selector:@selector(GoToCover)];
    CCAction *iPadSequence = [CCSequence actions: HomeDelay, HomeGo, nil];
    [self runAction:iPadSequence];
    
    
}


- (void) IntroHome {
    
    [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"orangeBgStart.jpg"];
    
    id FadeOut = [CCFadeOut actionWithDuration:0.6];
    [IntroBackground runAction:FadeOut];
    
    
    [self fadeTextAudioOut];
    
    
    Skip.position = ccp(3000,3000);
    //IntroBackground.position = ccp(3000,3000);
    
    Intro1_Copy.position = ccp(3000,3000);
    Intro1_Logo.position = ccp(3000,3000);
    
    Intro2_Copy.position = ccp(3000,3000);
    Intro2_Tom.position = ccp(3000,3000);
    
    Intro3_Copy.position = ccp(3000,3000);
    Intro3_Clipper.position = ccp(3000,3000);
    Intro3_Packaging.position = ccp(3000,3000);
    Intro3_Sketch.position = ccp(3000,3000);
    
    Intro4_Copy.position = ccp(3000,3000);
    Intr04_BabyBody.position = ccp(3000,3000);
    Intr04_BabyArm1.position = ccp(3000,3000);
    Intr04_BabyArm2.position = ccp(3000,3000);
    Intr04_iPad.position = ccp(3000,3000);
    Intr04_Notes.position = ccp(3000,3000);
    
    Intro5_Copy.position = ccp(3000,3000);
    
    Skip.opacity = 0;
    //IntroBackground.opacity = ccp(3000,3000);
    
    Intro1_Copy.opacity = 0;
    Intro1_Logo.opacity = 0;
    
    Intro2_Copy.opacity = 0;
    Intro2_Tom.opacity = 0;
    
    Intro3_Copy.opacity = 0;
    Intro3_Clipper.opacity = 0;
    Intro3_Packaging.opacity = 0;
    Intro3_Sketch.opacity = 0;
    
    Intro4_Copy.opacity = 0;
    Intr04_BabyBody.opacity = 0;
    Intr04_BabyArm1.opacity = 0;
    Intr04_BabyArm2.opacity = 0;
    Intr04_iPad.opacity = 0;
    Intr04_Notes.opacity = 0;
    
    Intro5_Copy.opacity = 0;
    
    id HomeDelay = [CCDelayTime actionWithDuration:1.0];
    id HomeGo = [CCCallFunc actionWithTarget:self selector:@selector(GoToCover)];
    CCAction *iPadSequence = [CCSequence actions: HomeDelay, HomeGo, nil];
    [self runAction:iPadSequence];
    
    //[self startHome];
    
}







- (void) Intro1 {
    
    CCAction *CopyFadeIn  = [CCFadeIn actionWithDuration:0.5];
    CopyFadeIn.tag = 715;
    [Intro1_Logo runAction:CopyFadeIn];
    
    id LogoDelay = [CCDelayTime actionWithDuration:0.5];
    id LogoFadeIn = [CCFadeIn actionWithDuration:0.5];
    id LogoSequence = [CCSequence actions: LogoDelay, LogoFadeIn, nil];
    [Intro1_Copy runAction:LogoSequence];
    
    id SkipDelay = [CCDelayTime actionWithDuration:1.0];
    id SkipIn = [CCMoveTo actionWithDuration:0.4 position:ccp(860,700-offesetPlay)];
    id SkipInEase = [CCEaseExponentialOut actionWithAction:SkipIn];
    CCAction *SkipSequence = [CCSequence actions: SkipDelay, SkipInEase, nil];
    SkipSequence.tag = 715;

    [Skip runAction:SkipSequence];
    
}

- (void) Intro2 {
    
    id FadeOut = [CCFadeOut actionWithDuration:0.3];
    [Intro1_Copy runAction:FadeOut];
    
    id FadeOut2 = [CCFadeOut actionWithDuration:0.3];
    [Intro1_Logo runAction:FadeOut2];
    
    id CopyDelay = [CCDelayTime actionWithDuration:0.2];
    id CopyFadeIn = [CCFadeIn actionWithDuration:0.5];
    id CopySequence = [CCSequence actions: CopyDelay, CopyFadeIn, nil];
    [Intro2_Copy runAction:CopySequence];
    
    id TomDelay = [CCDelayTime actionWithDuration:0.7];
    id TomIn = [CCMoveTo actionWithDuration:0.5 position:ccp(640,240-ofsetTom)];
    id TomInEase = [CCEaseExponentialOut actionWithAction:TomIn];
    CCAction *TomSequence = [CCSequence actions: TomDelay, TomInEase, nil];
    TomSequence.tag = 715;

    [Intro2_Tom runAction:TomSequence];
    
    //id TomFadeIn = [CCFadeIn actionWithDuration:0.5];
    //[Intro2_Tom runAction:TomFadeIn];
}

- (void) Intro3 {
    
    id FadeOut = [CCFadeOut actionWithDuration:0.3];
    [Intro2_Copy runAction:FadeOut];
    
    id FadeOut2 = [CCFadeOut actionWithDuration:0.3];
    [Intro2_Tom runAction:FadeOut2];
    
    id CopyDelay = [CCDelayTime actionWithDuration:0.2];
    id CopyFadeIn = [CCFadeIn actionWithDuration:0.5];
    id CopySequence = [CCSequence actions: CopyDelay, CopyFadeIn, nil];
    [Intro3_Copy runAction:CopySequence];
    
    id SketchFadeIn = [CCFadeIn actionWithDuration:0.5];
    [Intro3_Sketch runAction:SketchFadeIn];
    
    
    
}



-(void) Intro5 {
    
    id FadeOut = [CCFadeOut actionWithDuration:0.3];
    [Intro4_Copy runAction:FadeOut];
    
    id FadeOut2 = [CCFadeOut actionWithDuration:0.3];
    [Intr04_BabyBody runAction:FadeOut2];
    
    id FadeOut3 = [CCFadeOut actionWithDuration:0.3];
    [Intr04_BabyArm1 runAction:FadeOut3];
    
    id FadeOut4 = [CCFadeOut actionWithDuration:0.3];
    [Intr04_BabyArm2 runAction:FadeOut4];
    
    id FadeOut5 = [CCFadeOut actionWithDuration:0.3];
    [Intr04_iPad runAction:FadeOut5];
    
    id FadeOut6 = [CCFadeOut actionWithDuration:0.3];
    [Intr04_Notes runAction:FadeOut6];
    
    
    
    id CopyDelay = [CCDelayTime actionWithDuration:0.7];
    id CopyFadeIn = [CCFadeIn actionWithDuration:0.5];
    CCAction *CopySequence = [CCSequence actions: CopyDelay, CopyFadeIn, nil];
    CopySequence.tag = 715;
    
    [Intro5_Copy runAction:CopySequence];
    
    
    
    id ClipperDelay = [CCDelayTime actionWithDuration:0.3];
     id ClipperIn = [CCMoveTo actionWithDuration:0.4 position:ccp(622,477-offesetClippers)];
     id ClipperInEase = [CCEaseExponentialOut actionWithAction:ClipperIn];
     CCAction *ClipperSequence = [CCSequence actions: ClipperDelay, ClipperInEase, nil];
     ClipperSequence.tag = 715;
     
     [Intro3_Clipper runAction:ClipperSequence];
     
     //id ClipperFadeIn = [CCFadeIn actionWithDuration:0.5];
     // [Intro3_Clipper runAction:ClipperFadeIn];
     
     id PackDelay = [CCDelayTime actionWithDuration:0.4];
     id PackIn = [CCMoveTo actionWithDuration:0.4 position:ccp(174,384)];
     id PackInEase = [CCEaseExponentialOut actionWithAction:PackIn];
     CCAction *PackSequence = [CCSequence actions: PackDelay, PackInEase, nil];
     PackSequence.tag = 715;
     
     [Intro3_Packaging runAction:PackSequence];
     
     //id PackagingFadeIn = [CCFadeIn actionWithDuration:0.5];
     //[Intro3_Packaging runAction:PackagingFadeIn];
    
    id HomeDelay = [CCDelayTime actionWithDuration:6.0];
    id LoadHome = [CCCallFunc actionWithTarget:self selector:@selector(IntroHome)];
    CCAction *HomeSequence = [CCSequence actions: HomeDelay, LoadHome, nil];
    HomeSequence.tag = 715;
    
    [self runAction:HomeSequence];
    

}

-(void)ArmsWave {
    
    Intr04_BabyArm1.anchorPoint = ccp(1,1);
    Intr04_BabyArm2.anchorPoint = ccp(0,1);
    
    id Baby1Delay = [CCDelayTime actionWithDuration:0.1];
    id Baby1WaveUp = [CCRotateTo actionWithDuration:0.1 angle:-20];
    id Baby1WaveDown = [CCRotateTo actionWithDuration:0.1 angle:20];
    
    id Baby1WaveUpEase = [CCEaseExponentialOut actionWithAction:Baby1WaveUp];
    id Baby1WaveDownEase = [CCEaseExponentialOut actionWithAction:Baby1WaveDown];
    
    CCSequence *Baby1Sequence = [CCSequence actions: Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase, Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase, Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase, Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase, Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase, Baby1Delay, Baby1WaveUpEase, Baby1Delay, Baby1WaveDownEase,   nil];
    
    Baby1Sequence.tag = 715;

    
    id Baby2Delay = [CCDelayTime actionWithDuration:0.1];
    id Baby2WaveUp = [CCRotateTo actionWithDuration:0.1 angle:20];
    id Baby2WaveDown = [CCRotateTo actionWithDuration:0.1 angle:-20];
    
    id Baby2WaveUpEase = [CCEaseExponentialOut actionWithAction:Baby2WaveUp];
    id Baby2WaveDownEase = [CCEaseExponentialOut actionWithAction:Baby2WaveDown];
    
    CCSequence *Baby2Sequence = [CCSequence actions: Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase,Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase, Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase,Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase,   Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase,Baby2Delay, Baby2WaveUpEase, Baby2Delay, Baby2WaveDownEase,   nil];
    
    Baby2Sequence.tag = 715;    

    [Intr04_BabyArm1 runAction:Baby1Sequence];
    [Intr04_BabyArm2 runAction:Baby2Sequence];

    
}

-(void)iPadOn {
    
    [Intr04_iPad setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_iPad_02.png"]];

}

-(void) Note0 {
    Intr04_Notes.opacity = 255;
}
-(void)Note1 {
    [Intr04_Notes setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_Notes_02.png"]];
}
-(void)Note2 {
    [Intr04_Notes setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_Notes_03.png"]];
    
    [Intr04_BabyBody setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_BabyBody_02.png"]];

}
-(void)Note3 {
    [Intr04_Notes setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_Notes_04.png"]];
}
-(void)Note4 {
    [Intr04_Notes setTexture:[[CCTextureCache sharedTextureCache] addImage:@"INTRO_04_Notes_05.png"]];
}

-(void) Notes {
    id NotesPAUSE = [CCDelayTime actionWithDuration:0.1];
    id NotesPAUSE2 = [CCDelayTime actionWithDuration:3.5];
    id Notes0 = [CCCallFunc actionWithTarget:self selector:@selector(Note0)];
    id Notes1 = [CCCallFunc actionWithTarget:self selector:@selector(Note1)];
    id Notes2 = [CCCallFunc actionWithTarget:self selector:@selector(Note2)];
    id Notes3 = [CCCallFunc actionWithTarget:self selector:@selector(Note3)];
    id Notes4 = [CCCallFunc actionWithTarget:self selector:@selector(Note4)];
    id LoadHome = [CCCallFunc actionWithTarget:self selector:@selector(Intro5)];

    
    CCSequence *Intro4Sequence = [CCSequence actions: Notes0, NotesPAUSE, Notes1, NotesPAUSE, Notes2, NotesPAUSE, Notes3, NotesPAUSE, Notes4, NotesPAUSE2, LoadHome, nil];
    
    Intro4Sequence.tag = 715;
    
    [self runAction:Intro4Sequence];
    
}
- (void) Intro4 {
    
    id FadeOut = [CCFadeOut actionWithDuration:0.3];
    [Intro3_Copy runAction:FadeOut];

    //id FadeOut1 = [CCFadeOut actionWithDuration:0.3];
    //[Intro3_Clipper runAction:FadeOut1];
    
    //id FadeOut2 = [CCFadeOut actionWithDuration:0.3];
    //[Intro3_Packaging runAction:FadeOut2];
    
    id FadeOut3 = [CCFadeOut actionWithDuration:0.3];
    [Intro3_Sketch runAction:FadeOut3];
    
    
    id CopyDelay = [CCDelayTime actionWithDuration:0.2];
    id CopyFadeIn = [CCFadeIn actionWithDuration:0.5];
    id CopySequence = [CCSequence actions: CopyDelay, CopyFadeIn, nil];
    [Intro4_Copy runAction:CopySequence];
    
    
    id BabyDelay = [CCDelayTime actionWithDuration:0.3];
    id BabyIn = [CCMoveTo actionWithDuration:0.5 position:ccp(700,240+offset)];
    id BabyInEase = [CCEaseExponentialOut actionWithAction:BabyIn];
    CCAction *BabySequence = [CCSequence actions: BabyDelay, BabyInEase, nil];
    BabySequence.tag = 715;
    [Intr04_BabyBody runAction:BabySequence];
    
    id ArmDelay = [CCDelayTime actionWithDuration:0.8];
    id ArmsWave = [CCCallFunc actionWithTarget:self selector:@selector(ArmsWave)];
    id ArmSequence = [CCSequence actions: ArmDelay, ArmsWave, nil];
    [self runAction:ArmSequence];
    
    //id BabyFadeIn = [CCFadeIn actionWithDuration:0.5];
    //[Intr04_BabyBody runAction:BabyFadeIn];
    
    id Arm1Delay = [CCDelayTime actionWithDuration:0.3];
    id Arm1In = [CCMoveTo actionWithDuration:0.5 position:ccp(676,200+offset)];
    id Arm1InEase = [CCEaseExponentialOut actionWithAction:Arm1In];
    CCAction *Arm1Sequence = [CCSequence actions: Arm1Delay, Arm1InEase, nil];
    Arm1Sequence.tag = 715;
    [Intr04_BabyArm1 runAction:Arm1Sequence];
    
    //id Arm1FadeIn = [CCFadeIn actionWithDuration:0.5];
    //[Intr04_BabyArm1 runAction:Arm1FadeIn];
    
    id Arm2Delay = [CCDelayTime actionWithDuration:0.3];
    id Arm2In = [CCMoveTo actionWithDuration:0.5 position:ccp(726,200+offset)];
    id Arm2InEase = [CCEaseExponentialOut actionWithAction:Arm2In];
    CCAction *Arm2Sequence = [CCSequence actions: Arm2Delay, Arm2InEase, nil];
    Arm2Sequence.tag = 715;
    [Intr04_BabyArm2 runAction:Arm2Sequence];
    
    //id Arm2FadeIn = [CCFadeIn actionWithDuration:0.5];
    //[Intr04_BabyArm2 runAction:Arm2FadeIn];
    
    id iPadDelay = [CCDelayTime actionWithDuration:0.3];
    id iPadIn = [CCMoveTo actionWithDuration:0.5 position:ccp(270,230+offsetInfo)];
    id iPadInEase = [CCEaseExponentialOut actionWithAction:iPadIn];
    CCAction *iPadSequence = [CCSequence actions: iPadDelay, iPadInEase, nil];
    iPadSequence.tag = 715;
    [Intr04_iPad runAction:iPadSequence];
    
    
    id IntroPAUSE1 = [CCDelayTime actionWithDuration:2.5];
    id IntroPAUSE2 = [CCDelayTime actionWithDuration:1.0];
    id iPadOn = [CCCallFunc actionWithTarget:self selector:@selector(iPadOn)];
    id Notes = [CCCallFunc actionWithTarget:self selector:@selector(Notes)];

    CCSequence *Intro4Sequence = [CCSequence actions: IntroPAUSE1, iPadOn, IntroPAUSE2, Notes,  nil];
    Intro4Sequence.tag = 715;
    
    [self runAction:Intro4Sequence];
    
}








// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    ////CCLOG(@"Avert dealloc");
    ////NSLog(@"rc: %d", [Advert retainCount]);
    
    
    [UkeLoop release];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"plop3.mp3"];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    // don't forget to call "super dealloc"
	[super dealloc];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [[CCDirector sharedDirector] purgeCachedData];
}

@end
