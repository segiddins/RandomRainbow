//
//  SEGTimedGameViewController.h
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGGameViewController.h"

@interface SEGTimedGameViewController : SEGGameViewController {
        NSInteger _gameLength;
}

@property UILabel *timerLabel;

- (void)updateOnTick;
- (void)endGame;

@end
