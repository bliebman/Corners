//
//  GameOverScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-12-07.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "GameOverScene.h"

@interface GameOverScene ()

@property (nonatomic) SKLabelNode *gameOverLabelNode;
@property (nonatomic) SKLabelNode *restartLabelNode;
@property (nonatomic) SKLabelNode *scoreLabelNode;

@end

@implementation GameOverScene

+ (instancetype)sceneWithGameScene:(GameScene *)game size:(CGSize)size score:(NSUInteger)score high:(BOOL)high
{
    GameOverScene *thisScene = [GameOverScene sceneWithSize:size];
    
    thisScene.gameScene = game;
    
    thisScene.backgroundColor = [SKColor blackColor];
    
    thisScene.gameOverLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    [[thisScene gameOverLabelNode] setText:@"Game Over"];
    [[thisScene gameOverLabelNode] setFontColor:[SKColor whiteColor]];
    [[thisScene gameOverLabelNode] setFontSize:60];
    [[thisScene gameOverLabelNode] setPosition:CGPointMake(size.width/2, size.height/2 + 100)];
    
    thisScene.restartLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    [[thisScene restartLabelNode] setText:@"Restart"];
    [[thisScene restartLabelNode] setFontColor:[SKColor whiteColor]];
    [[thisScene restartLabelNode] setFontSize:40];
    [[thisScene restartLabelNode] setPosition:CGPointMake((3*size.width)/4 - 10, size.height/2 - 30)];
    
    thisScene.scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    [[thisScene scoreLabelNode] setText:[NSString stringWithFormat:@"Score: %lu", (unsigned long)score]];
    [[thisScene scoreLabelNode] setFontColor:[SKColor whiteColor]];
    [[thisScene scoreLabelNode] setFontSize:40];
    [[thisScene scoreLabelNode] setPosition:CGPointMake((size.width)/4 + 10, size.height/2 - 30)];
    
    [thisScene addChild:[thisScene gameOverLabelNode]];
    [thisScene addChild:[thisScene restartLabelNode]];
    [thisScene addChild:[thisScene scoreLabelNode]];
    
    return thisScene;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *buttonPress = [touches anyObject];
    CGPoint location = [buttonPress locationInNode:self];
    SKNode *buttonLabel = [self nodeAtPoint:location];
    
    if (buttonLabel) {
        if ([_restartLabelNode containsPoint:location])
        {
            GameScene *newGameScene = [GameScene sceneWithSize:self.size];
            newGameScene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:newGameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
        }

    }
}

@end
