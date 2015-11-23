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

- (void)rotate;

@end

@implementation PlayerNode

-(instancetype)init
{
    if (self = [super initWithImageNamed:@"Square"])
    {
        _isRotating = NO;
        _shapeType = kPlayerShapeTypeSquare;
        _rotationAngle = kPlayerAngleSquare;
        [self setupPhysicsBody];
    }
    
    return self;
}

-(instancetype)initWithShapeType:(kPlayerShapeType)type
{
    if (type == kPlayerShapeTypeTriangle)
    {
        self = [super initWithImageNamed:@"Triangle"];
        _rotationAngle = kPlayerAngleTriangle;
        _numCorners = 3;
    }
    else if (type == kPlayerShapeTypeSquare)
    {
        self = [super initWithImageNamed:@"Square"];
        _rotationAngle = kPlayerAngleSquare;
        _numCorners = 4;
    }
    else if (type == kPlayerShapeTypePentagon)
    {
        self = [super initWithImageNamed:@"Pentagon"];
        _rotationAngle = kPlayerAnglePentagon;
        _numCorners = 5;
    }
    else if (type == kPlayerShapeTypeHexagon)
    {
        self = [super initWithImageNamed:@"Hexagon"];
        _rotationAngle = kPlayerAngleHexagon;
        _numCorners = 6;
    }
    else if (type == kPlayerShapeTypeOctagon)
    {
        self = [super initWithImageNamed:@"Octagon"];
        _rotationAngle = kPlayerAngleOctagon;
        _numCorners = 8;
    }
    
    if (self)
    {
        _shapeType = type;
        _isRotating = NO;
        [self setupPhysicsBody];
    }
    else
    {
        assert(false);
    }
    
    return self;
}

#pragma mark -
#pragma mark Physics Setup

-(void)setupPhysicsBody
{
    NSLog(@"Setting up physics body...");
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = YES;
    
    [self.physicsBody setCategoryBitMask:kPhysicsCategoryPlayer];
    [self.physicsBody setCollisionBitMask:0x0];
    [self.physicsBody setAngularDamping:0.1];
    self.physicsBody.contactTestBitMask = kPhysicsCategoryCorner;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

-(void)beginRotatingWithDirection:(kPlayerRotationDirection)direction
{
    _isRotating = YES;
    
    self.rotationDirection = direction;
    
    [self rotate];
    
    self.accelTimer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.accelTimer forMode:NSRunLoopCommonModes];
}

-(void)stopRotating
{
    [self.accelTimer invalidate];
    _isRotating = NO;
    self.rotationDirection = -1;
}

-(void)rotate
{
    SKAction *rotateAction;
    
    if (self.rotationDirection == kPlayerRotationDirectionClockwise)
    {
        rotateAction = [SKAction rotateByAngle:-_rotationAngle duration:0.2];
    }
    else if (self.rotationDirection == kPlayerRotationDirectionCounterClockwise)
    {
        rotateAction = [SKAction rotateByAngle:_rotationAngle duration:0.2];
    }
    
    if (rotateAction)
    {
        [self runAction:rotateAction];
    }
}


@end
