//
//  CornerNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-21.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "CornerNode.h"

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
        //[self setAnchorPoint:CGPointMake(1, 0)];
    }
    return self;
}

- (instancetype)initWithShape:(kPlayerShapeType)type angle:(CGFloat)angle match:(NSUInteger)match;
{
    if (type == kPlayerShapeTypeTriangle)
    {
        self = [super initWithImageNamed:@"CornerTriangle"];
    }
    else if (type == kPlayerShapeTypeSquare)
    {
        self = [super initWithImageNamed:@"CornerSquare"];
    }
    else if (type == kPlayerShapeTypePentagon)
    {
        self = [super initWithImageNamed:@"CornerPentagon"];
    }
    else if (type == kPlayerShapeTypeHexagon)
    {
        self = [super initWithImageNamed:@"CornerHexagon"];
    }
    else if (type == kPlayerShapeTypeOctagon)
    {
        self = [super initWithImageNamed:@"CornerOctagon"];
    }
    
    if (self)
    {
        [self setupPhysicsBody];
        self.colorBlendFactor = 1.0;
        self.color = [self getColorWithShape:type match:match];
        [self setAnchorPoint:CGPointMake(0.39695, 0.60305)];
        [self setZPosition:-1.0];
        [self setZRotation:(angle + M_PI + M_PI_4)];
    }

    return self;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size center:CGPointMake(0, 0)];
    [self.physicsBody setCategoryBitMask:kPhysicsCategoryCorner];
    self.physicsBody.contactTestBitMask = kPhysicsCategoryPlayer;
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
