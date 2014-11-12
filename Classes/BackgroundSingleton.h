//
//  BackgroundSingleton.h
//  TimmyTickle
//
//  Created by Carl Morland on 08/02/2012.
//  Copyright (c) 2012 NimbleBean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundSingleton : UIView
{
    UIImageView *backgroundImage;
}

+ (BackgroundSingleton *)sharedInstance;
- (void)setBackgroundImageToImageNamed:(NSString*)imageName;
- (void)rotateToOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration;

@end
