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

@end

@implementation GameOverScene

+(instancetype)sceneWithSize:(CGSize)size score:(NSUInteger)score high:(BOOL)high
{
    GameOverScene *thisScene = [GameOverScene sceneWithSize:size];
    
    thisScene.backgroundColor = [SKColor blackColor];
    
    thisScene.gameOverLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    [[thisScene gameOverLabelNode] setText:@"Game Over"];
    [[thisScene gameOverLabelNode] setFontColor:[SKColor whiteColor]];
    [[thisScene gameOverLabelNode] setFontSize:60];
    [[thisScene gameOverLabelNode] setPosition:CGPointMake(size.width/2, size.height/2 + 100)];
    
    [thisScene addChild:[thisScene gameOverLabelNode]];
    
    return thisScene;
}

@end
