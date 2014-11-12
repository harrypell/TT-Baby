//
//  scene_1AppDelegate.m
//  scene_1
//
//  Created by Harriet Pellereau on 12/11/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "cocos2d.h"

#import "scene_1AppDelegate.h"
#import "GameConfig.h"
#import "Intro.h"
#import "RootViewController.h"
#import "Appirater.h"

#import "BackgroundSingleton.h"

#import "Flurry.h"


@implementation scene_1AppDelegate

@synthesize window;
@synthesize noisePlay;
@synthesize voicePlay;
@synthesize automaticPlay;
@synthesize newPage;
@synthesize iPad2;
@synthesize introPlayed;


- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
    
    //	CC_ENABLE_DEFAULT_GL_STATES();
    //	CGSize size = [director winSize];
    //	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
    //	sprite.position = ccp(size.width/2, size.height/2);
    //	sprite.rotation = -90;
    //	[sprite visit];
    //	[glView swapBuffers];
    //	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController
}



- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    [Appirater setAppId:@"649383502"];
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:10];
   // [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:4];
    [Appirater setDebug:NO];
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"255Z4JXSQ58WJ8HPM9PD"];
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ADD BACKGROUND SINGLETON - THIS WILL THEN BE BEHIND ALL COCOS LAYERS
    [window addSubview:[BackgroundSingleton sharedInstance]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
    [[CCDirector sharedDirector] setProjection:kCCDirectorProjection2D];
    
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGBA8	// kEAGLColorFormatRGB565
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
    [glView setMultipleTouchEnabled:YES];
    
	
    //	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    //	if( ! [director enableRetinaDisplay:YES] )
    //		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
    //#if GAME_AUTOROTATION == kGameAutorotationUIViewController
    //	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
    //#else
    //	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
    //#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
    //[director setAnimationInterval:1.0/30];
	//[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	//[viewController setView:glView];
    
    // add glView to view controller
    [viewController.view addSubview:glView];
	glView.opaque = NO;
	
	// make the View Controller a child of the main window
    
    //Attempt 1 [window setRootViewController:viewController];
    //[window addSubview: viewController.view];
	
    NSString *reqSysVer = @"6.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        NSLog(@"iOS 6");
        window.rootViewController = viewController;
    }
    else
    {
        NSLog(@"iOS Under 6");
        [window addSubview: viewController.view];
        
    }
    
    
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
	
	// Removes the startup flicker
	[self removeStartupFlicker];
    
    // Detect iPad2 by checking to see if a camera is present
    iPad2 = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [Intro node]];
    
    [Appirater appLaunched:YES];
}




- (void)applicationWillResignActive:(UIApplication *)application {
     exit(EXIT_SUCCESS);
	//[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
    [Appirater appEnteredForeground:YES];
    
    [[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];
}





- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) addViewToBack:(UIView *)view {
	[viewController.view addSubview:view];
	[viewController.view sendSubviewToBack:view];
}

- (void) setBackgroundView:(UIView *)view {
}

- (void) setBackgroundImage:(UIImage *)image {
    if (backgroundView != nil) {
        backgroundView.image = image;
    }
}

- (void) removeBackroundView {
	if (backgroundView != nil) {
		[backgroundView removeFromSuperview];
	}
	backgroundView = nil;
}


- (void) addViewInFrontOfBackground:(UIView *)view {
	if (backgroundView != nil) {
		[viewController.view insertSubview:view aboveSubview:backgroundView];
	} else {
		[viewController.view addSubview:view];
		[viewController.view sendSubviewToBack:view];
	}
}



- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
