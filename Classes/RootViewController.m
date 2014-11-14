//
//  RootViewController.m
//  scene_1
//
//  Created by Harriet Pellereau on 12/11/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"
#import "RootViewController.h"
#import "GameConfig.h"
#import "BackgroundSingleton.h"

@implementation RootViewController

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

//static BOOL iPad = YES;

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib. */


- (void)viewDidLoad {
    
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0.01f];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0.01f];
    
	[super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



/*
 #ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
 #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
 
 
 -(NSUInteger)supportedInterfaceOrientations{
 //Modify for supported orientations, put your masks here
 return (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
 
 NSLog(@"iOS over 6 RootView");
 
 }
 
 - (BOOL)shouldAutorotate {
 return YES;
 }
 #endif
 #endif
 */


/*
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
 {
 return UIInterfaceOrientationLandscapeLeft;
 }
 */



/*
 
 - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
 {
 [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
 self.view = UIInterfaceOrientationIsLandscape(toInterfaceOrientation) ? _viewLandscape : _viewPortrait;
 }
 */






//
// This callback only will be called when GAME_AUTOROTATION == kGameAutorotationUIViewController
//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // ROTATE BACKGROUND AND FOREGROUND SINGLETONS
    [[BackgroundSingleton sharedInstance] rotateToOrientation:toInterfaceOrientation duration:duration];
    
    NSLog(@"willRotateToInterfaceOrientation");
	//
	// Assuming that the main window has the size of the screen
	// BUG: This won't work if the EAGLView is not fullscreen
	//
    CGRect screenRect;
    


    
    if (IS_IPAD) {
        screenRect = [[UIScreen mainScreen] bounds];
        }
    //else if (IS_IPHONE5) screenRect = CGRectMake(0, 0, 340, 480);
    else {
        screenRect = CGRectMake(0, 0, 340, 480); // the secret sauce here is to use 340 instead of 320 for iPhone
        }
    
    
    
    
    CGRect rect;
	
	if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		rect = screenRect;
	
	else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
		rect.size = CGSizeMake( screenRect.size.height, screenRect.size.width );
	
	CCDirector *director = [CCDirector sharedDirector];
	EAGLView *glView = [director openGLView];
	float contentScaleFactor = [director contentScaleFactor];
    
	if( contentScaleFactor != 1 ) {
		rect.size.width *= contentScaleFactor;
		rect.size.height *= contentScaleFactor;
	}
    
    
    if (IS_IPAD) {
        glView.frame = CGRectMake(rect.origin.x, (rect.origin.y)-4, rect.size.width, (rect.size.height)+8);
    }
    else if (IS_IPHONE5) {
        glView.frame = CGRectMake((rect.origin.x)+44, (rect.origin.y)-4, rect.size.width, (rect.size.height)+8);
    }
    else if (!IS_IPAD && !IS_IPHONE5) {
        glView.frame = CGRectMake(rect.origin.x, (rect.origin.y)-4, rect.size.width, (rect.size.height)+8);
    }
    
    
    
    if (!IS_IPAD) {
        glView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(480.0f/1024.0f, 480.0f/1024.0f),
                                                   CGAffineTransformMakeTranslation(240-512, -224));
    }
    
    
    
    
}
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController

// tell the director that the orientation has changed
-(void) orientationChanged:(NSNotification *)notification
{
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
	{
		[[CCDirector sharedDirector] setDeviceOrientation:(ccDeviceOrientation)orientation];
	}
}




- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

