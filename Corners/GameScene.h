//
//  GameScene.h
//  Corners
//

//  Copyright (c) 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlayerNode.h"

@interface GameScene : SKScene

@property (nonatomic) PlayerNode *playerNode;

@property (nonatomic) SKSpriteNode *leftButtonNode;
@property (nonatomic) SKSpriteNode *rightButtonNode;

@end
