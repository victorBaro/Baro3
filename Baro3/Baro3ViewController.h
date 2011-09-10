//
//  Baro3ViewController.h
//  Baro3
//
//  Created by Víctor Baro on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Baro3ViewController : UIViewController {
    CALayer *upNumber;
    CALayer *downNumber;
    CALayer *flipNumber1;
    CALayer *flipNumber2;
    int i;

}

- (void)suma;
- (IBAction)sumaAhora:(id)sender;



@end
