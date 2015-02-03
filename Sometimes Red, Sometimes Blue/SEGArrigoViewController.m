//
//  SEGArrigoViewController.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/23/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGArrigoViewController.h"

@interface SEGArrigoViewController ()

@end

@implementation SEGArrigoViewController

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
    _maxBombs = 25;
    _maxBombsPad = 40;
    _minBombs = 9;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endGame {
    [super endGame];
    if ([self isMemberOfClass:[SEGArrigoViewController class]]) {
        [[SEGScoreManager sharedScoreManager] saveArrigoModeScore:_counter withSender:self];
    }
}

@end
