//
//  SEGScoreManager.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGScoreManager.h"
#import <GameKit/GameKit.h>

@implementation SEGScoreManager {
    id _sendingViewController;
}

+ (SEGScoreManager *)sharedScoreManager
{
    static SEGScoreManager *sharedScoreManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedScoreManager = [[SEGScoreManager alloc] init];
    });
    return sharedScoreManager;
}

- (NSInteger)gallagherHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:GALLAGHER_LEADERBOARD];
}

- (void)saveGallagherModeScore:(NSInteger)score withSender:(id)sender
{
    CLSNSLog(@"saving sam g score");
    _sendingViewController = (UIViewController *)sender;
    [self authenticateLocalPlayer];
    [self reportScore:score forLeaderboardID:GALLAGHER_LEADERBOARD];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:score forKey:GALLAGHER_LEADERBOARD];
}

- (NSInteger)timedHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:TIMED_LEADERBOARD];
}

- (void)saveTimedModeScore:(NSInteger)score withSender:(id)sender
{
    CLSNSLog(@"saving timed score");
    _sendingViewController = (UIViewController *)sender;
    [self authenticateLocalPlayer];
    [self reportScore:score forLeaderboardID:TIMED_LEADERBOARD];
    if (score > self.timedHighScore) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:score forKey:TIMED_LEADERBOARD];
    }
}

- (void)saveArcadeModeScore:(NSInteger)score withSender:(id)sender
{
    CLSNSLog(@"saving arcade score");
    _sendingViewController = (UIViewController *)sender;
    [self authenticateLocalPlayer];
    [self reportScore:score forLeaderboardID:ARCADE_LEADERBOARD];
    if (score > self.arcadeHighScore) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:score forKey:ARCADE_LEADERBOARD];
    }
}

- (NSInteger)arcadeHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:ARCADE_LEADERBOARD];
}

- (void)saveArrigoModeScore:(NSInteger)score withSender:(id)sender
{
    CLSNSLog(@"saving arcade score");
    _sendingViewController = (UIViewController *)sender;
    [self authenticateLocalPlayer];
    [self reportScore:score forLeaderboardID:ARRIGO_LEADBOARD];
    if (score > self.arrigoHighScore) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:score forKey:ARRIGO_LEADBOARD];
    }
}

- (NSInteger)arrigoHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:ARRIGO_LEADBOARD];
}

- (void)authenticateLocalPlayer
{
    GKLocalPlayer.localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        if (error != nil) {
            CLSNSLog(@"Error: %@", error);
        }
        if (viewController != nil)
        {
            CLSNSLog(@"local player view controller not nil, presented");
            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:viewController animated:YES completion:NULL];
        }
        else if (GKLocalPlayer.localPlayer.isAuthenticated)
        {
            CLSNSLog(@"local player authenticated");
//            [Crashlytics setUserName:localPlayer.displayName];
//            [Crashlytics setUserIdentifier:localPlayer.playerID];
            [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
                if (error != nil) {
                    CLSNSLog(@"ERROR: %@", error.localizedDescription);
                    return;
                }
                NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
                for (GKLeaderboard *lb in leaderboards) {
                    [lb loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
                        NSLog(@"%@: %lld", lb.title, lb.localPlayerScore.value);
                        if ([defs integerForKey:lb.category] < lb.localPlayerScore.value) {
                            [defs setInteger:lb.localPlayerScore.value forKey:lb.category];
                        }
                    }];
                }
            }];
        }
        else
        {
            CLSNSLog(@"game center diasbled");
        }
    };
    CLSNSLog(@"trying to auth game center");
}

- (void) reportScore:(int64_t)score forLeaderboardID: (NSString*) category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    CLSNSLog(@"reporting score: %lld", score);
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil) {
            CLSNSLog(@"Error reporting score: %@", error);
        }
        else
            CLSNSLog(@"Reported score");
    }];
}

@end
