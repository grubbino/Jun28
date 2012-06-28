//
//  View.m
//  Jun28
//
//  Created by Michael Grubb on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"
#include <stdlib.h>
#import "CoverView.h"

@implementation View

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        size = self.bounds.size;
        CGRect f = CGRectMake(-size.width, -size.height, size.width, size.height);
        coverview = [[CoverView alloc] initWithFrame: f];
        [self addSubview: coverview];
        NSString *string = @"11.111111 seconds";
		UIFont *font = [UIFont systemFontOfSize: 32];
		CGSize size2 = [string sizeWithFont: font];
        
		//Put upper left corner of label in upper left corner of View.
		//Make label just big enough to hold the string.
		CGRect f2 = CGRectMake(
                              size.width/2-size2.width/2,
                              size.height/2-size2.height/2,
                              size2.width,
                              size2.height
                              );
        
		label = [[UILabel alloc] initWithFrame: f2];
		label.backgroundColor = [UIColor blackColor];
		label.font = font;
        label.textColor = [UIColor whiteColor];
		[coverview addSubview: label];
        trial=0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect {
	min = MIN(size.width, size.height);
    squaresPerRow=8; // How big is the grid of possible locations?
    squareSep=15.0; // How many pixels in between the locations?
	squareDim = (min-(squareSep*(squaresPerRow+1)))/squaresPerRow; // Make the shpaes fit evenly in the row
    int pickSetSize =arc4random_uniform(5); 
    int setSize;
    int temp;
    Boolean uniqueFlag=false;
    if (pickSetSize==0) {
        setSize=5;
    } else if (pickSetSize==1) {
        setSize=9;
    } else if (pickSetSize==2) {
        setSize=17;
    } else if (pickSetSize==3) {
        setSize=33;
    } else if (pickSetSize==4) {
        setSize=49;
    }
   // NSLog(@"%d",setSize);
    
    NSInteger locations[setSize];
    
    for (NSInteger i = 0; i < setSize; i++) {
        while (uniqueFlag==false) {
            temp = arc4random_uniform(squaresPerRow*squaresPerRow);
            uniqueFlag=true;
            for (NSInteger j = 0; j < setSize; j++) {
                if (locations[j]==temp) {
                    uniqueFlag=false;
                    break;
                }
            } 
        }
        locations[i]=temp;
        uniqueFlag=false;
    }
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextBeginPath(c);
    CGContextRef d = UIGraphicsGetCurrentContext();
	CGContextBeginPath(d);
    int yPos=0;
    int xPos=0;
    int counter=0;
    int target =0;
   // NSLog(@"%d",target);
    for (yPos=0; yPos<squaresPerRow; ++yPos) {
        for (xPos=0; xPos<squaresPerRow; ++xPos) {
            for (NSInteger i = 0; i < setSize; i++){
                if (locations[i]==counter) {
                    CGRect square = CGRectMake((xPos*squareDim)+(xPos*squareSep)+squareSep, (yPos*squareDim)+(yPos*squareSep)+squareSep, squareDim, squareDim);
                    if (i==target) {
                        CGContextAddEllipseInRect(d, square);
                        CGContextSetRGBFillColor(d, 0.0, 1.0, 0.0, 1.0);
                        CGContextFillPath(d);
                        targetLocation.x=(xPos*squareDim)+(xPos*squareSep)+squareSep;
                        targetLocation.y=(yPos*squareDim)+(yPos*squareSep)+squareSep;
                    }
                    else if (i !=target && i <= ((setSize-1)/2)) {
                        CGContextAddEllipseInRect(c, square);
                        CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
                        CGContextFillPath(c);
                    }  else if (i !=target && i>((setSize-1)/2)) {
                        CGContextAddRect(d,square);
                        CGContextSetRGBFillColor(d, 0.0, 1.0, 0.0, 1.0);
                        CGContextFillPath(d);
                    }
                }
            }
            ++counter;
        }
    }
    start = [NSDate date];
    //[self performSelector:@selector(setNeedsDisplay) withObject:nil  afterDelay:2];
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	if (touches.count > 0) {
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInView:touch.view];
       // NSLog(@"x is %f, y is %f",touchLocation.x, touchLocation.y);
        if (abs((touchLocation.x)-(targetLocation.x+squareDim/2))<squareDim/2 && abs((touchLocation.y)-(targetLocation.y+squareDim/2))<squareDim/2) {
            timeInterval = [start timeIntervalSinceNow];
            ++trial;
            if (trial==1) {
                RT=-(timeInterval);
            } else {
            RT=-(timeInterval+2.0);
            }
            CGPoint centerPoint=CGPointMake(size.width/2, size.height/2);
            coverview.center= centerPoint;
            coverview.alpha=1;
            RTText=[NSString stringWithFormat:@"%f seconds", RT];
            label.text=RTText;
            [self setNeedsDisplay];
            [coverview performSelector:@selector(setAlpha:) withObject:0  afterDelay:2];
            //coverview.alpha=0;
        }

        
    }
}
@end
