//
//  BackgroundSingleton.m
//  TimmyTickle
//
//  Created by Carl Morland on 08/02/2012.
//  Copyright (c) 2012 NimbleBean. All rights reserved.
//

#import "BackgroundSingleton.h"

@implementation BackgroundSingleton

static BackgroundSingleton *_backgroundSingleton = nil;

static BOOL iPad = YES;

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




//static BOOL iPad = YES;


+ (BackgroundSingleton *)sharedInstance
{
	if (!_backgroundSingleton) {
        
        if (IS_IPHONE_5) {
            _backgroundSingleton = [[self alloc] initWithFrame:CGRectMake(0, 44, 1024, 768)];
            //NSLog(@"AM IPHONE 5 background singleton");

        } else
        {
            _backgroundSingleton = [[self alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
            
        }
    }
    
	return _backgroundSingleton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGAffineTransform transform;
        //2018 transform = CGAffineTransformMakeTranslation(768/2-1024/2, 1024/2-768/2);
        //transform = CGAffineTransformRotate(transform, M_PI/2);
        transform = CGAffineTransformMakeTranslation(0, 0);
        self.transform = transform;
        
        backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        backgroundImage.backgroundColor = [UIColor blackColor];
        [self addSubview:backgroundImage];
        
        self.alpha = 0.999f;
    }
    return self;
}

- (void)setBackgroundImageToImageNamed:(NSString*)imageName
{
    if (backgroundImage) {
        [backgroundImage removeFromSuperview];
        [backgroundImage release];
        backgroundImage = nil;
    }
    
    if (imageName) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:
                          [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName]];
        
        backgroundImage = [[UIImageView alloc] initWithImage:image];
        [self addSubview:backgroundImage];
        
        [image release];
    }
}

- (void)rotateToOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        CGAffineTransform transform;
        if (IS_IPAD) {
            transform = CGAffineTransformMakeTranslation(768/2-1024/2, 1024/2-768/2);
        }
        else {
            
            NSLog(@"is not ipad - UIInterfaceOrientationLandscapeRight");
            //transform = CGAffineTransformMakeTranslation(320/2-1024/2, 480/2-768/2);
            transform = CGAffineTransformMakeTranslation(-275, -210);
            //transform = CGAffineTransformScale(transform, 480.0f/1024.0f, 480.0f/1024.0f);
            transform = CGAffineTransformScale(transform, 0.5f, 0.5f);
        }
        //transform = CGAffineTransformRotate(transform, M_PI/2);
        transform = CGAffineTransformRotate(transform, 0);

        self.transform = transform;
    }
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGAffineTransform transform;
        if (IS_IPAD) {
            transform = CGAffineTransformMakeTranslation(768/2-1024/2, 1024/2-768/2);
        }
        else {
            NSLog(@"is not ipad - UIInterfaceOrientationLandscapeLeft");
            //transform = CGAffineTransformMakeTranslation(320/2-1024/2, 480/2-768/2);
            transform = CGAffineTransformMakeTranslation(-275, -210);
            //transform = CGAffineTransformScale(transform, 480.0f/1024.0f, 480.0f/1024.0f);
            transform = CGAffineTransformScale(transform, 0.5f, 0.5f);

        }
        //transform = CGAffineTransformRotate(transform, -M_PI/2);
        transform = CGAffineTransformRotate(transform, 0);

        self.transform = transform;
    }
    
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
