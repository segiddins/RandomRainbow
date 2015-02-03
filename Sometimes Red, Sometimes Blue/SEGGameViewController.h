//
//  SEGGameViewController.h
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEGScoreManager.h"

@interface SEGGameViewController : UIViewController {
    @protected
    bool _paused;
    UIAlertView *_pauseView;
    NSInteger _counter;
    UILabel *_counterLabel;

}

@property UILabel *counterLabel;
@property UIButton *pauseButton;

- (void)pause:(id)sender;
- (void)unpause;
- (void)configureView;
- (void)endGame;
- (void)incrementCounter;
- (void)newGame;

@end
