#import "cocos2d.h"
#import "RootViewController.h"
#import "GameConfig.h"
#import "BackgroundSingleton.h"

@implementation RootViewController

//#ifdef UI_USER_INTERFACE_IDIOM
//#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#else
//#define IS_IPAD false
//#endif


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
//#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)




- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad {
    
    // TEST OPT OUT
    if (IS_RETINA && !IS_IPHONE) {
                
        NSLog(@"IS RETINA!");
        
    } else {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0.01f];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0.01f];
    }
    
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



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
    else if (IS_IPHONE_5) {
        glView.frame = CGRectMake((rect.origin.x)+44, (rect.origin.y)-4, rect.size.width, (rect.size.height)+8);
    }
    else if (!IS_IPAD && !IS_IPHONE_5) {
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

