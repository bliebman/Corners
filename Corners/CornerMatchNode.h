//
//  CornerMatchNode.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-25.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CornerMatchNode : SKNode

@property (nonatomic, readonly) uint32_t cornerNumber;
@property (nonatomic, readonly) SKColor *cornerColor;

-(instancetype)initWithCornerNumber:(uint32_t)cornerNo color:(SKColor *)color position:(CGPoint)position;

@end
