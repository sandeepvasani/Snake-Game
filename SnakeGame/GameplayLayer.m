//
//  GameplayLayer.m
//  SnakeGame
//
//  Created by macuser2 on 2/10/14.
//  Copyright Sandeep 2014. All rights reserved.

#import "GameplayLayer.h"
#import "GameOverScene.h"
int count =1;

@implementation GameplayLayer

-(id)init {
    self = [super init];
    if (self != nil) {
        snakeSprite = [CCSprite spriteWithFile:@"BullSnake.png"];
        CGSize size = [[CCDirector sharedDirector] winSize];
		float randX=(arc4random()%(int)(size.width));
		if(randX<size.width*0.2)
			randX=randX+size.width*0.2;
		if(randX>(size.width)-size.width*0.2)
			randX=randX-size.width*0.2;
			
		int randY=arc4random()%(int)(size.height);
		if(randY<size.height*0.2)
			randY=randY+size.height*0.2;
		if(randY>(size.height)-size.height*0.2)
			randY=randY-size.height*0.2;
		
        
        [snakeSprite setPosition:ccp(randX,randY)];
        [self addChild:snakeSprite];
       
		
		float X=0.0f;
        float Y=0.0f;
		CCRotateTo *rot;
		switch(arc4random()%4+1)    //to use switch change position to X,Y    arc4random()%4+1
		{
			case 1:
			 X=size.width+300.0;  //right
			 Y=randY;
             rot=[CCRotateTo actionWithDuration:0.1 angle:180];
             [snakeSprite runAction:rot];
              snakeSprite.flipY=YES;
			 break;
			 
			case 2:
			 X=-300.0;    //left
			 Y=randY;
                rot=[CCRotateTo actionWithDuration:0.1 angle:0];
                [snakeSprite runAction:rot];
             break;
			 
			 case 3:
			 X=randX;
			 Y=size.height+300.0;    //up
                rot=[CCRotateTo actionWithDuration:0.1 angle:90];
                [snakeSprite runAction:rot];
                break;
			 
			 case 4:
			 X=randX;
			 Y=-300.0;          //down
                rot=[CCRotateTo actionWithDuration:0.1 angle:-90];
                [snakeSprite runAction:rot];
			 break;
		
		}
        
        
		float speed=50.0;
        CGPoint pos=ccp(X,Y);
        float duration=ccpDistance(pos, snakeSprite.position)/speed;
        
        id moveAction = [CCMoveTo actionWithDuration:duration position:ccp(X,Y)];
        
        [snakeSprite runAction:moveAction];
        
        self.touchEnabled = YES;
        
        [self scheduleUpdate];

    }
    return self;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace: touch];
    CGPoint diff = ccpSub(snakeSprite.position,location);
    
	[snakeSprite stopAllActions];
		
    CGPoint destination;
	
	CGSize winSize = [[CCDirector sharedDirector]winSize];
    CCRotateTo *rot;
    
    float speed=50.0;
    float duration=ccpDistance(location, snakeSprite.position)/speed;
    
    if(abs(diff.y)>=abs(diff.x))
    {
        if(diff.y>=0)
        {
            destination = ccp(snakeSprite.position.x,-300.0f);
            rot=[CCRotateTo actionWithDuration:0.1 angle:-90];
            [snakeSprite runAction:rot];
            id moveAction = [CCMoveTo actionWithDuration:duration position:destination];
            [snakeSprite runAction:moveAction];
            NSLog(@"down");
        }
        else
        {
            destination = ccp(snakeSprite.position.x ,winSize.height+300.0f);
            rot=[CCRotateTo actionWithDuration:0.1 angle:90];
            [snakeSprite runAction:rot];
    id moveAction = [CCMoveTo actionWithDuration:duration position:destination];
            [snakeSprite runAction:moveAction];
        NSLog(@"up");
        }
    
    
    }
    else
    {
        if(diff.x<=0)
        {
            destination = ccp(winSize.width+300.0f,snakeSprite.position.y);
            rot=[CCRotateTo actionWithDuration:0.1 angle:180];
            [snakeSprite runAction:rot];
            snakeSprite.flipY=YES;
            id moveAction = [CCMoveTo actionWithDuration:duration position:destination];
            [snakeSprite runAction:moveAction];
            NSLog(@"right");
        
        }
        else
        {
           destination = ccp(-300.0f,snakeSprite.position.y);
            rot=[CCRotateTo actionWithDuration:0.1 angle:0];
            [snakeSprite runAction:rot];
            snakeSprite.flipY=NO;         //   snakeSprite.flipX=YES;
            id moveAction = [CCMoveTo actionWithDuration:duration position:destination];
            [snakeSprite runAction:moveAction];
            NSLog(@"left");

        }
    
    
    }

 
    
	
}



-(void)update:(ccTime)delta
{
   
	CGSize size = [[CCDirector sharedDirector] winSize];
	
    
    if(snakeSprite.position.x-snakeSprite.contentSize.width/2<0||snakeSprite.position.x+snakeSprite.contentSize.width/2>size.width||snakeSprite.position.y-snakeSprite.contentSize.width/2<0||snakeSprite.position.y+snakeSprite.contentSize.width/2>size.height)
    {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScene node] ]];
    }
}

@end
