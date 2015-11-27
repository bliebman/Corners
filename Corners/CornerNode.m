//
//  CornerNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-21.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "CornerNode.h"
#import "PlayerNode.h"

@interface CornerNode ()

- (void)setupPhysicsBody;

@end

@implementation CornerNode

- (instancetype)init
{
    if (self = [super initWithImageNamed:@"CornerSquare"])
    {
        _cornerType = kPlayerShapeTypeSquare;
        [self setupPhysicsBody];
        self.colorBlendFactor = 1.0;
        self.color = [SKColor blackColor];
        [self setZPosition:-1.0];
        [self setAnchorPoint:CGPointMake(0.39695, 0.60305)];
    }
    return self;
}

- (instancetype)initWithPlayer:(PlayerNode *)p position:(uint32_t)position;
{
    if (p.shapeType == kPlayerShapeTypeTriangle)
    {
        self = [super initWithImageNamed:@"CornerTriangle"];
        switch (position) {
            case 0:
                _attackAngle = M_PI_2;
                break;
            case 1:
                _attackAngle = 2*M_PI - M_PI_2/2;
                break;
            case 2:
                _attackAngle = M_PI + M_PI_2/2;
            default:
                break;
        }
    }
    else if (p.shapeType == kPlayerShapeTypeSquare)
    {
        self = [super initWithImageNamed:@"CornerSquare"];
        switch (position) {
            case 0:
                _attackAngle = M_PI_2/2;
                break;
            case 1:
                _attackAngle = 2*M_PI - M_PI_2/2;
                break;
            case 2:
                _attackAngle = M_PI + M_PI_2/2;
                break;
            case 3:
                _attackAngle = M_PI - M_PI_2/2;
                break;
            default:
                break;
        }

    }
    else if (p.shapeType == kPlayerShapeTypePentagon)
    {
        self = [super initWithImageNamed:@"CornerPentagon"];
    }
    else if (p.shapeType == kPlayerShapeTypeHexagon)
    {
        self = [super initWithImageNamed:@"CornerHexagon"];
    }
    else if (p.shapeType == kPlayerShapeTypeOctagon)
    {
        self = [super initWithImageNamed:@"CornerOctagon"];
    }
    
    if (self)
    {
        [self setupPhysicsBody];
        _attackPosition = position;
        [self setPlayer:p];
        [self setAnchorPoint:CGPointMake(0.39695, 0.60305)];
        
        CGPoint startPos = CGPointMake(xPolar(400, _attackAngle) + self.player.position.x, yPolar(400, _attackAngle) + self.player.position.y);
        [self setPosition:startPos];
        
        [self setColorBlendFactor:1.0];
        _colorNumber = arc4random_uniform(self.player.numCorners);
        CornerMatchNode *matchNode = (CornerMatchNode *)self.player.cornerMatchArray[_colorNumber];
        [self setColor:matchNode.cornerColor];
        
        [self setZPosition:-1.0];
        [self setZRotation:(_attackAngle + M_PI + M_PI_4)];
    }

    return self;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size center:CGPointMake(0, 0)];
    [self.physicsBody setCategoryBitMask:kPhysicsCategoryCorner];
    self.physicsBody.contactTestBitMask = kPhysicsCategoryCornerMatch;
    [self.physicsBody setCollisionBitMask:0x0];
}

- (SKColor*)getColorWithShape:(kPlayerShapeType)shape match:(NSUInteger)match
{
    SKColor *color = nil;
    if (kPlayerShapeTypeSquare) {
        switch (match) {
            case 0:
                color = [SKColor redColor];
                break;
            case 1:
                color = [SKColor greenColor];
                break;
            case 2:
                color = [SKColor yellowColor];
                break;
            case 3:
                color = [SKColor blueColor];
                break;
            default:
                break;
        }
    }
    return color;
}



@end
