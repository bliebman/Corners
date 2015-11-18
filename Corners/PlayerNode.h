//
//  PlayerNode.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-17.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayerNode : SKSpriteNode

@property (nonatomic) kPlayerShapeType shapeType;

@property (nonatomic) bool isRotating;

- (instancetype)initWithShapeType:(kPlayerShapeType)shapeType;

- (void)beginRotatingWithDirection:(kPlayerRotationDirection)direction;

@end
