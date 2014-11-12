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


#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)




//static BOOL iPad = YES;


+ (BackgroundSingleton *)sharedInstance
{
	if (!_backgroundSingleton) {
        
        if (IS_IPHONE5) {
            _backgroundSingleton = [[self alloc] initWithFrame:CGRectMake(0, 44, 1024, 768)];
            NSLog(@"AM IPHONE 5 background singleton");

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
        transform = CGAffineTransformMakeTranslation(768/2-1024/2, 1024/2-768/2);
        transform = CGAffineTransformRotate(transform, M_PI/2);
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
            transform = CGAffineTransformMakeTranslation(320/2-1024/2, 480/2-768/2);
            transform = CGAffineTransformScale(transform, 480.0f/1024.0f, 480.0f/1024.0f);
        }
        transform = CGAffineTransformRotate(transform, M_PI/2);
        self.transform = transform;
    }
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        CGAffineTransform transform;
        if (IS_IPAD) {
            transform = CGAffineTransformMakeTranslation(768/2-1024/2, 1024/2-768/2);
        }
        else {
            transform = CGAffineTransformMakeTranslation(320/2-1024/2, 480/2-768/2);
            transform = CGAffineTransformScale(transform, 480.0f/1024.0f, 480.0f/1024.0f);
        }
        transform = CGAffineTransformRotate(transform, -M_PI/2);
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
