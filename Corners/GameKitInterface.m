//
//  GameKitInterface.m
//  Corners
//
//  Created by Brandon Liebman on 2016-01-16.
//  Copyright © 2016 Brandon Liebman. All rights reserved.
//

#import "GameKitInterface.h"

@implementation GameKitInterface {
    BOOL _gameCenterEnabled;
}

NSString *const authenticateViewNotification = @"present_authentication_view_controller";
NSString *const showLeaderboardNotification = @"present_leaderboard_view_controller";

-(instancetype)init
{
    self = [super init];
    if (self) {
        _gameCenterEnabled = YES;
    }
    return self;
}

+(instancetype)sharedInterface
{
    static GameKitInterface *sharedInterface;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInterface = [[GameKitInterface alloc] init];
    });
    return sharedInterface;
}

-(void)authenticatePlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler =
    ^(UIViewController *viewController, NSError *error) {
        [self setInterfaceError: error];
        
        if (viewController != nil) {
            [self setAuthViewController:viewController];
        }
        else if ([GKLocalPlayer localPlayer].isAuthenticated) {
            _gameCenterEnabled = YES;
        }
        else {
            _gameCenterEnabled = NO;
        }
    };
}

-(void)setAuthViewController:(UIViewController *)authViewController
{
    if (authViewController != nil) {
        _authViewController = authViewController;
        [[NSNotificationCenter defaultCenter] postNotificationName:authenticateViewNotification object:self];
    }
}

-(void)setInterfaceError:(NSError *)interfaceError
{
    _interfaceError = [interfaceError copy];
    if (_interfaceError) {
        NSLog(@"GameKit Interface ERROR: %@", [[_interfaceError userInfo] description]);
    }
}

-(void)reportScore:(NSInteger)score;
{
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:kGameCenterLeaderboardDefault];
        gkScore.value = score;
        [GKScore reportScores:@[gkScore] withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"ERROR saving score to Game Center: %@", [[error userInfo] description]);
            }
        }];
    }
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
