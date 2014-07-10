//
//  GameScene.m
//  SnakeGame
//
//  Created by macuser2 on 2/10/14.
//  Copyright Sandeep 2014. All rights reserved.

#import "GameScene.h"

#import "GameplayLayer.h"


@implementation GameScene

-(id)init {
    self = [super init];
    if (self != nil) {
        
        
        // Gameplay Layer
        GameplayLayer *gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];

    }
    return self;
}

@end
