//
//  SEGMenuViewController.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SEGGameViewController.h"
#import "SEGTimedGameViewController.h"
#import "SEGArcadeViewController.h"
#import "SEGArrigoViewController.h"

@interface SEGMenuViewController ()

@end

@implementation SEGMenuViewController {
    
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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[SEGScoreManager sharedScoreManager] arcadeHighScore] < 300) {
        self.arrigoButton.hidden = TRUE;
    } else {
        self.arrigoButton.hidden = FALSE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startGallagherMode:(id)sender
{
    SEGGameViewController *gc = [[SEGGameViewController alloc] init];
    [self presentModalViewController:gc animated:YES];
}

- (IBAction)startTimedMode:(id)sender
{
    SEGTimedGameViewController *gc = [[SEGTimedGameViewController alloc] init];
    [self presentModalViewController:gc animated:YES];
}

- (IBAction)startArcadeMode:(id)sender {
    SEGArcadeViewController *gc = [[SEGArcadeViewController alloc] init];
    [self presentModalViewController:gc animated:YES];
}

- (IBAction)startArrigoMode:(id)sender {
    SEGArrigoViewController *gc = [[SEGArrigoViewController alloc] init];
    [self presentModalViewController:gc animated:YES];
}

- (void)viewDidUnload {
    [self setArrigoButton:nil];
    [super viewDidUnload];
}
@end
