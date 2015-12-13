//
//  GameOverScene.h
//  Corners
//
//  Created by Brandon Liebman on 2015-12-07.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "GameScene.h"

#import <SpriteKit/SpriteKit.h>

@interface GameOverScene : SKScene

@property (nonatomic) GameScene *gameScene;

+ (instancetype)sceneWithGameScene:(GameScene *)game size:(CGSize)size score:(NSUInteger)score high:(BOOL)high;

@end
