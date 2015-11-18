//
//  PlayerNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-17.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "PlayerNode.h"

@interface PlayerNode ()

- (void)setupPhysicsBody;

@end

@implementation PlayerNode

-(instancetype)init
{
    if (self = [super init])
    {
        self.isRotating = NO;
        self.shapeType = kPlayerShapeTypeSquare;
        [self setupPhysicsBody];
    }
    
    return self;
}

-(instancetype)initWithShapeType:(kPlayerShapeType)shapeType
{
    if (shapeType == kPlayerShapeTypeTriangle)
    {
        self = [super initWithImageNamed:@"Triangle"];
    }
    else if (shapeType == kPlayerShapeTypeSquare)
    {
        self = [super initWithImageNamed:@"Square"];
    }
    else if (shapeType == kPlayerShapeTypePentagon)
    {
        self = [super initWithImageNamed:@"Pentagon"];
    }
    else if (shapeType == kPlayerShapeTypeHexagon)
    {
        self = [super initWithImageNamed:@"Hexagon"];
    }
    else if (shapeType == kPlayerShapeTypeOctagon)
    {
        self = [super initWithImageNamed:@"Octagon"];
    }
    
    if (self) {
        self.isRotating = NO;
        [self setupPhysicsBody];
    }
    else
    {
        assert(false);
    }
    
    return self;
}

-(void)setupPhysicsBody
{
    NSLog(@"Setting up physics body...");
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = YES;
    [self.physicsBody setAngularDamping:0.7];
}

-(void)beginRotatingWithDirection:(kPlayerRotationDirection)direction
{
    self.isRotating = YES;
    
    while (self.isRotating)
    {
        if (direction == kPlayerRotationDirectionClockwise)
        {
            [self.physicsBody applyAngularImpulse:0.001];
        }
        else if (direction == kPlayerRotationDirectionCounterClockwise)
        {
            [self.physicsBody applyAngularImpulse:-0.001];
        }
    }
}


@end
