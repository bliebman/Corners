//
//  CornerNode.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-21.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class PlayerNode;

@interface CornerNode : SKSpriteNode

@property (nonatomic) PlayerNode *player;

@property (nonatomic) kPlayerShapeType cornerType;

@property (nonatomic, readonly) CGFloat attackAngle;
@property (nonatomic, readonly) uint32_t attackPosition;
@property (nonatomic, readonly) uint32_t colorNumber;

- (instancetype)initWithPlayer:(PlayerNode *)p position:(uint32_t)position;

@end
