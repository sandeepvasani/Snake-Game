//
//  BackgroundLayer.m
//  Hello
//
//  Created by CSCI5931 Spring14 on 1/29/14.
//  Copyright (c) 2014 CSCI5931 Spring14. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

-(id)init {
    self = [super init];
    if (self != nil) {
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:@"backgroundiPhone.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage];
        
    }
    return self;
}


@end
