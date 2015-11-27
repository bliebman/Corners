//
//  PlayerNode.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-17.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CornerNode.h"
#import "CornerMatchNode.h"

@interface PlayerNode : SKSpriteNode

@property (nonatomic, readonly) kPlayerShapeType shapeType;

@property (nonatomic, readonly) uint32_t numCorners;
@property (nonatomic, readonly) CGFloat rotationAngle;
@property (nonatomic) int32_t rotationPosition;
@property (nonatomic) kPlayerRotationDirection rotationDirection;

@property (nonatomic) NSMutableArray *cornerMatchArray;

@property (nonatomic, readonly) bool isRotating;

- (instancetype)initWithShapeType:(kPlayerShapeType)shapeType;

- (void)beginRotatingWithDirection:(kPlayerRotationDirection)direction;

- (void)stopRotating;

@end
