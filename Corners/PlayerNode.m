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
        _rotationPosition = 0;
        [self setupPhysicsBody];
    }
    
    return self;
}

-(instancetype)initWithShapeType:(kPlayerShapeType)type
{
    if (type == kPlayerShapeTypeTriangle)
    {
        if (self = [super initWithImageNamed:@"Triangle"]) {
            _rotationAngle = kPlayerAngleTriangle;
            _numCorners = 3;
        }
    }
    else if (type == kPlayerShapeTypeSquare)
    {
        
        if (self = [super initWithImageNamed:@"Square"]) {
            _rotationAngle = kPlayerAngleSquare;
            _numCorners = 4;
            _cornerMatchArray = [[NSMutableArray alloc] initWithCapacity:4];
            [_cornerMatchArray addObject:[[CornerMatchNode alloc] initWithCornerNumber:0 color:[SKColor redColor] position:[self makePositionFromRadius:87.5 angle:M_PI_2/2]]];
            [_cornerMatchArray addObject:[[CornerMatchNode alloc] initWithCornerNumber:1 color:[SKColor blueColor] position:[self makePositionFromRadius:87.5 angle:M_PI-M_PI_2/2]]];
            [_cornerMatchArray addObject:[[CornerMatchNode alloc] initWithCornerNumber:2 color:[SKColor yellowColor] position:[self makePositionFromRadius:87.5 angle:M_PI + M_PI_2/2]]];
            [_cornerMatchArray addObject:[[CornerMatchNode alloc] initWithCornerNumber:3 color:[SKColor greenColor] position:[self makePositionFromRadius:87.5 angle:2*M_PI - M_PI_2/2]]];
        }
    }
    else if (type == kPlayerShapeTypePentagon)
    {
        if (self = [super initWithImageNamed:@"Pentagon"]) {
            _rotationAngle = kPlayerAnglePentagon;
            _numCorners = 5;
        }
    }
    else if (type == kPlayerShapeTypeHexagon)
    {
        if (self = [super initWithImageNamed:@"Hexagon"]) {
            _rotationAngle = kPlayerAngleHexagon;
            _numCorners = 6;
        }
        
    }
    else if (type == kPlayerShapeTypeOctagon)
    {
        if (self = [super initWithImageNamed:@"Octagon"]) {
            _rotationAngle = kPlayerAngleOctagon;
            _numCorners = 8;
        }
    }
    
    if (self)
    {
        _shapeType = type;
        _isRotating = NO;
        _rotationPosition = 0;
        [self setupPhysicsBody];
        for (CornerMatchNode *cmn in _cornerMatchArray) { [self addChild:cmn]; }
        NSLog(@"self.frame.width = %f", self.frame.size.width);
        NSLog(@"self.frame.height = %f", self.frame.size.height);
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
    self.physicsBody.contactTestBitMask = 0x0;
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
        if (++self.rotationPosition >= self.numCorners)
        {
            self.rotationPosition = 0;
        }
    }
    else if (self.rotationDirection == kPlayerRotationDirectionCounterClockwise)
    {
        rotateAction = [SKAction rotateByAngle:_rotationAngle duration:0.2];
        if (--self.rotationPosition < 0 )
        {
            self.rotationPosition = (self.numCorners - 1);
        }
    }
    
    if (rotateAction)
    {
        [self runAction:rotateAction];
    }
}

- (CGPoint)makePositionFromRadius:(CGFloat)r angle:(CGFloat)q
{
    return CGPointMake(xPolar(87.5, q) + CGRectGetMidX(self.frame), yPolar(87.5, q) + CGRectGetMidY(self.frame));
}


@end
