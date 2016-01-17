//
//  GameKitInterface.h
//  Corners
//
//  Created by Brandon Liebman on 2016-01-16.
//  Copyright © 2016 Brandon Liebman. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GameKit;

@interface GameKitInterface : NSObject <GKGameCenterControllerDelegate>

extern NSString *const authenticateViewNotification;
extern NSString *const showLeaderboardNotification;

@property (nonatomic, readonly) UIViewController *authViewController;
@property (nonatomic) NSError *interfaceError;

+ (instancetype)sharedInterface;

-(void)authenticatePlayer;

-(void)reportScore:(NSInteger)score;

@end
