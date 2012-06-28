//
//  View.h
//  Jun28
//
//  Created by Michael Grubb on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoverView;
CGSize size ;
CGFloat min;
int squaresPerRow; // How big is the grid of possible locations?
CGFloat squareSep; // How many pixels in between the locations?
CGFloat squareDim; // Make the shpaes fit evenly in the row
CGPoint targetLocation;
NSDate *start;
NSTimeInterval timeInterval;
CGFloat RT;
int trial;
NSString *RTText;
@interface View : UIView {
    CoverView *coverview;
    UILabel *label;
}
@end
