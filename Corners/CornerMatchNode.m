//
//  CornerMatchNode.m
//  Corners
//
//  Created by Brandon Liebman on 2015-11-25.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import "CornerMatchNode.h"

@interface CornerMatchNode ()

-(void)setupPhysicsBodyAtPoint:(CGPoint)point;

@end

@implementation CornerMatchNode

-(instancetype)init
{
    if (self = [super init])
    {
        _cornerNumber = 0;
        [self setupPhysicsBodyAtPoint:CGPointMake(0, 0)];
    }
    
    return self;
}

-(instancetype)initWithCornerNumber:(uint32_t)cornerNo color:(SKColor *)color position:(CGPoint)position
{
    if (self = [super init])
    {
        _cornerNumber = cornerNo;
        _cornerColor = color;
        [self setupPhysicsBodyAtPoint:position];
        
    }
    
    return self;
}

-(void)setupPhysicsBodyAtPoint:(CGPoint)point
{
    NSLog(@"Setting up physics body...");
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:18.0 center:point];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = NO;
    
    [self.physicsBody setCategoryBitMask:kPhysicsCategoryCornerMatch];
    [self.physicsBody setCollisionBitMask:0x0];
    self.physicsBody.contactTestBitMask = kPhysicsCategoryCorner;
}


@end
