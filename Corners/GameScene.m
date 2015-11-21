//
//  GameScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-10-19.
//  Copyright (c) 2015 Brandon Liebman. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    [self setBackgroundColor:[SKColor whiteColor]];
    
    self.rightButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"RightButton"];
    self.leftButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"LeftButton"];
    
    self.leftButtonNode.name = @"leftButton";
    
    [self.leftButtonNode setScale:1.15];
    [self.rightButtonNode setScale:1.15];
    
    [self.leftButtonNode setPosition:CGPointMake(CGRectGetMidX(self.frame) - self.leftButtonNode.frame.size.width/2, self.leftButtonNode.frame.size.height/2)];
    [self.rightButtonNode setPosition:CGPointMake(CGRectGetMidX(self.frame) + self.rightButtonNode.frame.size.width/2, self.rightButtonNode.frame.size.height/2)];
    
    self.playerNode = [[PlayerNode alloc] initWithShapeType:kPlayerShapeTypeSquare];
    [self.playerNode setPosition:CGPointMake(self.size.width/2, self.size.height/2 + self.leftButtonNode.frame.size.height/2)];
    
    [self addChild:self.rightButtonNode];
    [self addChild:self.leftButtonNode];
    [self addChild:self.playerNode];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    UITouch *buttonPress = [touches anyObject];
    CGPoint location = [buttonPress locationInNode:self];
    
    if ([self.leftButtonNode containsPoint:location])
    {
        NSLog(@"left button hit");
        //[self.playerNode.physicsBody setAngularVelocity:0];
        [self.playerNode beginRotatingWithDirection:kPlayerRotationDirectionCounterClockwise];
    }
    else if ([self.rightButtonNode containsPoint:location])
    {
        NSLog(@"right button hit");
        //[self.playerNode.physicsBody setAngularVelocity:0];
        [self.playerNode beginRotatingWithDirection:kPlayerRotationDirectionClockwise];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Stopping rotation...");
    [self.playerNode stopRotating];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
