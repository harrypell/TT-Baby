//
//  Page5.h
//  MyLittleOctopus
//
//  Created by Harriet Pellereau on 19/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <CoreMedia/CoreMedia.h>

#import <OpenEars/LanguageModelGenerator.h>
//#import <Rejecto/LanguageModelGenerator+Rejecto.h>
#import <OpenEars/PocketsphinxController.h>
//#import <OpenEars/AudioSessionManager.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import <OpenEars/OpenEarsLogging.h>



#import "Box2D.h"
//#import "GLES-Render.h"

#define kState1 1
#define kState2 2
#define kState3 3
#define kState4 4
#define kState5 5
#define kState6 6





#define PTM_RATIO 32.0



@interface Page1 : CCLayer <OpenEarsEventsObserverDelegate>
{
    
    BOOL MenuHit;
    BOOL TransitionOut;
    BOOL dolisten;
    BOOL inaction;
    
    CCSprite *Menu_Layer1;
    CCSprite *Menu_Layer2;
    CCSprite *Menu_Layer3;
    
    
    CCSprite *Mode_Voice;
    CCSprite *Mode_Voice_Apple;
    CCSprite *Mode_Voice_Banana;
    CCSprite *Mode_Voice_Cowboy;
    CCSprite *Mode_Voice_Pirate;
    CCSprite *Mode_Voice_Strawberry;
    CCSprite *Mode_Voice_Vampire;
    CCSprite *Mode_Voice_Processing;
    
    CCSprite *Mode_Noise;
    CCSprite *Mode_Noise_Listening;
    
    CCSprite *Mode_YES;
    
    CCSprite *Mode_Auto;
    
    
    BOOL voicePlay;
    BOOL noisePlay;
    BOOL automaticPlay;
    
    PocketsphinxController *pocketsphinxController;
    OpenEarsEventsObserver* openEarsEventsObserver;
    
    CCSprite *SSh;    
    
    CCSprite *Text_Apple;
    CCSprite *Text_Banana;
    CCSprite *Text_Strawberry;
    CCSprite *Text_Cowboy;
    CCSprite *Text_Pirate;
    CCSprite *Text_Vampire;
    
    CCSprite *fruitblock;
    CCSprite *letterblock;
    
    
	BOOL currentState;
    
    BOOL amIntro;
    BOOL amApple;
    BOOL amBanana;
    BOOL amStrawberry;
    BOOL amPirate;
    BOOL amCowboy;
    BOOL amVampire;
    
    
    AVPlayerLayer *avplayerlayer_Animations;
    AVPlayer *avplayer;
    
    
    BOOL State1Done;
    BOOL State2Done;
    BOOL State3Done;
    BOOL State4Done;
    BOOL State5Done;
    BOOL State6Done;
    
    AVAudioPlayer *UkeLoop;
    
    int offsetText;
    int offsetLetterx;
    int offsetLettery;
    int offsetMic;
    int offsetBox2D;
    
    int countfruit;
    int countletters;
    
    b2World *world;
	b2Body *groundBody;
    b2Body *body;
    b2Body *body2;
	//GLESDebugDraw *m_debugDraw;
    CCSpriteBatchNode *batch;
    CCSpriteBatchNode *batch2;
    
    NSTimer *timer;
    
    BOOL resetYet;
    
    BOOL music1;
    BOOL music2;
    BOOL music3;
    
    BOOL fruitfalling;
    BOOL inAction;
    
    //NSString *lmPathALL;
    //NSString *dicPathALL;
    
    //NSString *lmPathBanana;
    //NSString *dicPathBanana;
    
}

// returns a Scene that contains the HelloWorld as the only child
+ (id) scene;



@property (nonatomic, retain) PocketsphinxController *pocketsphinxController;
@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver;
//@property (nonatomic, retain) AudioSessionManager *AudioSessionManager;
//@property (nonatomic, retain) OpenEarsLogging *OpenEarsLogging;

-(void) addNewSpriteWithCoords:(CGPoint)p;


@end
