//
//  StartScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-13.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"
#import "GameKitInterface.h"

@implementation StartScene

-(void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [SKColor whiteColor];
    
    self.nameLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.startButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.highScoreButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.gameCenterButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    
    NSUInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    
    [[self nameLabelNode] setText:@"Corners"];
    [[self startButtonNode] setText:@"Start"];
    [[self highScoreButtonNode] setText:[NSString stringWithFormat:@"High Score: %lu", highScore]];
    [[self gameCenterButtonNode] setText:@"Game Center"];
    
    [[self nameLabelNode] setFontColor:[SKColor blackColor]];
    [[self startButtonNode] setFontColor:[SKColor blackColor]];
    [[self highScoreButtonNode] setFontColor:[SKColor blackColor]];
    [[self gameCenterButtonNode] setFontColor:[SKColor blackColor]];
    
    [[self nameLabelNode] setFontSize:60];
    [[self startButtonNode] setFontSize:30];
    [[self highScoreButtonNode] setFontSize:20];
    [[self gameCenterButtonNode] setFontSize:20];
    
    [[self nameLabelNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 + 100)];
    [[self startButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    [[self highScoreButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 50)];
    [[self gameCenterButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 100)];
    
    self.startButtonNode.name = @"startButton";
    self.highScoreButtonNode.name = @"highScoreButton";
    self.gameCenterButtonNode.name = @"gameCenterButton";
    
    [self addChild:[self nameLabelNode]];
    [self addChild:[self startButtonNode]];
    [self addChild:[self highScoreButtonNode]];
    [self addChild:[self gameCenterButtonNode]];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *buttonPress = [touches anyObject];
    CGPoint location = [buttonPress locationInNode:self];
    SKNode *buttonLabel = [self nodeAtPoint:location];
    
    if (buttonLabel) {
        if ([_startButtonNode containsPoint:location])
        {
            GameScene *scene = [GameScene sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:1.0]];
        }
        else if ([_highScoreButtonNode containsPoint:location])
        {
            NSLog(@"High Scores button pressed");
        }
        else if ([_gameCenterButtonNode containsPoint:location])
        {
            NSLog(@"Game Center button pressed");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:showLeaderboardNotification object:self];
        }
    }
}

@end

















