//
//  Globals.h
//  TimmyTickle
//
//  Created by Paul Dias on 01/04/2012.
//  Copyright (c) 2012 NimbleBean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject {
    BOOL _checkedAvert;    
}
@property BOOL checkedAdvert;
+ (Globals *)sharedInstance;
@end
