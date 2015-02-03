//
//  SEGGameViewController.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGGameViewController.h"

@interface SEGGameViewController () <UIAlertViewDelegate>

@property NSInteger counter;

@end

@implementation SEGGameViewController

@synthesize counter = _counter;
@synthesize counterLabel = _counterLabel;

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
	// Do any additional setup after loading the view.
    [self configureView];

}

- (void)newGame {
    _paused = NO;
    [self configureView];
    _counter = 0;
}

- (void)configureView
{
    _counterLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    _counterLabel.backgroundColor = [UIColor clearColor];
    _counterLabel.textColor = [UIColor whiteColor];
    _counterLabel.textAlignment = NSTextAlignmentCenter;
    _counterLabel.text = [NSString stringWithFormat:@"%d", [self initialCounterValue]];
    _counterLabel.font = [UIFont systemFontOfSize: ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 45 : 33];
    
    // Override point for customization after application launch.
    self.view = [[UIView alloc] initWithFrame:BOUNDS];
    [self setColor];
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.frame];
    [button addTarget:self action:@selector(setColor) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor: [UIColor clearColor]];
    
    
    _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pauseButton addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [_pauseButton setFrame:CGRectMake(0, 0, IS_IPAD ? 75 : 50, IS_IPAD ? 75 : 50)];
    [_pauseButton setTitle:@"| |" forState:UIControlStateNormal];
    [_pauseButton.titleLabel setFont:[UIFont systemFontOfSize:IS_IPAD ? 35 : 25]];
    _pauseButton.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:button];
    [self.view addSubview:_pauseButton];
    [self.view addSubview:_counterLabel];
}

- (NSInteger)initialCounterValue
{
    if ([self isMemberOfClass:[SEGGameViewController class]]) {
        return _counter = [[SEGScoreManager sharedScoreManager] gallagherHighScore];
    }
    else
        return _counter = 0;
}

- (void)pause:(id)sender
{
    _paused = YES;
    _pauseView = [[UIAlertView alloc] initWithTitle:@"Paused"
                                             message:nil
                                            delegate:self
                                   cancelButtonTitle:@"Return to Game"
                                   otherButtonTitles:[self isMemberOfClass:SEGGameViewController.class] ? @"Go to Main Menu" : @"Quit", nil];
    _pauseView.tag = 0;
    [_pauseView show];
    NSLog(@"paused");
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 0) { // return to game
        [self unpause];
    } else if (buttonIndex == 1 && alertView.tag == 1) {
        [self newGame];
    } else if (buttonIndex == 1 && alertView.tag == 0) { // quit
        [self endGame];
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else if (buttonIndex == 0 && alertView.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)unpause
{
    _paused = NO;
}

- (void)endGame
{
    if ([self isMemberOfClass:[SEGGameViewController class]]) {
        NSLog(@"sam g will dissapear");
        [[SEGScoreManager sharedScoreManager] saveGallagherModeScore:_counter withSender:self];
    }
}

- (void)setColor
{
    if (!_paused) {
        [self incrementCounter];
        UIColor *color = [[UIColor alloc] initWithRed:RAND_FLOAT green:RAND_FLOAT blue:RAND_FLOAT alpha:1.0];
        self.view.backgroundColor = color;
    }
}

- (void)incrementCounter
{
    self.counter++;
    _counterLabel.text = [NSString stringWithFormat:@"%d", self.counter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end
