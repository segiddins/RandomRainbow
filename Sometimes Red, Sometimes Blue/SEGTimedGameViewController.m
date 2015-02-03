//
//  SEGTimedGameViewController.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGTimedGameViewController.h"

@interface SEGTimedGameViewController ()

@property NSTimer *gameTimer;

@end

@implementation SEGTimedGameViewController {
    NSDate *_pauseStart;
    NSDate *_previousFiringDate;
    NSInteger _timerCounter;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _gameLength = [self isMemberOfClass:SEGTimedGameViewController.class] ? 30 : _gameLength;
	// Do any additional setup after loading the view.
    CGRect timerFrame = CGRectMake(0, 15.0f, self.view.frame.size.width, 40.0f);
    _timerLabel = [[UILabel alloc] initWithFrame:timerFrame];
    _timerLabel.textAlignment = UITextAlignmentCenter;
    [_timerLabel setBackgroundColor:[UIColor clearColor]];
    _timerLabel.font = [UIFont systemFontOfSize:IS_IPAD ? 42.0f : 30.0f];
    [self newGame];    
}

- (void)newGame {
    [super newGame];
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    _timerCounter = 0;
    _timerLabel.textColor = [UIColor whiteColor];
    _paused = NO;
    [self.view addSubview:_timerLabel];
    [self updateOnTick];
}

- (void)timerTick:(id)sender
{
    if (!_paused && ++_timerCounter <= _gameLength) {
        [self updateOnTick];
    }
    if (_timerCounter == _gameLength) {
        [self endGame];
        UIAlertView *gameOverView = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                               message:[NSString stringWithFormat:@"Your score is: %d", _counter]
                                                              delegate:self
                                                     cancelButtonTitle:@"Quit"
                                                     otherButtonTitles:@"Play Again", nil];
        gameOverView.tag = 1;
        [gameOverView performSelector:@selector(show) withObject:nil afterDelay:1.0f];
    }
}

- (void)updateOnTick {
    self.timerLabel.text = [NSString stringWithFormat:@"%d:%.2d", (_gameLength - _timerCounter) / 60, (_gameLength - _timerCounter) % 60];
    if (_timerCounter >= _gameLength - 5) {
        self.timerLabel.textColor = [UIColor redColor];
    }
}

- (void)endGame
{
    NSLog(@"game over");
    _paused = YES;
    [self.gameTimer invalidate];
    _gameTimer = nil;
    if ([self isMemberOfClass:[SEGTimedGameViewController class]]) {
        [[SEGScoreManager sharedScoreManager] saveTimedModeScore:_counter withSender:self];
    }
}

- (void)pause:(id)sender
{
    [super pause:sender];
    _pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    _previousFiringDate = [self.gameTimer fireDate];
    [self.gameTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:INFINITY]];
}

- (void)unpause
{
    [super unpause];
    float pauseTime = -1*[_pauseStart timeIntervalSinceNow];
    [self.gameTimer setFireDate:[_previousFiringDate initWithTimeInterval:pauseTime sinceDate:_previousFiringDate]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
