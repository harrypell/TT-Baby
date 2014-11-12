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



// Intro Layer
@interface Intro : CCLayer
{
    AVPlayerLayer *avplayerlayer_wave;
  
}


// returns a Scene that contains the HelloWorld as the only child
+(id) scene;


@end
