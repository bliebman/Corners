//
//  GameScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-10-19.
//  Copyright (c) 2015 Brandon Liebman. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

-(void)deployCorner;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    // Set up the player and controls
    
    [self setBackgroundColor:[SKColor blackColor]];
    
    self.rightButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"RightButton"];
    self.leftButtonNode = [SKSpriteNode spriteNodeWithImageNamed:@"LeftButton"];
    
    self.leftButtonNode.name = @"leftButton";
    
    [self.leftButtonNode setScale:1.15];
    [self.rightButtonNode setScale:1.15];
    
    [self.leftButtonNode setPosition:CGPointMake(CGRectGetMidX(self.frame) - self.leftButtonNode.frame.size.width/2, self.leftButtonNode.frame.size.height/2)];
    [self.rightButtonNode setPosition:CGPointMake(CGRectGetMidX(self.frame) + self.rightButtonNode.frame.size.width/2, self.rightButtonNode.frame.size.height/2)];
    
    self.playerNode = [[PlayerNode alloc] initWithShapeType:kPlayerShapeTypeSquare];
    [self.playerNode setPosition:CGPointMake(self.size.width/2, self.size.height/2 + self.leftButtonNode.frame.size.height/2)];
    [self.playerNode setScale:0.8];

    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    [self addChild:self.rightButtonNode];
    [self addChild:self.leftButtonNode];
    [self addChild:self.playerNode];
    
    self.cornerTimer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(deployCorner) userInfo:nil repeats:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    UITouch *buttonPress = [touches anyObject];
    CGPoint location = [buttonPress locationInNode:self];
    
    if ([self.leftButtonNode containsPoint:location])
    {
        NSLog(@"left button hit");
        [self.playerNode beginRotatingWithDirection:kPlayerRotationDirectionCounterClockwise];
    }
    else if ([self.rightButtonNode containsPoint:location])
    {
        NSLog(@"right button hit");
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
    if ([self.playerNode isRotating])
    {
        UITouch *buttonPress = [touches anyObject];
        CGPoint location = [buttonPress locationInNode:self];
        if ([self.leftButtonNode containsPoint:location] && ([self.playerNode rotationDirection] == kPlayerRotationDirectionClockwise))
        {
            NSLog(@"moved to left button");
            [self.playerNode stopRotating];
            [self.playerNode beginRotatingWithDirection:kPlayerRotationDirectionCounterClockwise];
        }
        else if ([self.rightButtonNode containsPoint:location] && ([self.playerNode rotationDirection] == kPlayerRotationDirectionCounterClockwise))
        {
            NSLog(@"moved to right button");
            [self.playerNode stopRotating];
            [self.playerNode beginRotatingWithDirection:kPlayerRotationDirectionClockwise];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *cornerBody = (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB);
    CornerNode *corner = (CornerNode *)cornerBody.node;
    
    NSLog(@"Corner contact with match# %lu", (unsigned long)corner.match);
    SKAction *waitAction = [SKAction waitForDuration:0.25];
    SKAction *sequence = [SKAction sequence:@[waitAction, [SKAction runBlock:^{
        [corner removeFromParent];
    }]]];
    [corner runAction:sequence];
}

-(void)didEndContact:(SKPhysicsContact *)contact
{

}

-(void)deployCorner
{
    NSLog(@"Setting up corner...");
    
    NSUInteger matchNumber = arc4random_uniform(self.playerNode.numCorners);
    NSUInteger cornerNumber = arc4random_uniform(self.playerNode.numCorners);
    
    CGFloat startAngle = self.playerNode.rotationAngle/2 + (cornerNumber + 1)*self.playerNode.rotationAngle;
    
    CGPoint startPos = CGPointMake(xPolar(400, startAngle) + self.playerNode.position.x, yPolar(400, startAngle) + self.playerNode.position.y);
    
    NSLog(@"startAngle=%f", startAngle*(180.0/M_PI));
    
    CornerNode *corner = [[CornerNode alloc] initWithShape:self.playerNode.shapeType angle:startAngle match:matchNumber];
    [corner setPosition:startPos];
    [corner setScale:0.7];
    [self addChild:corner];
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(self.playerNode.position.x, self.playerNode.position.y) duration:3.0];
    SKAction *sequence = [SKAction sequence:@[moveAction, [SKAction runBlock:^{
        [corner removeFromParent];
    }]]];
    
    [corner runAction:sequence];
}

@end
