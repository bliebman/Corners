//
//  CornerNode.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-21.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CornerNode : SKSpriteNode

@property (nonatomic) kPlayerShapeType cornerType;

@property (nonatomic) NSUInteger match;

- (instancetype)initWithShape:(kPlayerShapeType)type angle:(CGFloat)angle match:(NSUInteger)match;

@end
