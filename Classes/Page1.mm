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
#import "scene_1AppDelegate.h"
//#import "SimpleAudioEngine.h"
#import <OpenEars/AudioSessionManager.h>

#import "BackgroundSingleton.h"

#import "Flurry.h"


//ALuint soundEffectID;


enum {
	kTagBatchNode = 555,
	kTagBatchNode2 = 666,
};

@implementation Page1


@synthesize pocketsphinxController, openEarsEventsObserver;



+(id) scene
{
	// ’scene’ is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// ’layer’ is an autorelease object.
	Page1 *layer = [Page1 node];
	//menuFrame *menulayer = [menuFrame node];
	
	
	// add layer as a child to scene
	[scene addChild: layer];
	//[scene addChild: menulayer];
	
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        

        
        NSError *activationError = nil;
        BOOL success = [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        
        if (!success) {
            NSLog(@"Audio Session Error");
        }
        
        
        NSLog(@"Got to here 1");
        
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        voicePlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] voicePlay];
        noisePlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] noisePlay];
        automaticPlay = [(scene_1AppDelegate *)[[UIApplication sharedApplication] delegate] automaticPlay];
        
        
        ///iPHONE IPAD////
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            offsetText = 0;
            offsetLetterx = 0;
            offsetLettery = 0;
            offsetMic = 0;
            offsetBox2D = -1.5;
        }
        
        else {
            offsetText = 0;
            offsetLetterx = 0;
            offsetLettery = -40;
            offsetMic = 42;
            offsetBox2D = 0;
        }
        
        [Flurry logEvent:@"PLAYING PAGE 1" timed:YES];
        
        
        // SSH
        SSh = [CCSprite spriteWithFile:@"Ssh.png"];
        SSh.position = ccp((winSize.width)/2, winSize.height/2+offsetText);
		[self addChild:SSh z:8];
        SSh.opacity = 0;
        
        if (voicePlay || noisePlay)
        {
            SSh.opacity = 255;
            
        }
        
        
        //PRELOAD AUDIO
        
       /* [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-APPLE.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-BANANA.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-COWBOY.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-PIRATE.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-STRAWBERRY.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"HELLO-BABY-VAMPIRE.mp3"];
        */
        
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        
        // SET BACKGROUND IMAGE
        //[[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"orangeBgStart.jpg"];
        
        
        // MENU
        
        
        Menu_Layer1 = [CCSprite spriteWithFile:@"MENU_layer1.png"];
        Menu_Layer1.position = ccp(900, 680-offsetMic);
		[self addChild:Menu_Layer1 z:60];
        Menu_Layer1.anchorPoint = ccp(1.0f,0.5f);
        Menu_Layer1.opacity = 0;
        
        Menu_Layer2 = [CCSprite spriteWithFile:@"MENU_layer2.png"];
        Menu_Layer2.position = ccp(756, 680-offsetMic);
		[self addChild:Menu_Layer2 z:8];
        Menu_Layer2.opacity = 0;
        
        Menu_Layer3 = [CCSprite spriteWithFile:@"MENU_layer3.png"];
        Menu_Layer3.position = ccp(756, 680-offsetMic);
		[self addChild:Menu_Layer3 z:62];
        Menu_Layer3.opacity = 0;
        
        
        
        // MODE
        Mode_Voice = [CCSprite spriteWithFile:@"Conrol_Mic_Icon.png"];
        Mode_Voice.position = ccp(-200, 120+offsetMic);
		[self addChild:Mode_Voice z:8];
        Mode_Voice.opacity = 255;
        
        Mode_Noise = [CCSprite spriteWithFile:@"Conrol_Noise_Icon.png"];
        Mode_Noise.position = ccp(-200, 120+offsetMic);
		[self addChild:Mode_Noise z:8];
        Mode_Noise.opacity = 255;
        
        Mode_Auto = [CCSprite spriteWithFile:@"Conrol_Auto_Icon.png"];
        Mode_Auto.position = ccp(-200, 120+offsetMic);
		[self addChild:Mode_Auto z:8];
        Mode_Auto.opacity = 255;
        
        id ModeIn = [CCMoveTo actionWithDuration:0.5 position:ccp(115,120+offsetMic)];
		id ModeInEase = [CCEaseExponentialOut actionWithAction:ModeIn];
        
        if (automaticPlay) {
            [Mode_Auto runAction:ModeInEase];
        }
        
        Mode_Noise_Listening = [CCSprite spriteWithFile:@"Conrol_Noise_Listening.png"];
        Mode_Noise_Listening.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Noise_Listening z:8];
        Mode_Noise_Listening.opacity = 0;
        
        Mode_Voice_Processing = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Processing.png"];
        Mode_Voice_Processing.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Processing z:8];
        Mode_Voice_Processing.opacity = 0;
        
        Mode_Voice_Apple = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Apple.png"];
        Mode_Voice_Apple.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Apple z:8];
        Mode_Voice_Apple.opacity = 0;
        
        Mode_Voice_Banana = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Banana.png"];
        Mode_Voice_Banana.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Banana z:8];
        Mode_Voice_Banana.opacity = 0;
        
        Mode_Voice_Cowboy = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Cowboy.png"];
        Mode_Voice_Cowboy.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Cowboy z:8];
        Mode_Voice_Cowboy.opacity = 0;
        
        Mode_Voice_Pirate = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Pirate.png"];
        Mode_Voice_Pirate.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Pirate z:8];
        Mode_Voice_Pirate.opacity = 0;
        
        Mode_Voice_Strawberry = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Strawberry.png"];
        Mode_Voice_Strawberry.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Strawberry z:8];
        Mode_Voice_Strawberry.opacity = 0;
        
        Mode_Voice_Vampire = [CCSprite spriteWithFile:@"Conrol_Mic_Icon_Listening_Vampire.png"];
        Mode_Voice_Vampire.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_Voice_Vampire z:8];
        Mode_Voice_Vampire.opacity = 0;
        
        Mode_YES = [CCSprite spriteWithFile:@"YES.png"];
        Mode_YES.position = ccp(115, 120+offsetMic);
		[self addChild:Mode_YES z:8];
        Mode_YES.opacity = 0;
        
        
        
        // TEXT
        Text_Apple = [CCSprite spriteWithFile:@"Text_apple.png"];
        Text_Apple.position = ccp(512, 120+offsetText);
		[self addChild:Text_Apple z:8];
        Text_Apple.opacity = 0;
        
        Text_Strawberry = [CCSprite spriteWithFile:@"Text_strawberry.png"];
        Text_Strawberry.position = ccp(512, 120+offsetText);
		[self addChild:Text_Strawberry z:8];
        Text_Strawberry.opacity = 0;
        
        Text_Banana = [CCSprite spriteWithFile:@"Text_banana.png"];
        Text_Banana.position = ccp(512, 120+offsetText);
		[self addChild:Text_Banana z:8];
        Text_Banana.opacity = 0;
        
        Text_Cowboy = [CCSprite spriteWithFile:@"Text_cowboy.png"];
        Text_Cowboy.position = ccp(512, 120+offsetText);
		[self addChild:Text_Cowboy z:8];
        Text_Cowboy.opacity = 0;
        
        Text_Pirate = [CCSprite spriteWithFile:@"Text_pirate.png"];
        Text_Pirate.position = ccp(512, 120+offsetText);
		[self addChild:Text_Pirate z:8];
        Text_Pirate.opacity = 0;
        
        Text_Vampire = [CCSprite spriteWithFile:@"Text_vampire.png"];
        Text_Vampire.position = ccp(512, 120+offsetText);
		[self addChild:Text_Vampire z:8];
        Text_Vampire.opacity = 0;
        
        
  		
        
        // ADD VIDEO
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AppleIn" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
        avplayerlayer_Animations.hidden = YES;
        [avplayer release];
        
        currentState = kState1;
        
        
        State1Done = NO;
        State2Done = NO;
        State3Done = NO;
        State4Done = NO;
        State5Done = NO;
        State6Done = NO;
        
        
        
        // BOX 2D
        
		// enable accelerometer
		//self.isAccelerometerEnabled = YES;
        
        // Create a world
        b2Vec2 gravity = b2Vec2(0.0f, -25.0f); // SPACE AROUND IPAD
        bool doSleep = true;
        world = new b2World(gravity, doSleep);
        world->SetContinuousPhysics(true);
        
      
        // Define the ground body.
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
        groundBody = world->CreateBody(&groundBodyDef);
		b2PolygonShape groundBox;
        
        // bottom
        //groundBox.SetAsEdge(b2Vec2(0,1.5+offsetBox2D), b2Vec2(winSize.width/PTM_RATIO,1.5+offsetBox2D));
		//groundBody->CreateFixture(&groundBox,0);
		
		// top
		//groundBox.SetAsEdge(b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO), b2Vec2(0,winSize.height/PTM_RATIO));
		//groundBody->CreateFixture(&groundBox,0);
		
		// left
		groundBox.SetAsEdge(b2Vec2(0,900), b2Vec2(0,0));
		groundBody->CreateFixture(&groundBox,0);
		
		// right
		groundBox.SetAsEdge(b2Vec2(winSize.width/PTM_RATIO,0), b2Vec2(winSize.width/PTM_RATIO,900));
		groundBody->CreateFixture(&groundBox,0);
        
        
        
        resetYet = NO;
        
        
       
        
	}
	return self;
}

- (void) onEnterTransitionDidFinish {
    
    id TouchDelay = [CCDelayTime actionWithDuration:1.0];
    id TouchGo = [CCCallFunc actionWithTarget:self selector:@selector(touchenabled)];
    id TouchSequence = [CCSequence actions: TouchDelay, TouchGo, nil];
    [self runAction:TouchSequence];
    
    

    // [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(touchenabled) userInfo:nil repeats:NO];
    
    [super onEnterTransitionDidFinish];
    CCLOG(@"Page ready");
    
    // INTRO
    
    if (voicePlay || noisePlay) {
        
        
        id pocketDelay = [CCDelayTime actionWithDuration:0.6];
        id pocketGo = [CCCallFunc actionWithTarget:self selector:@selector(startPocket)];
        CCSequence *PocketPlaySequence = [CCSequence actions: pocketDelay, pocketGo, nil];
        [self runAction:PocketPlaySequence];
        
        CCLOG(@"Start Pocket");
        
        
        
    } else if (automaticPlay) {
        [self IntroTimmy];
        self.isTouchEnabled = YES;
        
        id MenuDelay = [CCDelayTime actionWithDuration:1.0];
        id MenufadeIn = [CCFadeIn actionWithDuration:0.0];
        id MenuSequence = [CCSequence actions: MenuDelay, MenufadeIn, nil];
        [Menu_Layer2 runAction:MenuSequence];
        

    }
}


-(void) startPocket {

    
    NSString *lmPathALL = [[NSBundle mainBundle] pathForResource:@"Lang_Banana" ofType:@"arpa"];
    NSString *dicPathALL = [[NSBundle mainBundle] pathForResource:@"Lang_Banana" ofType:@"dic"];
    
    //Comment out for Rapid Ears
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:lmPathALL dictionaryAtPath:dicPathALL languageModelIsJSGF:NO];
    
    [self.openEarsEventsObserver setDelegate:self];
    
    pocketsphinxController.secondsOfSilenceToDetect = 1;
    
    CCLOG(@"startPocket Done");
    
    [OpenEarsLogging startOpenEarsLogging];
    
    
    
}


-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY,
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
}


-(void)playAudioNamed:(NSString*)name
{
    [UkeLoop stop];
    NSString *ukeIRL = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    UkeLoop = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:ukeIRL] error:NULL];
    [UkeLoop prepareToPlay];
    UkeLoop.volume = 0.7;
    UkeLoop.numberOfLoops = 0;
    [UkeLoop play];
}






-(void) addNewSpriteWithCoords:(CGPoint)p
{
    
    //CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
    
    batch = (CCSpriteBatchNode*) [self getChildByTag:kTagBatchNode];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
    
    
    if (amApple || amCowboy || amPirate || amStrawberry) {
        
        
        fruitblock = [CCSprite spriteWithBatchNode:batch rect:CGRectMake(200 * idx,200 * idy,200,200)];
        
        
        
    } else if (amBanana || amVampire) {
        
        fruitblock = [CCSprite spriteWithBatchNode:batch rect:CGRectMake(300 * idx,300 * idy,300,300)];
        
    }
    
    [batch addChild:fruitblock];
	fruitblock.position = ccp( p.x, p.y);
    
    
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
    
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	bodyDef.userData = fruitblock;
    
	body = world->CreateBody(&bodyDef);
    
    // Create balloon shape
    
    if (amApple || amCowboy || amPirate || amStrawberry) {
        
        
        b2CircleShape circleShape;
        circleShape.m_radius = 100.0/PTM_RATIO;
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &circleShape;
        
        ballShapeDef.density = 2.0f;
        ballShapeDef.friction = 0.5f;
        ballShapeDef.restitution = 0.9f;
        
        body->CreateFixture(&ballShapeDef);
        
    } else if (amBanana || amVampire) {
        
        
        b2PolygonShape boxShape;
        boxShape.SetAsBox(90.0/PTM_RATIO, 60.0/PTM_RATIO);//These are mid points for our 1m box
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &boxShape;
        
        ballShapeDef.density = 2.0f;
        ballShapeDef.friction = 0.5f;
        ballShapeDef.restitution = 0.9f;
        
        body->CreateFixture(&ballShapeDef);
    }
    
}


-(void) addLetterSpriteWithCoords:(CGPoint)p
{
    
    batch2 = (CCSpriteBatchNode*) [self getChildByTag:kTagBatchNode2];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
    
    letterblock = [CCSprite spriteWithBatchNode:batch2 rect:CGRectMake(200 * idx,200 * idy,200,200)];
    
    
    
    [batch2 addChild:letterblock];
	letterblock.position = ccp( p.x, p.y);
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef2;
	bodyDef2.type = b2_dynamicBody;
    
	bodyDef2.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	bodyDef2.userData = letterblock;
    
	body2 = world->CreateBody(&bodyDef2);
	
    b2CircleShape circleShape2;
    circleShape2.m_radius = 90.0/PTM_RATIO;
    
    b2FixtureDef ballShapeDef2;
    ballShapeDef2.shape = &circleShape2;
    
    ballShapeDef2.density = 2.0f;
    ballShapeDef2.friction = 0.5f;
    ballShapeDef2.restitution = 0.9f;
    
    body2->CreateFixture(&ballShapeDef2);
    
}


-(void) tick:(NSTimer *)sender
{
    
    static float lastTime;
    lastTime += sender.timeInterval;
    
    
    if (amBanana || amVampire) {
        
        if (countfruit < 45) {
            
            if (lastTime > 0.16) {
                
                float x = arc4random() % 1024;
                [self addNewSpriteWithCoords:ccp(x, 968-offsetLettery)];
                
                lastTime = 0;
                
                countfruit += 1;
                
            }
        }
    } else {
        
        if (countfruit < 60) {
            
            if (lastTime > 0.13) {
                
                float x = arc4random() % 1024;
                [self addNewSpriteWithCoords:ccp(x, 968-offsetLettery)];
                
                lastTime = 0;
                
                countfruit += 1;
                
            }
        }
    }
    
    if (countletters < 50) {
        
        if (lastTime > 0.135) {
            
            float x = arc4random() % 1024;
            [self addLetterSpriteWithCoords:ccp(x, 968-offsetLettery)];
            
            lastTime = 0;
            
            countletters += 1;
            
        }
    }
    if (countletters >= 50 && countfruit >= 40 && resetYet == NO) {
        
        [self reset];
        
        resetYet = YES;
    }
    
    
  
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 6;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
    world->Step(1.0f/60.0f, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}
	}
    
}



- (void) dolisten {
    
    dolisten = YES;
    
    //[[CDAudioManager sharedManager] audioSessionResumed];
    
    [[AudioSessionManager sharedAudioSessionManager] startAudioSession];
  
    //[self.pocketsphinxController resumeRecognition];
    
    if (voicePlay) {

    
    if (amApple) {
        
        NSString *lmPathALL = [[NSBundle mainBundle] pathForResource:@"Lang_Apple" ofType:@"arpa"];
        NSString *dicPathALL = [[NSBundle mainBundle] pathForResource:@"Lang_Apple" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathALL
                                                withDictionary:dicPathALL];
        
    } else if (amBanana) {
        
        NSString *lmPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Banana" ofType:@"arpa"];
        NSString *dicPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Banana" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathBanana
                                                withDictionary:dicPathBanana];
    }  else if (amCowboy) {
        
        NSString *lmPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Cowboy" ofType:@"arpa"];
        NSString *dicPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Cowboy" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathBanana
                                                withDictionary:dicPathBanana];
    } else if (amPirate) {
        
        NSString *lmPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Pirate" ofType:@"arpa"];
        NSString *dicPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Pirate" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathBanana
                                                withDictionary:dicPathBanana];
    } else if (amStrawberry) {
        
        NSString *lmPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Strawberry" ofType:@"arpa"];
        NSString *dicPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Strawberry" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathBanana
                                                withDictionary:dicPathBanana];
    } else if (amVampire) {
        
        NSString *lmPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Vampire" ofType:@"arpa"];
        NSString *dicPathBanana = [[NSBundle mainBundle] pathForResource:@"Lang_Vampire" ofType:@"dic"];
        
        [self.pocketsphinxController changeLanguageModelToFile:lmPathBanana
                                                withDictionary:dicPathBanana];
    }
    
    }
    
    [self.pocketsphinxController resumeRecognition];

}



- (void) dontlisten {
    NSLog(@"DONT LISTEN");

    dolisten = NO;
    
    [self.pocketsphinxController suspendRecognition];
    
    //[[CDAudioManager sharedManager] setResignBehavior: kAMRBStop  autoHandle:YES];

}


- (void) PrepareAnimations {
    
    if (avplayerlayer_Animations) {
        [avplayerlayer_Animations removeFromSuperlayer];
        avplayerlayer_Animations = nil;
    }
    
    if (amApple) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"AppleOutAnimation" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    } else if (amBanana) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"BananaOutAnimation" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    } else if (amCowboy) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"CowboyAction" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    } else if (amPirate) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"PirateAction" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    } else if (amStrawberry) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"StrawberryOutAnimation" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    } else if (amVampire) {
        avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"VampireAction" ofType:@"m4v"]]];
        avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
        avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
        [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    }
    
    
}




- (PocketsphinxController *)pocketsphinxController {
	if (pocketsphinxController == nil) {
		pocketsphinxController = [[PocketsphinxController alloc] init];
	}
	return pocketsphinxController;
}

// Lazily allocated OpenEarsEventsObserver.
- (OpenEarsEventsObserver *)openEarsEventsObserver {
	if (openEarsEventsObserver == nil) {
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
	}
	return openEarsEventsObserver;
}



- (void) IntroTimmy {
    NSLog(@"Play Intro");
    
    amIntro = YES;
    
    [self autoprompt];
}




-(void)fadeTextAudioOut
{
    if (UkeLoop.volume > 0.1) {
        UkeLoop.volume = UkeLoop.volume - 0.1;
        [self performSelector:@selector(fadeTextAudioOut) withObject:nil afterDelay:0.1];
    } else {
        UkeLoop.volume = 0;
        //fruitfalling = NO;
        
    }
    
}

/*
-(void)fadeInAudio
{
    
    fruitfalling = YES;
    
    if (UkeLoop.volume < 0.4) {
        UkeLoop.volume = UkeLoop.volume + 0.1;
        [self performSelector:@selector(fadeInAudio) withObject:nil afterDelay:0.1];
    } else {
        UkeLoop.volume = 0.5;
    }
}
 */



-(void) changeTune {
    if (amCowboy) {
        [self playAudioNamed:@"MarchingBand"];
    } else if (amPirate) {
        [self playAudioNamed:@"Pirate"];
    } else if (amVampire) {
        [self playAudioNamed:@"Ukulele2"];
    }
    //[self fadeInAudio];
}




-(void) fadeTextOut {
    if (amApple) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Apple runAction:textfadeOut];
        
    } else if (amBanana) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Banana runAction:textfadeOut];
        
    } else if (amCowboy) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Cowboy runAction:textfadeOut];
        
    }  else if (amPirate) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Pirate runAction:textfadeOut];
        
    } else if (amStrawberry) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Strawberry runAction:textfadeOut];
    }
    else if (amVampire) {
        
        id textfadeOut = [CCFadeOut actionWithDuration:0.3];
        
        [Text_Vampire runAction:textfadeOut];
    }
}

- (void)reset {
    
    id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
    id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(fadeTextAudioOut)];
    CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
    autoPlaySequence2.tag = 124;
    [self runAction:autoPlaySequence2];
    
    id autoPlayactionDelay4 = [CCDelayTime actionWithDuration:3.0];
    id autoPlay4 = [CCCallFunc actionWithTarget:self selector:@selector(fadeTextOut)];
    CCSequence *autoPlaySequence4 = [CCSequence actions: autoPlayactionDelay4, autoPlay4, nil];
    autoPlaySequence4.tag = 124;
    [self runAction:autoPlaySequence4];
    
    
    id autoPlayactionDelay5 = [CCDelayTime actionWithDuration:3.5];
    id autoPlay5 = [CCCallFunc actionWithTarget:self selector:@selector(AniamtionOut)];
    CCSequence *autoPlaySequence5 = [CCSequence actions: autoPlayactionDelay5, autoPlay5, nil];
    autoPlaySequence5.tag = 124;
    [self runAction:autoPlaySequence5];
    
    id autoPlayactionDelay3 = [CCDelayTime actionWithDuration:3.5];
    id autoPlay3 = [CCCallFunc actionWithTarget:self selector:@selector(stopFruit)];
    CCSequence *autoPlaySequence3 = [CCSequence actions: autoPlayactionDelay3, autoPlay3, nil];
    autoPlaySequence3.tag = 124;
    [self runAction:autoPlaySequence3];
}




- (void) fruitfall {
    
    fruitfalling = YES;
    
    countfruit = 0;
    countletters = 0;
    
    
    if (amApple) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"apple_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"A_blocks.png" capacity:60];
        
    } else if (amBanana) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"banana_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"B_blocks.png" capacity:60];
        
    } else if (amCowboy) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"cowboy_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"C_blocks.png" capacity:60];
        
    } else if (amPirate) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"pirate_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"P_blocks.png" capacity:60];
        
    } else if (amStrawberry) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"strawberry_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"S_blocks.png" capacity:60];
        
    }  else if (amVampire) {
        
        
        batch = [CCSpriteBatchNode batchNodeWithFile:@"vampire_blocks.png" capacity:60];
        batch2 = [CCSpriteBatchNode batchNodeWithFile:@"V_blocks.png" capacity:60];
        
    }
    
    [self addChild:batch z:20 tag:kTagBatchNode];
    [self addChild:batch2 z:20 tag:kTagBatchNode2];
        
    [[CCDirector sharedDirector] setAnimationInterval:1.0/30];//set your fast frame rate
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        
}


- (void) voicePlayoff {
            
        inAction = NO;
        Mode_YES.opacity = 0;
        Mode_Voice.opacity = 255;
}

-(void) noises {
    
    if (amCowboy || amPirate || amVampire) {
        [self changeTune];
    }
    if (voicePlay) {
    id autoPlayactionDelay = [CCDelayTime actionWithDuration:5.0];
    id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(voicePlayoff)];
    CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    autoPlaySequence.tag = 124;
    [self runAction:autoPlaySequence];
    }
}

- (void) fruitnoise {
    
    inaction = YES;
    
    [self fruitfall];
    [self noises];
}

-(void)reconfigureAudioForPlayingMovie {
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) {
        NSLog(@"Audio Session Error");
    }
    NSLog(@"Audio Session Reconfigured");

}



-(void) FruitTriggerInnards {
    if (amApple){
        NSLog(@"Successs Apple");
        [self playAudioNamed:@"Apple-FunnyFarm"];
        //soundEffectID =[[SimpleAudioEngine sharedEngine] playEffect:@"Success_Apple.mp3"];
    } else if (amBanana){
        NSLog(@"Successs Banana");
        [self playAudioNamed:@"Banana_SunnyDay"];
        //soundEffectID =[[SimpleAudioEngine sharedEngine] playEffect:@"Success_Banana.mp3"];
    } else if (amStrawberry){
        NSLog(@"Successs Strawberry");
        [self playAudioNamed:@"Strawberry_Diddy"];
        //soundEffectID =[[SimpleAudioEngine sharedEngine] playEffect:@"Success_Strawberry.mp3"];
    }
    
    id autoPlayactionDelay = [CCDelayTime actionWithDuration:1.0];
    id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(fruitnoise)];
    CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    autoPlaySequence.tag = 124;
    [self runAction:autoPlaySequence];
}


- (void)FruitTrigger {
    
    if (!TransitionOut) {
        if (noisePlay || voicePlay) {
            [self dontlisten];
            [self performSelector:@selector(reconfigureAudioForPlayingMovie) withObject:nil afterDelay: 0.2];
            id FruitTriggerInnardsDelay = [CCDelayTime actionWithDuration:0.4];
            id FruitTriggerInnardsPlay = [CCCallFunc actionWithTarget:self selector:@selector(FruitTriggerInnards)];
            CCSequence *FruitTriggerInnardsSequence = [CCSequence actions: FruitTriggerInnardsDelay, FruitTriggerInnardsPlay, nil];
            FruitTriggerInnardsSequence.tag = 124;
            [self runAction:FruitTriggerInnardsSequence];
        }
        
        if (automaticPlay) {
        [self FruitTriggerInnards];
        }
        
    }
    
}

- (void)CostumeTrigger {
    [self performSelector:@selector(reconfigureAudioForPlayingMovie) withObject:nil afterDelay: 0.2];
    id autoPlayactionDelay = [CCDelayTime actionWithDuration:0.4];
    id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(CostumeAction)];
    CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    autoPlaySequence.tag = 124;
    [self runAction:autoPlaySequence];

}


- (void) CowboyTrigger {
    
    if (!TransitionOut) {
        
        if (automaticPlay) {
            
        [self CostumeAction];
            
        }
        
        if (noisePlay || voicePlay) {
            
            [self dontlisten];

            [self CostumeTrigger];

        }
    }
    
}


- (void) PirateTrigger {
    
    if (!TransitionOut) {
        
        if (automaticPlay) {
            
            [self CostumeAction];
            
        }
        
        if (noisePlay || voicePlay) {
            
            [self dontlisten];
            
            [self CostumeTrigger];
            
        }
    }
    
}

- (void) VampireTrigger {
    
    if (!TransitionOut) {
        
        if (automaticPlay) {
            
            [self CostumeAction];
            
        }
        
        if (noisePlay || voicePlay) {
            
            [self dontlisten];
            
            [self CostumeTrigger];
            
        }
    }
    
}


//////////////////////////////////////////////////  IN ANIMATION  //////////////////////////////////////////////////////////

- (void) State1In {
    
    NSLog(@"Apple In");
    
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"AppleIn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}
- (void) State2In {
    
    NSLog(@"Banana In");
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"BananaIn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}
- (void) State3In {
    
    NSLog(@"Cowboy In");
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"CowboyOn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}


- (void) State4In {
    
    NSLog(@"Pirate In");
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"PirateOn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}

- (void) State5In {
    
    NSLog(@"Strawberry In");
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"StrawberryIn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}

- (void) State6In {
    
    NSLog(@"Vampire In");
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"VampireOn" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationInDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
}

- (void) autoprompt {
    
    NSLog(@"autoprompt");
    
    if (State1Done && State2Done && State3Done && State4Done && State5Done && State6Done) {
        State1Done = NO;
        State2Done = NO;
        State3Done = NO;
        State4Done = NO;
        State5Done = NO;
        State6Done = NO;
    }
    
    if (avplayerlayer_Animations) {
        [avplayerlayer_Animations removeFromSuperlayer];
        avplayerlayer_Animations = nil;
    }
    
    
    srandom(time(NULL));
    NSUInteger newState = (CCRANDOM_0_1() * 6) + 0.5;
    switch (newState) {
        case kState1:
            if (!State1Done) {
                CCLOG(@"State1 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
                //amApple = YES;
                
            } else if (!State2Done) {
                CCLOG(@"State1 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
                //amBanana = YES;
                
            } else if (!State3Done) {
                CCLOG(@"State1 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
                //amCowboy = YES;
                
            } else if (!State4Done) {
                CCLOG(@"State1 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
                //amPirate = YES;
                
            } else if (!State5Done) {
                CCLOG(@"State1 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
                //amStrawberry = YES;
                
            } else if (!State6Done) {
                CCLOG(@"State1 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
                //amVampire = YES;
                
            }
            break;
        case kState2:
            if (!State2Done) {
                CCLOG(@"State2 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            } else if (!State3Done) {
                CCLOG(@"State2 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            } else if (!State4Done) {
                CCLOG(@"State2 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            } else if (!State5Done) {
                CCLOG(@"State2 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            } else if (!State6Done) {
                CCLOG(@"State2 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            } else if (!State1Done) {
                CCLOG(@"State2 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            }
            break;
        case kState3:
            if (!State3Done) {
                CCLOG(@"State3 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            } else if (!State4Done) {
                CCLOG(@"State3 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            } else if (!State5Done) {
                CCLOG(@"State3 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            } else if (!State6Done) {
                CCLOG(@"State3 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            } else if (!State1Done) {
                CCLOG(@"State3 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            } else if (!State2Done) {
                CCLOG(@"State3 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            }
            break;
            
        case kState4:
            if (!State4Done) {
                CCLOG(@"State4 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            } else if (!State5Done) {
                CCLOG(@"State4 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            } else if (!State6Done) {
                CCLOG(@"State4 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            } else if (!State1Done) {
                CCLOG(@"State4 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            } else if (!State2Done) {
                CCLOG(@"State4 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            } else if (!State3Done) {
                CCLOG(@"State4 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            }
            break;
            
        case kState5:
            if (!State5Done) {
                CCLOG(@"State5 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            } else if (!State6Done) {
                CCLOG(@"State5 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            } else if (!State1Done) {
                CCLOG(@"State5 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            } else if (!State2Done) {
                CCLOG(@"State5 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            } else if (!State3Done) {
                CCLOG(@"State5 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            } else if (!State4Done) {
                CCLOG(@"State5 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            }
            break;
            
        case kState6:
            if (!State6Done) {
                CCLOG(@"State6 State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            } else if (!State1Done) {
                CCLOG(@"State6 State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            } else if (!State2Done) {
                CCLOG(@"State6 State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            } else if (!State3Done) {
                CCLOG(@"State6 State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            } else if (!State4Done) {
                CCLOG(@"State6 State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            }  else if (!State5Done) {
                CCLOG(@"State6 State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            }
            break;
            
            
        default:
            if (!State1Done) {
                CCLOG(@"Default State1");
                currentState = kState1;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBgStart.jpg"];
                [self State1In];
                State1Done = YES;
            } else if (!State2Done) {
                CCLOG(@"Default State2");
                currentState = kState2;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBgStart.jpg"];
                [self State2In];
                State2Done = YES;
            } else if (!State3Done) {
                CCLOG(@"Default State3");
                currentState = kState3;
                [self State3In];
                State3Done = YES;
            } else if (!State4Done) {
                CCLOG(@"Default State4");
                currentState = kState4;
                [self State4In];
                State4Done = YES;
            } else if (!State5Done) {
                CCLOG(@"Default State5");
                currentState = kState5;
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBgStart.jpg"];
                [self State5In];
                State5Done = YES;
            } else if (!State6Done) {
                CCLOG(@"Default State6");
                currentState = kState6;
                [self State6In];
                State6Done = YES;
            }
        break;    }
    
    
    
    
}


//////////////////////////////////////////////////  PAUSE  //////////////////////////////////////////////////////////




-(void) AnimationInDidEnd {
    
    if(!TransitionOut) {
        
        if (currentState == kState1) {
            
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            
            [Text_Apple runAction:textfadeIn];
            
            amApple = YES;
            
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"appleBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-APPLE"];

            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-APPLE.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            
            if (noisePlay || voicePlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(FruitTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
                
            }
            
        }
        else if (currentState == kState2) {
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            [Text_Banana runAction:textfadeIn];
            
            amBanana = YES;
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"bananaBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-BANANA"];
            
            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-BANANA.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            if (noisePlay || voicePlay) {
                
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
                
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(FruitTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
                
            }
            
        }
        else if (currentState == kState3) {
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            
            [Text_Cowboy runAction:textfadeIn];
            
            amCowboy = YES;
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"CowboyBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-COWBOY"];
            
            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-COWBOY.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            if (noisePlay || voicePlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(CowboyTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            }
            
        } else if (currentState == kState4) {
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            
            [Text_Pirate runAction:textfadeIn];
            
            amPirate = YES;
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"PirateBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-PIRATE"];
            
            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-PIRATE.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            if (noisePlay || voicePlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(PirateTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            }
            
        } else if (currentState == kState5) {
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            
            [Text_Strawberry runAction:textfadeIn];
            
            amStrawberry = YES;
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"strawberryBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-STRAWBERRY"];
            
            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-STRAWBERRY.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.5];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            if (noisePlay || voicePlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.5];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.5];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(FruitTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            }
            
        } else if (currentState == kState6) {
            
            id textfadeIn = [CCFadeIn actionWithDuration:0.6];
            
            [Text_Vampire runAction:textfadeIn];
            
            amVampire = YES;
            if (!TransitionOut) {
                [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"VampireBg.jpg"];
            }
            
            [self playAudioNamed:@"HELLO-BABY-VAMPIRE"];
            
            //soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"HELLO-BABY-VAMPIRE.mp3"];
            
            id autoPlayactionDelay2 = [CCDelayTime actionWithDuration:3.0];
            id autoPlay2 = [CCCallFunc actionWithTarget:self selector:@selector(PrepareAnimations)];
            CCSequence *autoPlaySequence2 = [CCSequence actions: autoPlayactionDelay2, autoPlay2, nil];
            autoPlaySequence2.tag = 124;
            [self runAction:autoPlaySequence2];
            
            if (noisePlay || voicePlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(dolisten)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            } else if (automaticPlay) {
                id autoPlayactionDelay = [CCDelayTime actionWithDuration:4.0];
                id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(VampireTrigger)];
                CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
                autoPlaySequence.tag = 124;
                [self runAction:autoPlaySequence];
            }
            
        }
    }
    
    
}


//////////////////////////////////////////////////  OUT ANIMATION  //////////////////////////////////////////////////////////

- (void) State1Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"AppleOutAnimation" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
    
}
- (void) State2Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"BananaOutAnimation" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}
- (void) State3Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"CowboyOff" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}

- (void) State4Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"PirateOff" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}


- (void) State5Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"StrawberryOutAnimation" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}

- (void) State6Out {
    
    avplayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"VampireOut" ofType:@"m4v"]]];
    avplayerlayer_Animations = [AVPlayerLayer playerLayerWithPlayer:avplayer];
    avplayerlayer_Animations.frame = CGRectMake(0, 0, 1024, 768);
    [[BackgroundSingleton sharedInstance].layer addSublayer:avplayerlayer_Animations];
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AniamtionOutDone)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}


-(void) AniamtionOut {
    
    
    NSLog(@"Animation OUT");
    
    if (amCowboy || amPirate || amVampire) {
        
        if (avplayerlayer_Animations) {
            [avplayerlayer_Animations removeFromSuperlayer];
            avplayerlayer_Animations = nil;
        }
    }
    
    if (amApple) {
        
        //[self State1Out];
        State1Done = YES;
        
    } else if (amBanana) {
        
        //[self State2Out];
        State2Done = YES;
        
    } else if (amCowboy) {
        
        [self State3Out];
        State3Done = YES;
        
    } else if (amPirate) {
        
        [self State4Out];
        State4Done = YES;
        
    } else if (amStrawberry) {
        
        //[self State5Out];
        State5Done = YES;
        
    } else if (amVampire) {
        
        [self State6Out];
        State6Done = YES;
        
    }
    
    if (amApple || amBanana || amStrawberry) {
        
        [avplayer play];
        [avplayer release];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(AniamtionOutDone)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[avplayerlayer_Animations.player currentItem]];
    }
    
    
    
    
}


////////// ACTIONS ////////////////

- (void) CostumeAction {
    [avplayer play];
    [avplayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationActionDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avplayerlayer_Animations.player currentItem]];
    
}



-(void) AnimationActionDidEnd {
    
    [self fruitnoise];
    
}



//////////////////////////////////////////////////// SET NEXT RANDOM CYCLE ////////////////////////////////////////////////


-(void) AniamtionOutDone {
    
    if(!TransitionOut) {
        
        NSLog(@"Animation Out Done");
        
        amApple = NO;
        amBanana = NO;
        amCowboy = NO;
        amPirate = NO;
        amStrawberry = NO;
        amVampire = NO;
        
        [[BackgroundSingleton sharedInstance] setBackgroundImageToImageNamed:@"orangeBgStart.jpg"];
        
        id autoPlayactionDelay = [CCDelayTime actionWithDuration:0.2];
        id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(autoprompt)];
        CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
        // autoPlaySequence.tag = 306;
        [self runAction:autoPlaySequence];
        
        
    } else if (TransitionOut) {
        
        NSLog(@"TransitionOut");
        
        id autoPlayactionDelay = [CCDelayTime actionWithDuration:0.6];
        id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(FinishedOut)];
        CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
        // autoPlaySequence.tag = 306;
        [self runAction:autoPlaySequence];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////



#pragma mark -
#pragma mark Voiceover playback


- (void) touchenabled {
    
    CCLOG(@"Page 6 Init End Ignore");
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    
}







///// BACK TO COVER///////


-(void)FinishedOut {
        
    [[CCDirector sharedDirector]replaceScene:[Cover scene]];
    
}


-(void) AniamtionOutTransition {
    
    Menu_Layer2.opacity = 0;
    Menu_Layer3.opacity = 0;
    Menu_Layer1.opacity = 0;
    
    NSLog(@"Animation OUT Transition");
    
    if (avplayerlayer_Animations) {
        [avplayerlayer_Animations removeFromSuperlayer];
        avplayerlayer_Animations = nil;
    }
    
    
    if (amApple) {
        
        [self State1Out];
        State1Done = YES;
        
    } else if (amBanana) {
        
        [self State2Out];
        State2Done = YES;
        
    } else if (amCowboy) {
        
        [self State3Out];
        State3Done = YES;
        
    } else if (amPirate) {
        
        [self State4Out];
        State4Done = YES;
        
    } else if (amStrawberry) {
        
        [self State5Out];
        State5Done = YES;
        
    } else if (amVampire) {
        
        [self State6Out];
        State6Done = YES;
        
    } else {
        [self FinishedOut];
    }
    
}





- (void)GoToCover {
    
    id scaleUpAction = [CCScaleTo actionWithDuration:0.0 scaleX:1.0 scaleY:1.0];
    [Menu_Layer1 runAction:scaleUpAction];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
   
    [self fadeTextAudioOut];
    //[UkeLoop stop];
        
    
    //[self reconfigureAudioForPlayingMovie];

    
    if (noisePlay || voicePlay) {
        
        NSLog(@"GoToCover Voice or Noise");
             
        if (dolisten == YES) {
        
            [self.pocketsphinxController suspendRecognition];
        }
    }
    
    NSLog(@"Suspemd pocketsphinxController");

    
    //[[SimpleAudioEngine sharedEngine] stopEffect:soundEffectID];
    
    MenuHit = YES;
    
    [self stopActionByTag:124];
    
 
    
    
    Mode_YES.opacity = 0;
    Mode_Voice_Processing.opacity = 0;
    Mode_Noise_Listening.opacity = 0;
    Mode_Voice_Apple.opacity = 0;
    Mode_Voice_Banana.opacity = 0;
    Mode_Voice_Cowboy.opacity = 0;
    Mode_Voice_Pirate.opacity = 0;
    Mode_Voice_Strawberry.opacity = 0;
    Mode_Voice_Vampire.opacity = 0;
    
    Text_Apple.opacity = 0;
    Text_Strawberry.opacity = 0;
    Text_Banana.opacity = 0;
    Text_Cowboy.opacity = 0;
    Text_Pirate.opacity = 0;
    Text_Vampire.opacity = 0;
    
    id ModeFade = [CCFadeOut actionWithDuration:0.2];

    //id ModeOut = [CCMoveTo actionWithDuration:0.5 position:ccp(-200,120+offsetMic)];
    //id ModeOutEase = [CCEaseExponentialOut actionWithAction:ModeOut];
    
    if (automaticPlay) {
        [Mode_Auto runAction:ModeFade];
    } else if (voicePlay) {
        [Mode_Voice runAction:ModeFade];
    } else if (noisePlay) {
        [Mode_Noise runAction:ModeFade];
    }
    
    [Flurry logEvent:@"GO TO COVER"];
        
    if (inaction) {
        
        countletters = 50;
        countfruit = 60;
        
        NSLog(@"reset");
        
        
        [timer invalidate];
        timer = nil;
        
        [self removeChild:batch cleanup:(true)];
        [self removeChild:batch2 cleanup:(true)];
        
        [[CCDirector sharedDirector] setAnimationInterval:1.0/60];//set your fast frame rate
        
    }
    
    
    NSLog(@"nextscene");
    
    id TransitionDelay = [CCDelayTime actionWithDuration:0.2];
    id TransitionGo = [CCCallFunc actionWithTarget:self selector:@selector(AniamtionOutTransition)];
    CCSequence *TransitionSequence = [CCSequence actions: TransitionDelay, TransitionGo, nil];
    TransitionSequence.tag = 306;
    
    [self runAction:TransitionSequence];
    
    //[self AniamtionOutTransition];
    
    TransitionOut = YES;
    
}



- (void) menuthrob {
    
    NSLog(@"menuthrob");
    
    Menu_Layer3.opacity = 255;
    
    
    id scaleDownAction =  [CCScaleTo actionWithDuration:0 scaleX:0.0 scaleY:1.0];
    id fadeIn = [CCFadeIn actionWithDuration:0];
    id scaleUpAction = [CCScaleTo actionWithDuration:1.5 scaleX:1.0 scaleY:1.0];
    CCSequence *PlaySequence = [CCSequence actions: scaleDownAction, fadeIn, scaleUpAction, nil];
    PlaySequence.tag = 305;
    [Menu_Layer1 runAction:PlaySequence];
    
    id EndDelay = [CCDelayTime actionWithDuration:1.45];
    id EndGo = [CCCallFunc actionWithTarget:self selector:@selector(GoToCover)];
    CCSequence *EndSequence = [CCSequence actions: EndDelay, EndGo, nil];
    EndSequence.tag = 306;
    
    [self runAction:EndSequence];
    
}


#pragma mark -

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CCLOG(@"Page1 %@", NSStringFromSelector(_cmd));
    
    
	// work out where the touch point was
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    
    CGRect button = CGRectMake(872, 622, 115, 115);
    
 	if (CGRectContainsPoint(button, location)) {
        [self menuthrob];
        
    }
    
	
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Moved");
    
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Ended");
    
    if (!MenuHit) {
        Menu_Layer3.opacity = 0;
        Menu_Layer1.opacity = 0;
        
        [Menu_Layer1 stopActionByTag:305];
        [self stopActionByTag:306];
    }
}

-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Cancelled");
    
    if (!MenuHit) {
        Menu_Layer3.opacity = 0;
        Menu_Layer1.opacity = 0;
        
        [Menu_Layer1 stopActionByTag:305];
        [self stopActionByTag:306];
    }
    
}





- (void) removevideo {
    
    if (avplayerlayer_Animations) {
        [avplayerlayer_Animations removeFromSuperlayer];
        avplayerlayer_Animations = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}





- (void) stopFruit {
    NSLog(@"Stop Fruit");
    
    
    [self removeChild:batch cleanup:(true)];
    [self removeChild:batch2 cleanup:(true)];
    
    if (amApple) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"apple_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"A_blocks.png"];
    } else if (amBanana) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"banana_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"B_blocks.png"];
    } else if (amCowboy) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"cowboy_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"C_blocks.png"];
    } else if (amPirate) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"pirate_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"P_blocks.png"];
    } else if (amStrawberry) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"strawberry_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"S_blocks.png"];
    } else if (amVampire) {
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"vampire_blocks.png"];
        [[CCTextureCache sharedTextureCache] removeTextureForKey:@"V_blocks.png"];
    } 
    
    
    [timer invalidate];
    timer = nil;
    
    [[CCDirector sharedDirector] setAnimationInterval:1.0/60];//set your fast frame rate
    
    
    resetYet = NO;
    
    world->DestroyBody(body);
    world->DestroyBody(body2);
    world->DestroyBody(groundBody);
    delete world;
    world = NULL;
    
    inaction = NO;
    fruitfalling = NO;
    
    
    // Define the gravity vector.
    b2Vec2 gravity;
    gravity.Set(0.0f, -25.0f);
    
    // Do we want to let bodies sleep?
    // This will speed up the physics simulation
    bool doSleep = true;
    
    // Construct a world object, which will hold and simulate the rigid bodies.
    world = new b2World(gravity, doSleep);
    world->SetContinuousPhysics(true);
    
 
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    // Define the ground body.
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0, 0); // bottom-left corner
    groundBody = world->CreateBody(&groundBodyDef);
    b2PolygonShape groundBox;
    
    // bottom
    //groundBox.SetAsEdge(b2Vec2(0,1.5+offsetBox2D), b2Vec2(winSize.width/PTM_RATIO,1.5+offsetBox2D));
    //groundBody->CreateFixture(&groundBox,0);
    
    // left
    groundBox.SetAsEdge(b2Vec2(0,900), b2Vec2(0,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // right
    groundBox.SetAsEdge(b2Vec2(winSize.width/PTM_RATIO,0), b2Vec2(winSize.width/PTM_RATIO,900));
    groundBody->CreateFixture(&groundBox,0);
    
    
    
    
}






- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
    NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    
    
    int probability = [recognitionScore intValue];
    
    if (probability > -8000) {
        
        
        if (amApple == YES | amBanana == YES | amCowboy == YES | amPirate == YES || amStrawberry == YES || amVampire == YES) {
            
            inAction = YES;
            
            if (amApple == YES) {
                if([hypothesis isEqualToString:@"APPLE"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self FruitTrigger];
                    
                }
            } else if (amBanana == YES) {
                if([hypothesis isEqualToString:@"BANANA"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self FruitTrigger];
                    
                }
            } else if (amCowboy == YES) {
                if([hypothesis isEqualToString:@"COWBOY"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self CowboyTrigger];
                    
                }
            } else if (amPirate == YES) {
                if([hypothesis isEqualToString:@"PIRATE"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self PirateTrigger];
                    
                }
            } else if (amStrawberry == YES) {
                if([hypothesis isEqualToString:@"STRAWBERRY"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self FruitTrigger];
                    
                }
            } else if (amVampire == YES) {
                if([hypothesis isEqualToString:@"VAMPIRE"]) {
                    
                    Mode_YES.opacity = 255;
                    Mode_Voice.opacity = 0;
                    Mode_Voice_Processing.opacity = 0;
                    
                    [self VampireTrigger];
                    
                }
            }
        }
        
    }
    
}





- (void) pocketsphinxDidStartCalibration {
    NSLog(@"Pocketsphinx calibration has started.");
    
}

- (void) pocketsphinxDidCompleteCalibration {
	NSLog(@"Pocketsphinx calibration is complete.");
    
    [self dontlisten];
    [self performSelector:@selector(reconfigureAudioForPlayingMovie) withObject:nil afterDelay: 0.3];

    SSh.opacity = 0;
    
    self.isTouchEnabled = YES;
    
    id MenuDelay = [CCDelayTime actionWithDuration:0.5];
    id MenufadeIn = [CCFadeIn actionWithDuration:0.0];
    CCSequence *MenuSequence = [CCSequence actions: MenuDelay, MenufadeIn, nil];
    [Menu_Layer2 runAction:MenuSequence];
    
    //Menu_Layer2.opacity = 255;
    
    
    //id SshFadeOut = [CCFadeOut actionWithDuration:0.6];
    //[SSh runAction:SshFadeOut];
    
    id ModeIn = [CCMoveTo actionWithDuration:0.3 position:ccp(115,120+offsetMic)];
    id ModeInEase = [CCEaseExponentialOut actionWithAction:ModeIn];
    
    if (voicePlay) {
        [Mode_Voice runAction:ModeInEase];
    } else if (noisePlay) {
        [Mode_Noise runAction:ModeInEase];
    }
    
    NSLog(@"Play Intro IntroTimmy");
    
    //[self IntroTimmy];
    
    id autoPlayactionDelay = [CCDelayTime actionWithDuration:0.6];
    id autoPlay = [CCCallFunc actionWithTarget:self selector:@selector(IntroTimmy)];
    CCSequence *autoPlaySequence = [CCSequence actions: autoPlayactionDelay, autoPlay, nil];
    autoPlaySequence.tag = 124;
    [self runAction:autoPlaySequence];
}

- (void) pocketsphinxDidStartListening {
	NSLog(@"Pocketsphinx is now listening.");
    
    if (!MenuHit) {
    if (voicePlay) {
        
        Mode_Voice.opacity = 0;
        Mode_Voice_Processing.opacity = 0;
        
        if (amApple == YES) {
            
            Mode_Voice_Apple.opacity = 255;
            
        } else if (amBanana == YES) {
            
            Mode_Voice_Banana.opacity = 255;
            
        } else if (amCowboy == YES) {
            
            Mode_Voice_Cowboy.opacity = 255;
            
        } else if (amPirate == YES) {
            
            Mode_Voice_Pirate.opacity = 255;
            
        } else if (amStrawberry == YES) {
            
            Mode_Voice_Strawberry.opacity = 255;
            
        } else if (amVampire == YES) {
            
            Mode_Voice_Vampire.opacity = 255;
        }
        
    } else if (noisePlay) {
        
        Mode_Noise.opacity = 0;
        
        Mode_Noise_Listening.opacity = 255;
        
    }
    
    }
    
    
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx has detected speech.");
    
    
    if (voicePlay) {
        
        if (amApple == YES | amBanana == YES | amCowboy == YES | amPirate == YES || amStrawberry == YES || amVampire == YES) {
            
            Mode_Voice_Processing.opacity = 255;
            
            if (amApple == YES) {
                
                Mode_Voice_Apple.opacity = 0;
                
            } else if (amBanana == YES) {
                
                Mode_Voice_Banana.opacity = 0;
                
            } else if (amCowboy == YES) {
                
                Mode_Voice_Cowboy.opacity = 0;
                
            } else if (amPirate == YES) {
                
                Mode_Voice_Pirate.opacity = 0;
                
            } else if (amStrawberry == YES) {
                
                Mode_Voice_Strawberry.opacity = 0;
                
            } else if (amVampire == YES) {
                
                Mode_Voice_Vampire.opacity = 0;
                
            }
        }
    }
    
    else if (noisePlay){
        
        
        if (amApple == YES | amBanana == YES | amCowboy == YES | amPirate == YES || amStrawberry == YES || amVampire == YES) {
            
            Mode_Noise.opacity = 255;
            Mode_Noise_Listening.opacity = 0;
            
            if (amApple == YES) {
                
                NSLog(@"Noise Heard Apple");
                
                [self FruitTrigger];
                
            } else if (amBanana == YES) {
                
                NSLog(@"Noise Heard Banana");
                
                [self FruitTrigger];
                
            } else if (amCowboy == YES) {
                
                NSLog(@"Noise Heard Cowboy");
                
                [self CowboyTrigger];
                
            } else if (amPirate == YES) {
                
                NSLog(@"Noise Heard Pirate");
                
                [self PirateTrigger];
                
            } else if (amStrawberry == YES) {
                
                NSLog(@"Noise Heard Strawberry");
                
                [self FruitTrigger];
                
            } else if (amVampire == YES) {
                
                NSLog(@"Noise Heard Vampire");
                
                [self VampireTrigger];
            }
        }
        
    }
}

- (void) pocketsphinxDidDetectFinishedSpeech {
	NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
    
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
    
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
    if (voicePlay) {
        
        if (!inAction) {
            Mode_Voice.opacity = 255;
        }
        
        if (amApple == YES) {
            
            Mode_Voice_Apple.opacity = 0;
            
        } else if (amBanana == YES) {
            
            Mode_Voice_Banana.opacity = 0;
            
        } else if (amCowboy == YES) {
            
            Mode_Voice_Cowboy.opacity = 0;
            
        } else if (amPirate == YES) {
            
            Mode_Voice_Pirate.opacity = 0;
            
        } else if (amStrawberry == YES) {
            
            Mode_Voice_Strawberry.opacity = 0;
            
        } else if (amVampire == YES) {
            
            Mode_Voice_Vampire.opacity = 0;
            
        }
    } else if (noisePlay) {
        
        Mode_Noise_Listening.opacity = 0;
        Mode_Noise.opacity = 255;
        
    }
}

/*-(void) updateIconVoice {
    Mode_Voice.opacity = 0;
    
    if (amApple == YES) {
        
        Mode_Voice_Apple.opacity = 255;
        
    } else if (amBanana == YES) {
        
        Mode_Voice_Banana.opacity = 255;
        
    } else if (amCowboy == YES) {
        
        Mode_Voice_Cowboy.opacity = 255;
        
    } else if (amPirate == YES) {
        
        Mode_Voice_Pirate.opacity = 255;
        
    } else if (amStrawberry == YES) {
        
        Mode_Voice_Strawberry.opacity = 255;
        
    } else if (amVampire == YES) {
        
        Mode_Voice_Vampire.opacity = 255;
        
    }

}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
    
    if (voicePlay) {
        
        id updateIconDelay = [CCDelayTime actionWithDuration:0.1];
        id updateIconPlay = [CCCallFunc actionWithTarget:self selector:@selector(updateIconVoice)];
        CCSequence *updateIconSequence = [CCSequence actions: updateIconDelay, updateIconPlay, nil];
        updateIconSequence.tag = 124;
        [self runAction:updateIconSequence];
        
        
    } else if (noisePlay) {
        
        Mode_Noise_Listening.opacity = 255;
        Mode_Noise.opacity = 0;
        
    }
}*/

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
    
    if (voicePlay) {
        
        Mode_Voice.opacity = 0;
        
        if (amApple == YES) {
            
            Mode_Voice_Apple.opacity = 255;
            
        } else if (amBanana == YES) {
            
            Mode_Voice_Banana.opacity = 255;
            
        } else if (amCowboy == YES) {
            
            Mode_Voice_Cowboy.opacity = 255;
            
        } else if (amPirate == YES) {
            
            Mode_Voice_Pirate.opacity = 255;
            
        } else if (amStrawberry == YES) {
            
            Mode_Voice_Strawberry.opacity = 255;
            
        } else if (amVampire == YES) {
            
            Mode_Voice_Vampire.opacity = 255;
            
        }
        
    } else if (noisePlay) {
        
        Mode_Noise_Listening.opacity = 255;
        Mode_Noise.opacity = 0;
        
    }
}


- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
	NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on OPENEARSLOGGING to learn why.
	NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on OpenEarsLogging to learn more.");
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    CCLOG(@"Page1 dealloc");
    NSLog(@"rc: %d", [Page1 retainCount]);
    
    if (avplayerlayer_Animations) {
        [avplayerlayer_Animations removeFromSuperlayer];
        avplayerlayer_Animations = nil;
    }
    
    [UkeLoop stop];
    [UkeLoop release];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    /*if (fruitfalling) {
     
     world->DestroyBody(body);
     world->DestroyBody(body2);
     world->DestroyBody(groundBody);
     
     }*/
    
    delete world;
    world = NULL;
    
    // in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    if (voicePlay || noisePlay) {
        
        [self.pocketsphinxController stopListening];
        
        [self.openEarsEventsObserver setDelegate:nil];
        
        [openEarsEventsObserver release];
        [pocketsphinxController release];
        
        //[self.pocketsphinxController release];
        //[self.openEarsEventsObserver release];
        
        CCLOG(@"Release OopenEars etc");
        
    }
        
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

	// don’t forget to call "super dealloc"
	[super dealloc];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [[CCDirector sharedDirector] purgeCachedData];
    
    
    
    CCLOG(@"Finished dealloc");
}
@end
