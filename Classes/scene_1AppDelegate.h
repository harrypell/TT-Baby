//
//  scene_1AppDelegate.h
//  scene_1
//
//  Created by Harriet Pellereau on 12/11/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootViewController;

@interface scene_1AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    UIImageView	 	    *backgroundView;
	UIView				*movieView;
    BOOL                voicePlay;
    BOOL                noisePlay;
    BOOL                automaticPlay;
    BOOL                introPlayed;
    NSUInteger          newPage;
    BOOL                iPad2;
}

@property (nonatomic, retain) UIWindow *window;
@property BOOL voicePlay;
@property BOOL noisePlay;
@property BOOL automaticPlay;
@property BOOL introPlayed;


@property NSUInteger newPage;
@property BOOL iPad2;

- (void) addViewToBack:(UIView *)view;
- (void) setBackgroundView:(UIView *)view;
- (void) setBackgroundImage:(UIImage *)image;
- (void) removeBackroundView;
- (void) addViewInFrontOfBackground:(UIView *)view;

@end
