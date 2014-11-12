//
//  Cover.h
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

// Cover Layer
@interface Advert : CCLayer
{
    // INTRO
    
    CCMenu *Skip;
    CCSprite *IntroBackground;
    
    CCSprite *Intro1_Copy;
    CCSprite *Intro2_Copy;
    CCSprite *Intro3_Copy;
    CCSprite *Intro4_Copy;
    CCSprite *Intro5_Copy;
    
    CCSprite *Intro1_Logo;
    CCSprite *Intro2_Tom;
    CCSprite *Intro3_Clipper;
    CCSprite *Intro3_Packaging;
    CCSprite *Intro3_Sketch;
    CCSprite *Intr04_BabyBody;
    CCSprite *Intr04_BabyArm1;
    CCSprite *Intr04_BabyArm2;
    CCSprite *Intr04_iPad;
    CCSprite *Intr04_Notes;    
     
     
    AVAudioPlayer *UkeLoop;
    
    int offset;
    //int blinkOffset;
    int infoOffsetBack;
    int offsetIcons;
    int offsetInfo;
    int offesetPlay;
    
    int offesetCopy1;
    int ofsetTom;
    int offesetCopy;
    int offesetClippers;
    int offsetControl;

}


// returns a Scene that contains the HelloWorld as the only child
+(id) scene;


@end
