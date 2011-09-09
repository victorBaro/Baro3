//
//  Baro3AppDelegate.h
//  Baro3
//
//  Created by Víctor Baro on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Baro3ViewController;

@interface Baro3AppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Baro3ViewController *viewController;

@end
