//
//  SEGArcadeViewController.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGArcadeViewController.h"

@interface SEGArcadeViewController ()

@property NSMutableArray *xArray;

@end

@implementation SEGArcadeViewController {
    UIImage *_xImage;
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
    
	// Do any additional setup after loading the view.
    _xImage = [UIImage imageNamed:@"X"];
    _maxBombs = 15;
    _maxBombsPad = 25;
    _minBombs = 6;
    _gameLength = 60;
    
    [super viewDidLoad];
}

- (void)newGame
{
    
    _xArray = [NSMutableArray array];
    
    [super newGame];
}

- (void)updateOnTick {
    [super updateOnTick];
    for (int i = rand() % _minBombs + _minBombs - 6; i > 0; i--) {
        [self addBomb];
    }
    while (self.xArray.count > (IS_IPAD ? _maxBombsPad : _maxBombs)) {
        [(UIImageView *)[self.xArray objectAtIndex:0] removeFromSuperview];
        [self.xArray removeObjectAtIndex:0];
    }
    [self.view bringSubviewToFront:self.pauseButton];
    [self.view bringSubviewToFront:self.counterLabel];
    [self.view bringSubviewToFront:self.timerLabel];
}

- (void)addBomb {
    UIImageView *xView = [[UIImageView alloc] initWithImage:_xImage];
    NSUInteger size = IS_IPAD ? 80 : 40;
    xView.frame = CGRectMake(RAND_FLOAT * self.view.bounds.size.width - size / 2, RAND_FLOAT * self.view.bounds.size.height, size, size);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBomb:)];
    [tap setNumberOfTouchesRequired:1];
    [xView addGestureRecognizer:tap];
    [xView setUserInteractionEnabled:YES];
    [self.xArray addObject:xView];
    
    [self.view addSubview:xView];
}

- (void)tappedBomb:(id)sender {
    NSLog(@"tapped bomb");
    _counter -= 4;
    [self incrementCounter];
}

- (void)endGame {
    for (UIImageView *view in self.xArray) {
        view.gestureRecognizers = nil;
    }
    self.xArray = nil;
    [super endGame];
    if ([self isMemberOfClass:[SEGArcadeViewController class]]) {
        [[SEGScoreManager sharedScoreManager] saveArcadeModeScore:_counter withSender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
