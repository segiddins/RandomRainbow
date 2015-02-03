//
//  SEGArcadeViewController.h
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/8/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEGTimedGameViewController.h"

@interface SEGArcadeViewController : SEGTimedGameViewController {
    NSUInteger _maxBombs;
    NSUInteger _maxBombsPad;
    NSUInteger _minBombs;
}

@end
