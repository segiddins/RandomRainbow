//
//  SEGScoreManager.h
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEGScoreManager : NSObject

+ (SEGScoreManager *)sharedScoreManager;

- (void)authenticateLocalPlayer;

- (void)saveGallagherModeScore:(NSInteger)score withSender:(id)sender;
@property (readonly) NSInteger gallagherHighScore;

- (void)saveTimedModeScore:(NSInteger)score withSender:(id)sender;
@property (readonly) NSInteger timedHighScore;

- (void)saveArcadeModeScore:(NSInteger)score withSender:(id)sender;
@property (readonly) NSInteger arcadeHighScore;

- (void)saveArrigoModeScore:(NSInteger)score withSender:(id)sender;
@property (readonly) NSInteger arrigoHighScore;

@end
