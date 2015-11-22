//
//  CornerNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-21.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "CornerNode.h"

@implementation CornerNode

- (instancetype)init
{
    if (self = [super initWithImageNamed:@"CornerSquare"])
    {
        _cornerType = kPlayerShapeTypeSquare;
        self.colorBlendFactor = 1.0;
        self.color = [SKColor blackColor];
        [self setZPosition:-1.0];
        [self setAnchorPoint:CGPointMake(0.39695, 0.60305)];
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
        self.colorBlendFactor = 1.0;
        self.color = [self getColorWithShape:type match:match];
        [self setAnchorPoint:CGPointMake(0.39695, 0.60305)];
        [self setZPosition:-1.0];
        [self setZRotation:(angle + M_PI + M_PI_4)];
    }

    return self;
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
