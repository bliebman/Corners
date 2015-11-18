//
//  corners_defines.h
//  Corners
//
//  Created by Brandon Liebman on 2015-11-17.
//  Copyright © 2015 Brandon Liebman. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef corners_defines_h
#define corners_defines_h

typedef enum PlayerRotationDirection
{
    kPlayerRotationDirectionClockwise,
    kPlayerRotationDirectionCounterClockwise
} kPlayerRotationDirection;

typedef enum PlayerShapeType
{
    kPlayerShapeTypeTriangle,
    kPlayerShapeTypeSquare,
    kPlayerShapeTypePentagon,
    kPlayerShapeTypeHexagon,
    kPlayerShapeTypeOctagon
} kPlayerShapeType;

#endif /* corners_defines_h */
