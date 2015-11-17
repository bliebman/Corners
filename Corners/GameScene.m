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
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"Square"];
    [self.player setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    SKAction *rotateAction = [SKAction rotateByAngle:M_PI duration:1.0];
    [self.player runAction:[SKAction repeatActionForever:rotateAction]];
    [self addChild:self.player];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
