//
//  Jun28AppDelegate.h
//  Jun28
//
//  Created by NYU User on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;
@class CoverView;

@interface Jun28AppDelegate : UIResponder <UIApplicationDelegate> {
    View *view;
    UIWindow *_window;
}
@property (strong, nonatomic) UIWindow *window;

@end

