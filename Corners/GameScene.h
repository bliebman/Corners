//
//  GameScene.h
//  Corners
//

//  Copyright (c) 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlayerNode.h"
#import "CornerNode.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) PlayerNode *playerNode;

@property (nonatomic) SKSpriteNode *leftButtonNode;
@property (nonatomic) SKSpriteNode *rightButtonNode;

@property (nonatomic) NSTimer *cornerTimer;

-(void)reset;

@end
