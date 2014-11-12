//
//  Globals.m
//  TimmyTickle
//
//  Created by Paul Dias on 01/04/2012.
//  Copyright (c) 2012 NimbleBean. All rights reserved.
//

#import "Globals.h"

@implementation Globals

@synthesize checkedAdvert = _checkedAvert;

static Globals *sharedGlobalsInstance = nil;

+ (Globals *)sharedInstance {    
    if (sharedGlobalsInstance == nil) {        
        sharedGlobalsInstance = [[super allocWithZone:NULL] init];
    }
    return sharedGlobalsInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {    
    return NSUIntegerMax;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

@end
