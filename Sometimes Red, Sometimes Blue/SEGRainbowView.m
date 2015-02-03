//
//  SEGRainbowView.m
//  Random Rainbow
//
//  Created by Samuel E. Giddins on 2/23/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGRainbowView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SEGRainbowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [self configGradient];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    drawLinearGradient(context, [[UIColor redColor] CGColor], [[UIColor blueColor] CGColor], self.bounds);
}

- (void)configGradient
{
    CGPoint topLeft = CGPointMake(0.0, 0.0);
    CGPoint bottomRight = CGPointMake(BOUNDS.size.width, BOUNDS.size.height);
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.startPoint = topLeft;
    gradientLayer.endPoint = bottomRight;
    NSArray *gradientColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]]; // ROYGBV
    gradientLayer.colors = gradientColors;
    UIGraphicsBeginImageContext(self.frame.size);
    [self drawLayer:gradientLayer inContext:UIGraphicsGetCurrentContext()];
    UIGraphicsEndImageContext();
}

void drawLinearGradient(CGContextRef context, CGColorRef color1, CGColorRef color2, CGRect rect) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGFloat locations[] = { 0.0, 0.2, 0.4, 0.6, 0.8, 1.0 };
    NSArray *colors = @[(__bridge id)[[UIColor redColor] CGColor], (__bridge id)[[UIColor orangeColor] CGColor], (__bridge id)[[UIColor yellowColor] CGColor], (__bridge id)[[UIColor greenColor] CGColor], (__bridge id)[[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0] CGColor], (__bridge id)[[UIColor blueColor] CGColor], (__bridge id)[[UIColor purpleColor] CGColor]]; // ROYGBIV
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, NULL);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    //  uncomment to see the rect outlined in yellow
    //    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:1.0] CGColor]);
    //    CGContextSetLineWidth(context, 2);
    //    CGContextStrokeRect(context, rect);
    
    CGContextSaveGState(context);
    
    CGContextAddRect(context, rect);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CFRelease(gradient);
    CFRelease(colorSpace);
}

void drawGlossyGradient(CGContextRef context, CGColorRef color1, CGColorRef color2, CGRect rect) {
    drawLinearGradient(context, color1, color2, rect);
    
    CGColorRef shineStartColor = [[UIColor colorWithWhite:1.0 alpha:0.65] CGColor];
    CGColorRef shineEndColor   = [[UIColor colorWithWhite:1.0 alpha:0.1] CGColor];
    
    CGRect shineRect = CGRectMake(CGRectGetMinX(rect),
                                  CGRectGetMinY(rect),
                                  CGRectGetWidth(rect),
                                  floorf(CGRectGetHeight(rect) / 2.0));
    
    drawLinearGradient(context, shineStartColor, shineEndColor, shineRect);
}


@end
