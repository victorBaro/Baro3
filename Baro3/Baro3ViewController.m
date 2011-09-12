//
//  Baro3ViewController.m
//  Baro3
//
//  Created by Víctor Baro on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Baro3ViewController.h"

@implementation Baro3ViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Crear parte superior del número
    upNumber = [CALayer layer];
    upNumber.bounds = CGRectMake(0.0, 0.0, 100.0, 100.0);
    upNumber.backgroundColor = [[UIColor blackColor] CGColor];
    upNumber.anchorPoint = CGPointMake(0.0, 1.0);
    upNumber.position = CGPointMake(([[self view]bounds].size.width/2)-50.0, ([[self view]bounds].size.height/3.0)+5);
    upNumber.cornerRadius = 10.0;
    upNumber.borderWidth = 2.0;
    upNumber.borderColor =[[UIColor blackColor] CGColor];
    
    upNumber.contents = (id) [UIImage imageNamed:@"sup1.png"].CGImage;
    upNumber.masksToBounds = YES;
    
    [[[self view] layer] addSublayer:upNumber];
    
    
    
    //Crear la parte que se mueve superior
    flipNumber1 = [CALayer layer];
    flipNumber1.bounds = CGRectMake(0.0, 0.0, 100.0, 100.0);
    flipNumber1.backgroundColor = [[UIColor blackColor] CGColor];
    flipNumber1.anchorPoint = CGPointMake(0.0, 1.0);
    flipNumber1.position = CGPointMake(([[self view]bounds].size.width/2)-50.0, ([[self view]bounds].size.height/3.0)+5);
    flipNumber1.cornerRadius = 10.0;
    flipNumber1.borderWidth = 2.0;
    flipNumber1.borderColor =[[UIColor blackColor] CGColor];
    
    flipNumber1.contents = (id) [UIImage imageNamed:@"sup0.png"].CGImage;
    flipNumber1.masksToBounds = YES;
    
    [[[self view] layer] addSublayer:flipNumber1];

    
    
    
    
        
    
    //creamos parte inferior
    downNumber = [CALayer layer];
    downNumber.bounds = CGRectMake(0.0, 0.0, 100.0, 100.0);
    downNumber.backgroundColor = [[UIColor blackColor] CGColor];
    downNumber.anchorPoint = CGPointMake(0.0, 0.0);
    downNumber.position = CGPointMake(([[self view]bounds].size.width/2)-50.0, ([[self view]bounds].size.height/3.0)+5);
    downNumber.cornerRadius = 10.0;
    downNumber.borderWidth = 2.0;
    downNumber.borderColor =[[UIColor blackColor] CGColor];
    
    downNumber.contents = (id) [UIImage imageNamed:@"inf0.png"].CGImage;
    downNumber.masksToBounds = YES;
    
    [[[self view] layer] addSublayer:downNumber];
    
    
    //Parte inferior que se mueve
    flipNumber2 = [CALayer layer];
    flipNumber2.bounds = CGRectMake(0.0, 0.0, 100.0, 100.0);
    flipNumber2.backgroundColor = [[UIColor blackColor] CGColor];
    flipNumber2.anchorPoint = CGPointMake(0.0, 0.0);
    flipNumber2.position = CGPointMake(([[self view]bounds].size.width/2)-50.0, ([[self view]bounds].size.height/3.0)+5);
    flipNumber2.cornerRadius = 10.0;
    flipNumber2.borderWidth = 2.0;
    flipNumber2.borderColor =[[UIColor blackColor] CGColor];
    flipNumber2.hidden = YES;
    
    flipNumber2.contents = (id) [UIImage imageNamed:@"inf1.png"].CGImage;
    flipNumber2.masksToBounds = YES;
    
    [[[self view] layer] addSublayer:flipNumber2];
    
}


- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





- (void)suma{
    //Primer estado: Top To Middle    
    //Ahora se crea el estado final para poder definirlo más adelante
    CATransform3D rotate1 = CATransform3DIdentity;
    rotate1.m34 = -1.0/300.0;
    rotate1 = CATransform3DRotate(rotate1, M_PI/2, -1.0, 0.0, 0.0);

    //Creamos una basic animation que es una animación de un estado a otro
    CABasicAnimation *upRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //No hace falta darle el estado inicial porque es con el que se inicia
    upRotation.fromValue = [NSValue valueWithCATransform3D:[flipNumber1 transform]];
    upRotation.toValue = [NSValue valueWithCATransform3D:rotate1];
    upRotation.duration = 0.25;
    //Es importante la siguiente! Si no lo ponemos, la animación vuelve al estado inicial.
    upRotation.removedOnCompletion = NO;
    //Importante!! Con fillMode FORWARDS estamos diciendo que la animación debe congelarse en su estado final!
    upRotation.fillMode = kCAFillModeForwards;
    
    
    
    //Se inicia la animación cuando le enviamos el mensaje a la CALayer
    [flipNumber1 addAnimation:upRotation forKey:@"transform"];



    
    //Segundo estado: Middle to bottom
    CABasicAnimation *downRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotate2 = CATransform3DIdentity;
    rotate2.m34 = -1.0/300.0;
    rotate2 = CATransform3DRotate(rotate2, -M_PI/2, -1.0, 0.0, 0.0);
    //Esta segunda animación, va desde el estado inicial de la primera, osea un ángulo girado de 90º, hasta su estaado final que es el flipNumber2 tal cual
    downRotation.fromValue = [NSValue valueWithCATransform3D:rotate2];
    downRotation.toValue = [NSValue valueWithCATransform3D:[flipNumber2 transform]];
    downRotation.duration = 0.25;
    downRotation.removedOnCompletion = NO;
    //MUY IMPORTANTE: con esta frase estamos diciendo que la animación2 inicia cuando acabe la primera!!
    downRotation.beginTime = CACurrentMediaTime() + upRotation.duration;
    //Con la siguiente frase decimos que queremos que la animación se congele en su estado inicial.
    downRotation.fillMode = kCAFillModeBackwards;
    downRotation.delegate = self;
    flipNumber2.hidden = NO;
    [flipNumber2 addAnimation:downRotation forKey:@"transform"];
    
}



- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    downNumber.contents = flipNumber2.contents;
    flipNumber1.contents = upNumber.contents;
}




-(IBAction)sumaAhora:(id)sender{
    
    i = i+1;
    
    if (i<=9) {
    NSString *upBack = [[NSString alloc] initWithFormat:@"sup%d.png",i];
    upNumber.contents = (id) [UIImage imageNamed:upBack].CGImage;
    
    
    NSString *downBack = [[NSString alloc] initWithFormat:@"inf%d.png",i];
    flipNumber2.contents = (id) [UIImage imageNamed:downBack].CGImage;
    } else{
        i=0;
        NSString *upBack = [[NSString alloc] initWithFormat:@"sup%d.png",i];
        upNumber.contents = (id) [UIImage imageNamed:upBack].CGImage;
        
        
        NSString *downBack = [[NSString alloc] initWithFormat:@"inf%d.png",i];
        flipNumber2.contents = (id) [UIImage imageNamed:downBack].CGImage;
    }

    [self suma];

}


- (void)dealloc {
    [super dealloc];
}
@end
