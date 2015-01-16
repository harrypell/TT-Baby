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


#define kSwipeLeft 1
#define kSwipeRight 2
#define kSwipeUp 3
#define kSwipeDown 4


// Cover Layer
@interface Cover : CCLayer
{
    
    BOOL INFOSWIPE;
    BOOL MORESWIPE;
    
    
    CCSprite *dark1;
    
    CCSprite *swipe;
    
    BOOL swipeLeft;
    BOOL swipeRight;
    BOOL swipeUp;
    BOOL swipeDown;
    
    CGPoint firstTouch;
    CGPoint lastTouch;
    
    BOOL voicePlay;
    BOOL noisePlay;
    BOOL automaticPlay;
    BOOL introPlayed;
    
    BOOL CONTROL;
    
    BOOL HELLO;
    
    
    BOOL aminfo1;
    BOOL aminfo2;
    BOOL aminfo3;
    BOOL aminfo4;
    BOOL aminfo5;
    BOOL aminfo6;
    
    CCSprite *Info; // NIPPER CLIPPER INSTRUCTIONS
    
    CCMenu *InfoBack; // BACK BUTTON
	
	CCSprite *creditbackground;
    
	CCSprite *title;
    
    BOOL text1Playing;
    unsigned int text1id;
    
	CCMenu *PLAYGO;
    
    CCMenu *NipperClipperGo;
	CCMenu *HelloGo;
    
    BOOL infoVisible;
    
    BOOL titleAudioPlaying;
    
    BOOL transitionIsToNextPage;
    
    AVPlayerLayer *avplayerlayer_wave;

    CCMenu *advertMenu;

    AVAudioPlayer *UkeLoop;
    
    int offset;
    int infoOffsetBack;
    int offsetIcons;
    int offsetInfo;
    int offesetPlay;
    int offsetControl;
    
    NSString *languageID;

}


+(id) scene;


@end
