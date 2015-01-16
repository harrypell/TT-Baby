//
//  Cover.m
//  Timmy Tickle Baby
//
//  Created by Harriet Pellereau on 24/05/13
//  Copyright 2013 NIMBLEBEAN LIMITED. All rights reserved.
//

// Import the interfaces
#import "Page1.h"
#import "Cover.h"
#import "SimpleAudioEngine.h"
#import "scene_1AppDelegate.h"
#import "BackgroundSingleton.h"
#import "Globals.h"

#import "Flurry.h"



// HelloWorld implementation
@implementation Cover

/* BLINK REMOVED
@synthesize blink = _blinkC;
@synthesize blinkAction = _blinkActionC;
*/


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Cover *layer = [Cover node];
    
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
        
        // Find out what language we're in!!
        languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;
        dutchID = @"nl";
        // NSLog(@"%@", languageID);
        

        
        
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            offset = 0;
            //blinkOffset = 0;
            infoOffsetBack = 0;
            offsetIcons = 0;
            offsetInfo = 0;
            offesetPlay = 0;
            offsetControl = 0;

            
        }
        
        else {
            offset = 37;
            //blinkOffset = 0.1;
            infoOffsetBack = 5;
            offsetIcons = 30;
            offsetInfo = 22;
            offesetPlay = 30;
            offsetControl = 25;
        }
        

        
        voicePlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] voicePlay];
        noisePlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] noisePlay];
        automaticPlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] automaticPlay];
        introPlayed = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] introPlayed];
        
        
        NSError *activationError = nil;
        BOOL success = [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        
        if (!success) {
            NSLog(@"Audio Session Error");
        }
        
        
        [SimpleAudioEngine initialize];
		[CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_HIGH];
         
        //[[CDAudioManager sharedManager] setMode:kAMM_PlayAndRecord];
        //[[CDAudioManager sharedManager] setResignBehavior: kAMRBStop  autoHandle:YES];


		
        [CDAudioManager sharedManager].backgroundMusic.volume = 0.4f;
        
        [Flurry logEvent:@"COVER" timed:YES];
                
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        CCLOG(@"Cover Init Start Ignoring");

        [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"orangeBgStart.jpg"];
        
        if (!introPlayed) {
            
        // ADD WAVE VIDEO
        AVPlayer *avplayer_wave = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"m4v"]]];
            
        avplayerlayer_wave = [AVPlayerLayer playerLayerWithPlayer:avplayer_wave];
        [avplayer_wave release];
            
        avplayerlayer_wave.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_wave];
            
        // WAVE VIDEO DID END NOTIFICATION
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(waveDidEnd)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:[avplayerlayer_wave.player currentItem]];
            
        }

        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

        
        //Creat title
		title = [CCSprite spriteWithFile:@"title.png"];
		title.position = ccp(164, 620-offset);
        [title.texture setAntiAliasTexParameters];
		title.opacity = 0;
		[self addChild:title  z:10];
        
   
        
        // Continue?
        
        swipe = [CCSprite spriteWithFile:@"swipe_left.png"];
        swipe.position = ccp(size.width / 2, size.height / 2);
        [swipe.texture setAntiAliasTexParameters];
		[self addChild:swipe z:200];
		swipe.opacity = 0;
        
        
        dark1 = [CCSprite spriteWithFile:@"blackcredit.png"];
        dark1.scale = 110;
		dark1.position = ccp(size.width / 2, size.height / 2);
		[self addChild:dark1 z:199];
		dark1.opacity = 0;
        
        
        /*
        
		//Blink Action TURNED OFF
		
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
		 @"orangeblink.plist"];
		
		blinkSheet = [CCSpriteBatchNode
                      batchNodeWithFile:@"orangeblink.png"];
		[self addChild:blinkSheet];
		
		NSMutableArray *blinkAnimFrames = [NSMutableArray array];
		for(int i = 1; i <= 7; ++i) {
			[blinkAnimFrames addObject:
			 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
			  [NSString stringWithFormat:@"orange%d.png", i]]];
		}
		
		CCAnimation *blinkAnim = [CCAnimation
								  animationWithFrames:blinkAnimFrames delay:0.05f];
		
		
		self.blink = [CCSprite spriteWithSpriteFrameName:@"orange1.png"];
        _blinkC.position = ccp(517-blinkOffset,485);
		
		id delay = [CCDelayTime actionWithDuration:6];
		self.blinkAction = [CCAnimate actionWithAnimation:blinkAnim restoreOriginalFrame:NO];
		
		id blinkDelay = [CCRepeatForever actionWithAction:
						 [CCSequence actions: delay, _blinkActionC, nil]];
		
		[_blinkC runAction:blinkDelay];
		[blinkSheet addChild:_blinkC];
        
        _blinkC.opacity = 0;
         
         */
        
		
		
		// Play BUTTON
        
        CCMenuItemImage *play1 = [CCMenuItemImage itemFromNormalImage:@"Cover_Play.png" selectedImage:@"Cover_Play_On.png"
                                                               target:self selector:@selector(STARTPLAYING)];
        
        
        
		PLAYGO = [CCMenu menuWithItems:play1, nil];
		PLAYGO.position = ccp(1400, 562-offesetPlay);
        
        [PLAYGO setOpacity: 255];
        [self addChild:PLAYGO z:20];
		
        
        
        
        // Nipper Clipper BUTTON
        
        CCMenuItemImage *nipper1 = [CCMenuItemImage itemFromNormalImage:@"NipperClipper.png" selectedImage:@"NipperClipper_Press.png"
                                                                 target:self selector:@selector(InfoSwipeTest)];
        
        
        
		NipperClipperGo = [CCMenu menuWithItems:nipper1, nil];
		NipperClipperGo.position = ccp(702, -300+offsetIcons);
        
        [NipperClipperGo setOpacity: 255];
        [self addChild:NipperClipperGo z:20];


		
        
        // Hello BUTTON
        
        CCMenuItemImage *hello1 = [CCMenuItemImage itemFromNormalImage:@"Hello.png" selectedImage:@"Hello_Press.png"
                                                                target:self selector:@selector(HelloSwipeTest)];
        
        
        
		HelloGo = [CCMenu menuWithItems:hello1, nil];
		HelloGo.position = ccp(214, -300+offsetIcons);
        
        [HelloGo setOpacity: 255];
        [self addChild:HelloGo z:20];
        
  
        
        // INFO
        
        Info = [CCSprite spriteWithFile:@"Intructions.jpg"];
        Info.position = ccp(size.width / 2, size.height / 2+offsetInfo);
		[self addChild:Info z:31];
		Info.opacity = 0;
        
        
        // INFO BUTTON


        
        
        
        // LOAD SPRITESHEET
        
        CCSprite *backButton = [CCSprite spriteWithFile:@"BackButton.png"];
        [[backButton texture] setAntiAliasTexParameters];
        
            
        CCSprite *downButton = [CCSprite spriteWithFile:@"BackButton_Dn.png"];
        [[downButton texture] setAntiAliasTexParameters];

        
        CCMenuItemImage *backItems = [CCMenuItemSprite itemFromNormalSprite:backButton selectedSprite:downButton
                                                                     target:self
                                                                   selector:@selector(BACKTOCOVER:)];
        InfoBack = [CCMenu menuWithItems:backItems, nil];



        InfoBack.position = ccp(1465,65+infoOffsetBack);
        
        [InfoBack setOpacity: 0];
		[self addChild:InfoBack z:100];


        [[SimpleAudioEngine sharedEngine] preloadEffect:@"plop3.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Laugh1.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Laugh2.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Laugh3.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Laugh4.mp3"];
        
        
        infoVisible = NO;
        HELLO = NO;
        CONTROL = NO;
        
    
        
        
	}
	return self;
}


-(void)BACKTOCOVER:(id)sender;
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
    
    //_blinkC.opacity = 255;
    
    Info.opacity = 0;
    //
    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Intructions.jpg"]];
    
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Apps_1.jpg"];
    
 
    
    //HelloPage.opacity = 0;
    
    NipperClipperGo.position = ccp(702, 97+offset);
    HelloGo.position = ccp(214, 97+offset);
    PLAYGO.position = ccp(830, 562-offesetPlay);
    
    
    InfoBack.position = ccp(1464,65+infoOffsetBack);
    InfoBack.opacity = 0;
    
    infoVisible = NO;
    HELLO = NO;
    
    
    
}




-(void)fadeTextAudioIn
{
    if (UkeLoop.volume < 0.4) {
        UkeLoop.volume = UkeLoop.volume + 0.1;
        [self performSelector:@selector(fadeTextAudioIn) withObject:nil afterDelay:0.1];
    } else {
        UkeLoop.volume = 0.4;
    }
}



- (void) touchenabled {
    CCLOG(@"Cover Init Stop Ignoring");
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    self.isTouchEnabled = YES;
    
    
}

- (void) playwave {
    
    [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setIntroPlayed:YES];
    
    [avplayerlayer_wave.player play];
}




-(void)doVolumeFadeMainOut
{
    if (UkeLoop.volume > 0.1) {
        UkeLoop.volume = UkeLoop.volume - 0.1;
        [self performSelector:@selector(doVolumeFadeMainOut) withObject:nil afterDelay:0.1];
    } else {
        [UkeLoop stop];
    }
}



- (void)startHome {
        
    CCLOG(@"START HOME");
        
    id titleFadeIn = [CCFadeIn actionWithDuration:0.5];
    [title runAction:titleFadeIn];
    
    id PlayDelay = [CCDelayTime actionWithDuration:0.4];
    id PlayGOIn = [CCMoveTo actionWithDuration:0.4 position:ccp(830,562-offesetPlay)];
    id PlayGOInEase = [CCEaseExponentialOut actionWithAction:PlayGOIn];
    id PlaySequence = [CCSequence actions: PlayDelay, PlayGOInEase, nil];
    PLAYGO.anchorPoint = ccp(0.0f, 0.0f);
    
    [PLAYGO runAction:PlaySequence];
    
    id NipperDelay = [CCDelayTime actionWithDuration:0.6];
    id NipperGOIn = [CCMoveTo actionWithDuration:0.4 position:ccp(702,97+offsetIcons)];
    id NipperGOInEase = [CCEaseExponentialOut actionWithAction:NipperGOIn];
    id NipperSequence = [CCSequence actions: NipperDelay, NipperGOInEase, nil];
    [NipperClipperGo runAction:NipperSequence];
    
    
    
    id HelloDelay = [CCDelayTime actionWithDuration:0.8];
    id HelloGOIn = [CCMoveTo actionWithDuration:0.4 position:ccp(214,97+offsetIcons)];
    id HelloGOInEase = [CCEaseExponentialOut actionWithAction:HelloGOIn];
    id HelloSequence = [CCSequence actions: HelloDelay, HelloGOInEase, nil];
    [HelloGo runAction:HelloSequence];
    

    if (!introPlayed) {
     id WaveDelay = [CCDelayTime actionWithDuration:1.2];
     id WavePlay = [CCCallFunc actionWithTarget:self selector:@selector(playwave)];
     id WaveSequence = [CCSequence actions: WaveDelay, WavePlay, nil];
     [self runAction:WaveSequence];
    }
    
    //[super onEnterTransitionDidFinish];
    
    id autoPlayactionDelay = [CCDelayTime actionWithDuration:2.2];
    id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(iconthrob)];
    CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    [self runAction:autoPlaySequence];
    
}


- (void) onEnterTransitionDidFinish {
        
        [self playAudioNamed:@"ukulele"];

        id TouchDelay = [CCDelayTime actionWithDuration:1.0];
        id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
        CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
        [self runAction:TouchSequence];
    
        NSError *setCategoryError = nil;
        BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
        if (!success) {
            NSLog(@"Audio Session Error");
        }
            NSLog(@"Audio Session Reconfigured");
    
        
        [self startHome];
    
    

    
        [super onEnterTransitionDidFinish];
    
}

- (void) iconthrob {
    
    id scaleUpAction =  [CCScaleTo actionWithDuration:4.0 scaleX:0.85 scaleY:0.9];
    id scaleDownAction = [CCScaleTo actionWithDuration:4.0 scaleX:1.0 scaleY:1.0];
    
    
    id PlaySequence = [CCSequence actions: scaleUpAction, scaleDownAction, nil];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:PlaySequence];
    
    [PLAYGO runAction:repeat];
}


- (void)STARTPLAYING {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    id touchDelay = [CCDelayTime actionWithDuration:0.2];
    id touchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
    CCSequence *touchSequence = [CCSequence actions: touchDelay, touchPlay, nil];
    touchSequence.tag = 124;
    [self runAction:touchSequence];
    
    CONTROL = YES;
    
    NipperClipperGo.position = ccp(-20000, -30000+offset);
    HelloGo.position = ccp(-20000, -30000+offset);
    PLAYGO.position = ccp(20000, -30000+offset);
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh4.mp3"];
    
    CCLOG(@"CONTROL = YES");
    
    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Control.jpg"]];
    
    CGSize size = [[CCDirector sharedDirector] winSize];

    Info.position = ccp(size.width / 2, size.height / 2+offsetControl);
    Info.opacity = 255;
    
    //id autoPlayactionDelay = [CCDelayTime actionWithDuration:0.5];
    //id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(removewave)];
    //CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    //autoPlaySequence.tag = 124;
    //[self runAction:autoPlaySequence];
    

    
}



- (void) nextScene {
    
    [[CCDirector sharedDirector]replaceScene:[Page1 scene]];
}


- (void)Start {
    
    if (infoVisible) {
        return;
    }
    
    if (!infoVisible) {
        
        [self doVolumeFadeMainOut];
        
        if (!introPlayed) {
        
        // REMOVE WAVE VIDEO
        if (avplayerlayer_wave) {
            [avplayerlayer_wave removeFromSuperlayer];
            avplayerlayer_wave = nil;
        }
        }
        
        
        
        id autoPlayactionDelay = [CCDelayTime actionWithDuration:1.5];
        id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(nextScene)];
        CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
        autoPlaySequence.tag = 124;
        [self runAction:autoPlaySequence];
        
    }
}





- (void) InfoSwipeTest {
    
    if (!CONTROL) {
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
    
    INFOSWIPE = YES;
        
        CCLOG(@"INFOSWIPE = YES");

    
    srandom(time(NULL));
    NSUInteger newState = (CCRANDOM_0_1() * 4) + 0.5;
    switch (newState) {
        case kSwipeLeft:
            swipeLeft = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_left.png"]];
            break;
        case kSwipeRight:
            swipeRight = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_right.png"]];
            break;
        case kSwipeUp:
            swipeUp = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_up.png"]];
            break;
        case kSwipeDown:
            swipeDown = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_down.png"]];
            break;
        default:
            swipeLeft = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_left.png"]];
            break;
    }
    
    
    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Intructions.jpg"]];
    
    Info.opacity   = 255;
    
    swipe.opacity = 255;
    id fadein = [CCFadeIn actionWithDuration:0.2];
    [dark1 runAction:fadein];
    
    NipperClipperGo.position = ccp(2000, -3000+offset);
    HelloGo.position = ccp(2000, -3000+offset);
    PLAYGO.position = ccp(2000, -3000+offset);
    }
}



- (void) NipperClipper {
    
    infoVisible = YES;
    
    aminfo1 = YES;
    
    //Info.opacity = 255;
    
    
    //_blinkC.opacity = 0;
    
    // MOVE BACK BUTTON ONSTAGE
    
    
    id InfoBackDelay = [CCDelayTime actionWithDuration:0.1];
    id InfoBackOn = [CCMoveTo actionWithDuration:0.0 position:ccp(171,665+infoOffsetBack)];
    id InfoBackUpEase = [CCEaseExponentialOut actionWithAction:InfoBackOn];
    id InfoBackFadeOn = [CCFadeIn actionWithDuration:0.3];
    
    id InfoBackALL = [CCSequence actions: InfoBackDelay, InfoBackUpEase, InfoBackFadeOn, nil];
    
    [InfoBack runAction:InfoBackALL];
    
    
}




- (void) HelloSwipeTest {
    
    if (!CONTROL) {
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
    
    MORESWIPE = YES;
    
    CCLOG(@"MORESWIPE = YES");

    
    srandom(time(NULL));
    NSUInteger newState = (CCRANDOM_0_1() * 4) + 0.5;
    switch (newState) {
        case kSwipeLeft:
            swipeLeft = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_left.png"]];
            break;
        case kSwipeRight:
            swipeRight = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_right.png"]];
            break;
        case kSwipeUp:
            swipeUp = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_up.png"]];
            break;
        case kSwipeDown:
            swipeDown = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_down.png"]];
            break;
        default:
            swipeLeft = YES;
            [swipe setTexture:[[CCTextureCache sharedTextureCache] addImage:@"swipe_left.png"]];
            break;
    }
    
    
    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Apps_1.jpg"]];
    
    Info.opacity   = 255;
    
    swipe.opacity = 255;
    id fadein = [CCFadeIn actionWithDuration:0.2];
    [dark1 runAction:fadein];
    
    NipperClipperGo.position = ccp(2000, -3000+offset);
    HelloGo.position = ccp(2000, -3000+offset);
    PLAYGO.position = ccp(2000, -3000+offset);
    }
    
}


- (void) Hello {
    
    //_blinkC.opacity = 0;
    
    //HelloPage.opacity = 255;
    
    HELLO = YES;
    
    CCLOG(@"HELLO = YES");
    
    
    // MOVE BACK BUTTON ONSTAGE
    
    
    id InfoBackDelay = [CCDelayTime actionWithDuration:0.3];
    id InfoBackOn = [CCMoveTo actionWithDuration:0.0 position:ccp(171,670+infoOffsetBack)];
    id InfoBackUpEase = [CCEaseExponentialOut actionWithAction:InfoBackOn];
    id InfoBackFadeOn = [CCFadeIn actionWithDuration:0.2];
    
    id InfoBackALL = [CCSequence actions: InfoBackDelay, InfoBackUpEase, InfoBackFadeOn, nil];
    
    [InfoBack runAction:InfoBackALL];
    
    
    
}


// handles touch in the video area - start video on touch in area

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!CONTROL) {
        
        CCLOG(@"TOUCHES BEGAN SWIPE");
        
    if(swipeLeft || swipeRight || swipeUp || swipeDown) {
        NSSet *allTouches = [event allTouches];
        UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        //Swipe Detection Part 1
        firstTouch = location;
        
        }
    }
	
    //CCLOG(@"Cover %@", NSStringFromSelector(_cmd));
    
    
    
    if (HELLO && !CONTROL) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        CGRect BUY = CGRectMake(94,78,219,118);
        
        if (CGRectContainsPoint(BUY, location)) {
            
            CCLOG(@"BUY");
            
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nimblebean.com/TimmyTickleBaby_iPAD.html"]];
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [Flurry logEvent:@"BUY iPAD"];
                
                /*
                 NSString *iTunesLink = @"http://itunes.apple.com/gb/timmy-tickle/id448479949?mt=8";
                 
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
                 */
                
                
            } else {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nimblebean.com/TimmyTickleBaby_iPHONE.html"]];
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [Flurry logEvent:@"BUY iPHONE"];
            }
        }
    }
     
    if (infoVisible && !CONTROL) {
        
        CCLOG(@"INTFO");

        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        CGRect SLIDE1 = CGRectMake(293,606,113,113);
        CGRect SLIDE2 = CGRectMake(403,606,113,113);
        CGRect SLIDE3 = CGRectMake(519,606,113,113);
        CGRect SLIDE4 = CGRectMake(632,606,113,113);
        CGRect SLIDE5 = CGRectMake(745,606,113,113);
        CGRect SLIDE6 = CGRectMake(858,606,113,113);
        

        
        if (aminfo1) {
            
            CGRect BUY = CGRectMake(600, 386, 290, 175);
            CGRect NEXT = CGRectMake(278, 386, 290, 175);
            
            
            if (CGRectContainsPoint(BUY, location)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nimblebean.com/Timmy_Tickle_Baby_BuyClipper.html"]];
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [Flurry logEvent:@"BUY NIPPER CLIPPER LINK"];
            }
            
            if (CGRectContainsPoint(NEXT, location)) {
                
                NSLog(@"Instructions_2");
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                
                id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                [self runAction:TouchSequence];
                
                [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_2.jpg"]];
                
                [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Intructions.jpg"];
                //[[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
                [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
                [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
                [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
                [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
                
                aminfo1 = NO;
                aminfo2 = YES;
                aminfo3 = NO;
                aminfo4 = NO;
                aminfo5 = NO;
                aminfo6 = NO;
            }
        } else if (!aminfo1) {
            CGRect NEXT2 = CGRectMake(91,80,841,506);
            
            if (aminfo2) {
                if (CGRectContainsPoint(NEXT2, location)) {
                    
                    NSLog(@"Instructions_3");
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                    
                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                    
                    id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                    [self runAction:TouchSequence];
                    
                    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_3.jpg"]];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Intructions.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
                    //[[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
                    
                    aminfo1 = NO;
                    aminfo2 = NO;
                    aminfo3 = YES;
                    aminfo4 = NO;
                    aminfo5 = NO;
                    aminfo6 = NO;
                }
            } else if (aminfo3) {
                if (CGRectContainsPoint(NEXT2, location)) {
                    
                    NSLog(@"Instructions_4");
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                    
                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                    
                    id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                    [self runAction:TouchSequence];
                    
                    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_4.jpg"]];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Intructions.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
                    //[[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
                    
                    aminfo1 = NO;
                    aminfo2 = NO;
                    aminfo3 = NO;
                    aminfo4 = YES;
                    aminfo5 = NO;
                    aminfo6 = NO;
                }
            } else if (aminfo4) {
                if (CGRectContainsPoint(NEXT2, location)) {
                    
                    NSLog(@"Instructions_5");
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                    
                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                    
                    id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                    [self runAction:TouchSequence];
                    
                    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_5.jpg"]];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Intructions.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
                    //[[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
                    
                    aminfo1 = NO;
                    aminfo2 = NO;
                    aminfo3 = NO;
                    aminfo4 = NO;
                    aminfo5 = YES;
                    aminfo6 = NO;
                }
            } else if (aminfo5) {
                if (CGRectContainsPoint(NEXT2, location)) {
                    
                    NSLog(@"Instructions_6");
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                    
                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                    
                    id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                    [self runAction:TouchSequence];
                    
                    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_6.jpg"]];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Intructions.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_2.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_3.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_4.jpg"];
                    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_5.jpg"];
                    //[[CCTextureCache sharedTextureCache] removeTextureForKey:@"Instructions_6.jpg"];
                    
                    aminfo1 = NO;
                    aminfo2 = NO;
                    aminfo3 = NO;
                    aminfo4 = NO;
                    aminfo5 = NO;
                    aminfo6 = YES;
                }
            }  else if (aminfo6) {
                if (CGRectContainsPoint(NEXT2, location)) {
                    
                    NSLog(@"Instructions");
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                    
                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                    
                    id TouchDelay = [CCDelayTime actionWithDuration:0.1];
                    id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
                    CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
                    [self runAction:TouchSequence];
                    
                    [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Intructions.jpg"]];
                    
                    aminfo1 = YES;
                    aminfo2 = NO;
                    aminfo3 = NO;
                    aminfo4 = NO;
                    aminfo5 = NO;
                    aminfo6 = NO;
                }
            }
            
            
        }
        
        
        
        
        
        
        
        
        if (CGRectContainsPoint(SLIDE1, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Intructions.jpg"]];
            
            aminfo1 = YES;
            aminfo2 = NO;
            aminfo3 = NO;
            aminfo4 = NO;
            aminfo5 = NO;
            aminfo6 = NO;
            
            
        } else if (CGRectContainsPoint(SLIDE2, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_2.jpg"]];
            
            aminfo1 = NO;
            aminfo2 = YES;
            aminfo3 = NO;
            aminfo4 = NO;
            aminfo5 = NO;
            aminfo6 = NO;
            
        } else if (CGRectContainsPoint(SLIDE3, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_3.jpg"]];
            
            aminfo1 = NO;
            aminfo2 = NO;
            aminfo3 = YES;
            aminfo4 = NO;
            aminfo5 = NO;
            aminfo6 = NO;
            
        } else if (CGRectContainsPoint(SLIDE4, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_4.jpg"]];
            
            aminfo1 = NO;
            aminfo2 = NO;
            aminfo3 = NO;
            aminfo4 = YES;
            aminfo5 = NO;
            aminfo6 = NO;
            
        } else if (CGRectContainsPoint(SLIDE5, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_5.jpg"]];
            
            aminfo1 = NO;
            aminfo2 = NO;
            aminfo3 = NO;
            aminfo4 = NO;
            aminfo5 = YES;
            aminfo6 = NO;
            
        } else if (CGRectContainsPoint(SLIDE6, location)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            id TouchDelay = [CCDelayTime actionWithDuration:0.1];
            id TouchPlay = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
            CCSequence *TouchSequence = [CCSequence actions: TouchDelay, TouchPlay, nil];
            [self runAction:TouchSequence];
            
            [Info setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Instructions_6.jpg"]];
            
            aminfo1 = NO;
            aminfo2 = NO;
            aminfo3 = NO;
            aminfo4 = NO;
            aminfo5 = NO;
            aminfo6 = YES;
            
        }
        
    }
    
    
    if (CONTROL) {
        // work out where the touch point was
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        // create some rectangles which are the touch sensitive areas
        
        
        if ([languageID isEqualToString:languageID]) {
            
            CCLOG(@"NL = YES");
            CGRect BOX1 = CGRectMake(0,0,512,767);
            CGRect BOX2 = CGRectMake(512,0,512,767);
           
            if (CGRectContainsPoint(BOX1, location)) {
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh1.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                CCLOG(@"Cover Readtome Touch Disabled");
                
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setAutomaticPlay:YES];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setNoisePlay:NO];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setVoicePlay:NO];
                
                [Flurry logEvent:@"AUTO CONTROL CHOSEN"];
                
                [self Start];
                
                
            } else if (CGRectContainsPoint(BOX2, location)) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh2.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                CCLOG(@"Cover Readtome Touch Disabled");
                
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setNoisePlay:YES];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setVoicePlay:NO];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setAutomaticPlay:NO];
                
                [Flurry logEvent:@"SOUND CONTROL CHOSEN"];
                
                [self Start];
                
            }
            
        } else {
            
            CGRect BOX1 = CGRectMake(50,35,295,695);
            CGRect BOX2 = CGRectMake(372,35,295,695);
            CGRect BOX3 = CGRectMake(690,35,295,695);
            
            if (CGRectContainsPoint(BOX1, location)) {
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh1.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                CCLOG(@"Cover Readtome Touch Disabled");
                
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setAutomaticPlay:YES];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setNoisePlay:NO];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setVoicePlay:NO];
                
                [Flurry logEvent:@"AUTO CONTROL CHOSEN"];
                
                [self Start];
                
                
            } else if (CGRectContainsPoint(BOX2, location)) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh2.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                CCLOG(@"Cover Readtome Touch Disabled");
                
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setNoisePlay:YES];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setVoicePlay:NO];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setAutomaticPlay:NO];
                
                [Flurry logEvent:@"SOUND CONTROL CHOSEN"];
                
                [self Start];
                
            } else if (CGRectContainsPoint(BOX3, location)) {
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"Laugh3.mp3"];
                
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                CCLOG(@"Cover Readtome Touch Disabled");
                
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setVoicePlay:YES];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setNoisePlay:NO];
                [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] setAutomaticPlay:NO];
                
                [Flurry logEvent:@"VOICE CONTROL CHOSEN"];
                
                [self Start];
                
            }

        }
        
    }
    
}


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!CONTROL) {
        
        CCLOG(@"TOUCHES ENDED !CONTROL");

        if (swipeLeft || swipeRight || swipeUp || swipeDown) {
        NSSet *allTouches = [event allTouches];
        UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        //Swipe Detection Part 2
        lastTouch = location;
        
        //Minimum length of the swipe
        float swipeLength = ccpDistance(firstTouch, lastTouch);
        
        if (swipeLeft) {
            
            if (firstTouch.x > lastTouch.x && swipeLength > 30) {
                NSLog(@"Swipe left");
                
                if (MORESWIPE) {
                    MORESWIPE = NO;
                    [self Hello];
                    
                } else if (INFOSWIPE) {
                    INFOSWIPE = NO;
                    [self NipperClipper];
                    
                }
                
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeLeft = NO;
                
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                
                Info.opacity = 0;
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeLeft = NO;
                
                NipperClipperGo.position = ccp(702, 97+offset);
                HelloGo.position = ccp(214, 97+offset);
                PLAYGO.position = ccp(830, 562-offesetPlay);
            }
        } else if (swipeRight) {
            
            if (lastTouch.x > firstTouch.x && swipeLength > 30) {
                
                NSLog(@"Swipe Right");
                if (MORESWIPE) {
                    MORESWIPE = NO;
                    [self Hello];
                    
                } else if (INFOSWIPE) {
                    INFOSWIPE = NO;
                    [self NipperClipper];
                    
                }
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeRight = NO;
                
            }   else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                
                Info.opacity = 0;
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeRight = NO;
                
                NipperClipperGo.position = ccp(702, 97+offset);
                HelloGo.position = ccp(214, 97+offset);
                PLAYGO.position = ccp(830, 562-offesetPlay);
            }
        } else if (swipeUp) {
            
            if (lastTouch.y > firstTouch.y && swipeLength > 30) {
                
                NSLog(@"Swipe Up");
                
                if (MORESWIPE) {
                    MORESWIPE = NO;
                    [self Hello];
                    
                } else if (INFOSWIPE) {
                    INFOSWIPE = NO;
                    [self NipperClipper];
                    
                }
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeUp = NO;
                
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                
                Info.opacity = 0;
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeUp = NO;
                
                NipperClipperGo.position = ccp(702, 97+offset);
                HelloGo.position = ccp(214, 97+offset);
                PLAYGO.position = ccp(830, 562-offesetPlay);
            }
            
        } else if (swipeDown) {
            
            if (firstTouch.y > lastTouch.y && swipeLength > 30) {
                
                NSLog(@"Swipe Down");
                
                if (MORESWIPE) {
                    MORESWIPE = NO;
                    [self Hello];
                    
                } else if (INFOSWIPE) {
                    INFOSWIPE = NO;
                    [self NipperClipper];
                    
                }
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeDown = NO;
                
            } else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"plop3.mp3"];
                
                Info.opacity = 0;
                swipe.opacity = 0;
                id fadeout = [CCFadeOut actionWithDuration:0.2];
                [dark1 runAction:fadeout];
                swipeDown = NO;
                
                NipperClipperGo.position = ccp(702, 97+offset);
                HelloGo.position = ccp(214, 97+offset);
                PLAYGO.position = ccp(830, 562-offesetPlay);
            }
        }
    }
    
    }}



- (void)waveDidEnd
{
    //[self playAudioNamed:@"ukulele"];
}



-(void)playAudioNamed:(NSString*)name
{
    [UkeLoop stop];
    NSString *ukeIRL = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    UkeLoop = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:ukeIRL] error:NULL];
    [UkeLoop prepareToPlay];
    UkeLoop.volume = 0.3;
    UkeLoop.numberOfLoops = -1;
    [UkeLoop play];
}




// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    CCLOG(@"Cover dealloc");
    NSLog(@"rc: %d", [Cover retainCount]);
    
    
    // REMOVE AVPLAYER LAYERS FOR THIS SCENE
    
    if (!introPlayed) {
    
    if (avplayerlayer_wave) {
        [avplayerlayer_wave removeFromSuperlayer];
        avplayerlayer_wave = nil;
    }
    }
    
    
    [UkeLoop release];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"plop3.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Laugh1.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Laugh2.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Laugh3.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Laugh3.mp3"];
    
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    // don't forget to call "super dealloc"
	[super dealloc];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    
    [[CCDirector sharedDirector] purgeCachedData];
}

@end
