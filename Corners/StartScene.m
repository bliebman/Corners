//
//  StartScene.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-13.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"

@implementation StartScene

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [SKColor whiteColor];
    
    self.nameLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.startButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.highScoreButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    self.settingsButtonNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
    
    [[self nameLabelNode] setText:@"Corners"];
    [[self startButtonNode] setText:@"Start"];
    [[self highScoreButtonNode] setText:@"High Scores"];
    [[self settingsButtonNode] setText:@"Settings"];
    
    [[self nameLabelNode] setFontColor:[SKColor blackColor]];
    [[self startButtonNode] setFontColor:[SKColor blackColor]];
    [[self highScoreButtonNode] setFontColor:[SKColor blackColor]];
    [[self settingsButtonNode] setFontColor:[SKColor blackColor]];
    
    [[self nameLabelNode] setFontSize:60];
    [[self startButtonNode] setFontSize:30];
    [[self highScoreButtonNode] setFontSize:20];
    [[self settingsButtonNode] setFontSize:20];
    
    [[self nameLabelNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 + 100)];
    [[self startButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    [[self highScoreButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 50)];
    [[self settingsButtonNode] setPosition:CGPointMake(self.size.width/2, self.size.height/2 - 100)];
    
    self.startButtonNode.name = @"startButton";
    self.highScoreButtonNode.name = @"highScoreButton";
    self.settingsButtonNode.name = @"settingsButton";
    
    [self addChild:[self nameLabelNode]];
    [self addChild:[self startButtonNode]];
    [self addChild:[self highScoreButtonNode]];
    [self addChild:[self settingsButtonNode]];

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
        else if ([_settingsButtonNode containsPoint:location])
        {
            NSLog(@"Settings button pressed");
        }
    }
}

@end

















