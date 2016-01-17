//
//  GameScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-10-19.
//  Copyright (c) 2015 Brandon Liebman. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import "GameKitInterface.h"

@interface GameScene ()
{
    uint32_t score;
}

@property (nonatomic) SKLabelNode *scoreLabelNode;
-(void)deployCorner;
-(void)gameOver;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    // Set up the player and controls
    
    [self setBackgroundColor:[SKColor colorWithRed:0.007843 green:0.09412 blue:0.3529 alpha:1]];
    
    self.rightButtonNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.frame.size.width/2, self.size.height)];
    self.leftButtonNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.frame.size.width/2, self.size.height)];
    
    [self.leftButtonNode setPosition:CGPointMake(self.size.width/4, self.size.height/2)];
    [self.rightButtonNode setPosition:CGPointMake((3*self.size.width)/4, self.size.height/2)];
    
    self.leftButtonNode.strokeColor = [SKColor clearColor];
    self.rightButtonNode.strokeColor = [SKColor clearColor];
    
    self.playerNode = [[PlayerNode alloc] initWithShapeType:kPlayerShapeTypeSquare];
    [self.playerNode setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    [self.playerNode setScale:0.8];
    
    self.scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    [self.scoreLabelNode setText:@"Score: 0"];
    [self.scoreLabelNode setFontColor:[SKColor whiteColor]];
    [self.scoreLabelNode setFontSize:30];

    [self.scoreLabelNode setPosition:CGPointMake(80, 20)];

    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    [self addChild:self.rightButtonNode];
    [self addChild:self.leftButtonNode];
    [self addChild:self.playerNode];
    [self addChild:self.scoreLabelNode];
    
    score = 0;
    
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

    SKPhysicsBody *cornerMatchBody = (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB);
    SKPhysicsBody *cornerBody = (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ? contact.bodyB : contact.bodyA);
    CornerMatchNode *cornerMatch = (CornerMatchNode *)cornerMatchBody.node;
    CornerNode *corner = (CornerNode *)cornerBody.node;
    
    SKAction *waitAction = [SKAction waitForDuration:0.2];
    SKAction *sequence = [SKAction sequence:@[waitAction, [SKAction runBlock:^{
        [corner removeFromParent];
    }]]];
    
    [corner runAction:sequence];
    
    if (corner.colorNumber == cornerMatch.cornerNumber)
    {
        ++score;

        [self.scoreLabelNode setText:[NSString stringWithFormat:@"Score: %u", score]];
    }
    else
    {
        [corner runAction:[SKAction waitForDuration:0.5]];
        [self gameOver];
    }
}

-(void)deployCorner
{
    uint32_t cornerNumber = arc4random_uniform(self.playerNode.numCorners);
    
    CornerNode *corner = [[CornerNode alloc] initWithPlayer:self.playerNode position:cornerNumber];
    [corner setScale:0.7];
    
    [self addChild:corner];
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(self.playerNode.position.x, self.playerNode.position.y) duration:3.0];
    SKAction *sequence = [SKAction sequence:@[moveAction, [SKAction runBlock:^{
        [corner removeFromParent];
    }]]];
    
    [corner runAction:sequence];
}

-(void)gameOver
{
    [self.playerNode stopRotating];
    
    NSUInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    
    GameOverScene *gameOverScene;
    
    if ((!highScore) || (score > highScore))
    {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[GameKitInterface sharedInterface] reportScore:score];
        
        gameOverScene = [GameOverScene sceneWithGameScene:NULL size:self.size score:score high:YES];
    }
    else
    {
        gameOverScene = [GameOverScene sceneWithGameScene:NULL size:self.size score:score high:NO];
    }

    gameOverScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:gameOverScene transition:[SKTransition doorsCloseHorizontalWithDuration:1.0]];
}

-(void)reset
{
    score = 0;
}

@end
