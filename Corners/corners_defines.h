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

#define kPlayerAngleTriangle    (2.0/3.0)*M_PI
#define kPlayerAngleSquare      M_PI_2
#define kPlayerAnglePentagon    (2.0/5.0)*M_PI
#define kPlayerAngleHexagon     M_PI/3.0
#define kPlayerAngleOctagon     M_PI/4.0

#define kNumCornersTriangle     3
#define kNumCornersSquare       4
#define kNumCornersHexagon      6
#define kNumCornersOctagon      8

#define kPhysicsCategoryPlayer          0x1
#define kPhysicsCategoryCorner          0x1 << 1
#define kPhysicsCategoryCornerMatch     0x1 << 2

#define xPolar(r,q) (r)*cosf(q)
#define yPolar(r,q) (r)*sinf(q)

#define kGameCenterLeaderboardDefault @"grp.CornerMatchesBoard"

typedef enum PlayerRotationDirection
{
    kPlayerRotationDirectionClockwise,
    kPlayerRotationDirectionCounterClockwise
} kPlayerRotationDirection;

typedef enum PlayerShapeType
{
    kPlayerShapeTypeTriangle,
    kPlayerShapeTypeSquare,
    kPlayerShapeTypeHexagon,
    kPlayerShapeTypeOctagon
} kPlayerShapeType;

#endif /* corners_defines_h */
