//
//  PlayerNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-17.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "PlayerNode.h"

@interface PlayerNode ()

@property (nonatomic) NSTimer *accelTimer;

- (void)setupPhysicsBody;

- (void)addTorque;

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
    [self.physicsBody setAngularDamping:0.1];
}

-(void)beginRotatingWithDirection:(kPlayerRotationDirection)direction
{
    self.isRotating = YES;
    
    self.rotationDirection = direction;
    
    [self.physicsBody applyAngularImpulse:(direction == kPlayerRotationDirectionClockwise ? -1 : 1)];
    
    self.accelTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(addTorque) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.accelTimer forMode:NSRunLoopCommonModes];
}

-(void)stopRotating
{
    [self.accelTimer invalidate];
    self.isRotating = NO;
    self.rotationDirection = -1;
    [self.physicsBody setAngularVelocity:0];
}

-(void)addTorque
{
    if (self.rotationDirection == kPlayerRotationDirectionClockwise)
    {
        if (self.physicsBody.angularVelocity < -10.0)
        {
            self.physicsBody.angularVelocity = -10.0;
        }
        else
        {
            [self.physicsBody applyAngularImpulse:-0.2];
        }
    }
    else if (self.rotationDirection == kPlayerRotationDirectionCounterClockwise)
    {
        if (self.physicsBody.angularVelocity > 10.0)
        {
            self.physicsBody.angularVelocity = 10.0;
        }
        else
        {
            [self.physicsBody applyAngularImpulse:0.2];
        }
    }
}


@end
